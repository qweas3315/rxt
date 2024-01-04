/**
 * 发布商品
 */
import request from '@ohos.request';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import { IOrderInfo } from '../../../model/order';
import { AppConfig } from '../../../config';
import { addUserGoods, editUserGoods } from '../../../api/order';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

const context = getContext(this) as common.UIAbilityContext;

@Entry
@Component
struct ReleaseGoods {
  @State goods: IOrderInfo = {}
  @State imageList: Array<string> = []
  @State type: string = ''
  @State headTitle: string = ''
  @State isShow: boolean = false
  private uploadTask: request.UploadTask

  handleLoadImageList() {
    try {
      const PhotoSelectOptions = new picker.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 1;
      const photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
        this.imageList = PhotoSelectResult.photoUris;
        this.handleWriteImage()
      }).catch((error) => {
        console.error('photoPicker.select.error: ', error.message)
      });
    } catch (error) {
      console.error('handleLoadImageList.error: ', error.message)
    }
  }

  handleWriteImage() {
    const URI = this.imageList[0]
    const cacheDir = getContext(this).cacheDir
    const srcFile = fs.openSync(URI, fs.OpenMode.READ_ONLY);
    const tarFile = fs.openSync(cacheDir + "/file.png", fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    const bufSize = 4096;
    let readSize = 0;
    const buf = new ArrayBuffer(bufSize);
    let readLen = fs.readSync(srcFile.fd, buf, { offset: readSize });
    while (readLen > 0) {
      readSize += readLen;
      fs.writeSync(tarFile.fd, buf);
      readLen = fs.readSync(srcFile.fd, buf, { offset: readSize });
    }
    fs.closeSync(srcFile);
    fs.closeSync(tarFile);
    this.handleUploadFile();
  }

  handleUploadFile() {
    const uploadConfig = {
      url: `${AppConfig.baseUrl}/file/upload/order`,
      header: { Authorization: globalThis.token },
      method: 'POST',
      files: [
        { filename: '', name: 'file', uri: "internal://cache/file.png", type: 'image/png' }
      ],
      data: []
    }
    try {
      request.uploadFile(context, uploadConfig)
        .then((data) => {
          this.uploadTask = data
          this.uploadTask.on("headerReceive", (header) => {
            const headerStr = JSON.stringify(header);
            const begin = headerStr.indexOf("filename=") + "filename=".length;
            const end = headerStr.indexOf("\\r\\n", begin)
            const fileName = headerStr.substring(begin, end);
            this.goods.picture = fileName
          })
        })
        .catch((error) => {
          console.error('request.uploadFile.error: ', error.message)
        })
    } catch (error) {
      console.error('uploadFile.error: ', error.message);
    }
  }

  async handleAddGoods() {
    try {
      const res = await addUserGoods(this.goods)
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '添加成功!',
          duration: 1000,
        });
        setTimeout(() => {
          router.pushUrl({ url: 'pages/mine/goods/ReleaseGoodsList', params: { pageType: this.goods.type } })
        }, 1000)
      } else {
        promptAction.showToast({
          message: '添加失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleAddGoods.error: ', error.message)
    }
  }

  async handleEditGoods() {
    try {
      const res = await editUserGoods(this.goods)
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '修改成功!',
          duration: 1000,
        });
        setTimeout(() => {
          router.pushUrl({ url: 'pages/mine/goods/ReleaseGoodsList', params: { pageType: this.goods.type } })
        }, 1000)
      } else {
        promptAction.showToast({
          message: '修改失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleEditGoods.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.type = router.getParams()['type'];
    if (this.type == 'addNeeds' || this.type == 'addGoods') {
      this.headTitle = '添加商品信息'
    } else {
      this.headTitle = '修改商品信息'
      const goodsDetail = JSON.parse(router.getParams()['goodsDetail'])
      this.goods.orderId = goodsDetail.orderId
      this.goods.title = goodsDetail.title
      this.goods.price = goodsDetail.price
      this.goods.content = goodsDetail.content
      this.imageList = [`${AppConfig.baseUrl}/file/${goodsDetail.picture}`]
      this.goods.picture = goodsDetail.picture
    }
  }

  build() {
    Stack() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text(this.headTitle)
            .width('100%')
            .height(60)
            .fontSize(20)
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontColor(Color.Grey)

          Row() {
            Text('取消')
              .margin({ right: 10 })
              .onClick(() => {
                this.goods.title = ''
                this.goods.content = ''
                this.goods.picture = ''
                this.goods.price = ''
                this.isShow = false
                this.imageList = []
              })
          }
          .justifyContent(FlexAlign.End).width('100%')

          Image($r('app.media.iv_back_selected'))
            .width(40)
            .height(40)
            .margin({ left: 10 })
            .onClick(() => router.back())
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })

        Row() {
          Text("设置商品照片")
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .height(40)
        .justifyContent(FlexAlign.Start)
        .width('100%')
        .padding({ left: 20, right: 20 })

        Column() {
          List() {
            ListItem() {
              Row() {
                Text('照片:')
                  .width(40)
                if (this.imageList.length > 0) {
                  Image(this.imageList[0])
                    .width(150)
                    .height(150)
                    .borderRadius(10)
                    .margin({ left: 10 })
                }
                Column() {
                  Image($r('app.media.camera'))
                    .width(40)
                    .height(40)
                  Text('添加照片')
                    .fontSize(16)
                }
                .onClick(() => this.isShow = true)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .width(150)
                .height(150)
                .borderRadius(10)
                .backgroundColor('#F1F3F5')
                .margin({ left: 10 })
              }
            }
            .padding({ left: 20, right: 20 })
            .height(180)
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')

          Row() {
            Text("添加商品基本信息")
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .height(40)
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .padding({ left: 20, right: 20 })

          List() {
            ListItem() {
              Row() {
                Text('标题:')
                  .width(40)
                TextInput({ placeholder: '添加商品标题', text: this.goods.title })
                  .onChange((value: string) => this.goods.title = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Text('内容:')
                  .width(40)
                TextArea({ placeholder: '添加商品内容', text: this.goods.content })
                  .onChange((value: string) => this.goods.content = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
                  .height(100)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(120)

            ListItem() {
              Row() {
                Text('定价:')
                  .width(40)
                TextInput({ placeholder: '商品价格', text: this.goods.price })
                  .onChange((value: string) => this.goods.price = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }.padding({ left: 20, right: 20 }).height(60)
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')
        }
        .layoutWeight(1)

        if (!this.isShow) {
          Row() {
            Button("保存")
              .fontColor(Color.White)
              .backgroundColor(Color.Red)
              .type(ButtonType.Normal)
              .width('100%')
              .borderRadius(20)
              .onClick(() => {
                if (this.type == 'addNeeds' || this.type == 'editNeeds') {
                  this.goods.type = 'needs'
                } else if (this.type == 'addGoods' || this.type == 'editGoods') {
                  this.goods.type = 'goods'
                }
                if (this.type == 'addNeeds' || this.type == 'addGoods') {
                  this.handleAddGoods()
                } else if (this.type == 'editNeeds' || this.type == 'editGoods') {
                  this.handleEditGoods()
                }
              })
          }
          .alignItems(VerticalAlign.Bottom)
          .padding(10)
          .backgroundColor('#ffffff')
          .width('100%')
        }
      }
      .width('100%')

      Panel(this.isShow) {
        Column() {
          List() {
            ListItem() {
              Row() {
                Text("从手机相册选择")
              }
              .height(60).width('100%')
              .justifyContent(FlexAlign.Center)
              .onClick(() => {
                this.handleLoadImageList()
                this.isShow = false
              })
            }

            ListItem() {
              Row() {
                Text("取消")
              }
              .height(60).width('100%')
              .justifyContent(FlexAlign.Center)
              .onClick(() => this.isShow = false)
            }
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#ffffff')
          .divider({ strokeWidth: 1, color: "#f1f1f1" })
          .borderRadius(20)
        }
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .fullHeight(120)
      .dragBar(false)
      .halfHeight(120)
    }
    .height('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}