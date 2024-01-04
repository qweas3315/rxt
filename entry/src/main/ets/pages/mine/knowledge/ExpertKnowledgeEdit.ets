/**
 * 专家知识编辑
 */
import router from '@ohos.router'
import request from '@ohos.request';
import promptAction from '@ohos.promptAction';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs'
import common from '@ohos.app.ability.common';
import { AppConfig } from '../../../config';
import http from '@ohos.net.http';

//获取应用文件路径
let context = getContext(this) as common.UIAbilityContext;

@Entry
@Component
struct ExpertKnowledgeEdit {
  @State info:any={};
  @State img:string=''
  @State type: string = ''
  @State content: string = ''
  @State picture: string = ''
  @State title: string = ''
  @State price: string = ''
  @State isShow: boolean = false
  private uploadTask: request.UploadTask;
  @State resultMsg: string = ''
  @State imgDatas: string[] = [];

  // 获取照片url集
  getAllImg() {
    let photoPicker = new picker.PhotoViewPicker();
    let result = new Array<string>();
    try {
      let PhotoSelectOptions = new picker.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 1;
      let photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
        this.imgDatas = PhotoSelectResult.photoUris;
        this.img=this.imgDatas[0];
        this.writeImage()
      }).catch((err) => {
      });
    } catch (err) {
    }
  }

  //写文件
  writeImage() {
    let URI = this.imgDatas[0]
    let cacheDir = getContext(this).cacheDir
    let srcFile = fs.openSync(URI, fs.OpenMode.READ_ONLY);
    let destFile = fs.openSync(cacheDir + "/file.png", fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    // 读取源文件内容并写入至目的文件
    let bufSize = 4096;
    let readSize = 0;
    let buf = new ArrayBuffer(bufSize);
    let readLen = fs.readSync(srcFile.fd, buf, { offset: readSize });
    while (readLen > 0) {
      readSize += readLen;
      fs.writeSync(destFile.fd, buf);
      readLen = fs.readSync(srcFile.fd, buf, { offset: readSize });
    }
    // 关闭文件
    fs.closeSync(srcFile);
    fs.closeSync(destFile);
    this.uploadFile();
    //this.picture="7161ea47f95a49a0b3508201c9fe3098.jpg"

  }

  uploadFile() {
    let url=AppConfig.baseUrl+'/file/upload/order';
    //上传任务配置项
    let uploadConfig = {
      url: url,
      header: { Authorization: globalThis.token },
      method: 'POST',
      files: [
        { filename: '', name: 'file', uri: "internal://cache/file.png", type: 'image/png' }
      ],
      data: []
    }
    //将本地应用文件上传至网络服务器
    try {
      request.uploadFile(context, uploadConfig)
        .then((data) => {
          this.uploadTask = data
          this.uploadTask.on("headerReceive", (header) => {
            let str = JSON.stringify(header);
            let begin = str.indexOf("filename=")+"filename=".length;
            let end = str.indexOf("\\r\\n",begin)
            let fileName = str.substring(begin, end);
            this.picture=fileName;
          })

        })
        .catch((err) => {
          console.info("===============", `xxInvokeuploadFilefailed,codeis${err.code},messageis${err.message}`);
        })
    } catch (err) {
      console.info("===============", `xxInvokeuploadFilefailed,codeis${err.code},messageis${err.message}`);
    }
  }

  //获取商品类型
  aboutToAppear() {
    this.info = router.getParams()['info'];
    console.info("================info",JSON.stringify(this.info))
    this.img=`${AppConfig.baseUrl}/file/${this.info.picPath}`;
    console.info("==================img",this.img)
    console.info("==================img",`${AppConfig.baseUrl}/file/${this.info.picPath}`)
  }

  build() {
    Stack() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('修改信息')
            .width('100%')
            .height(60)
            .fontSize(20)
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontColor(Color.Grey)

          Image($r('app.media.iv_back_selected')).width(40).height(40)
            .onClick(() => {
              router.back();
            }).margin({ left: 10 })
        }.height(60).width('100%').margin({ top: 10 })

        Row() {
          Text("设置照片").fontSize(14).fontColor(Color.Gray)
        }.height(40).justifyContent(FlexAlign.Start).width('100%').padding({ left: 20, right: 20 })
        Column() {
          //基本信息
          List() {
            ListItem() {
              Row() {
                Text('照片:').width(40)
                Image(this.img)
                  .width(150)
                  .height(150)
                  .borderRadius(10).margin({ left: 10 })
                Column() {
                  Image($r('app.media.camera')).width(40).height(40)
                  Text('添加照片').fontSize(16)
                }
                .onClick(() => {
                  this.isShow = true;
                })
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .width(150)
                .height(150)
                .borderRadius(10)
                .backgroundColor('#F1F3F5')
                .margin({ left: 10 })
              }
            }.padding({ left: 20, right: 20 }).height(180)
          }.divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 }) // 每行之间的分界线
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')

          //基本信息
          List() {
            ListItem() {
              Row() {
                Text('标题:').width(40)
                TextInput({ placeholder: '添加商品标题', text: this.info.title }).onChange((val) => {
                  this.info.title = val
                }).borderWidth(0).backgroundColor(Color.Transparent)
              }
            }.padding({ left: 20, right: 20 }).height(60)

            ListItem() {
              Row() {
                Text('内容:').width(40)
                TextArea({ placeholder: '添加商品内容', text: this.info.content }).onChange((val) => {
                  this.info.content = val
                }).borderWidth(0).backgroundColor(Color.Transparent)
                  .height(200)
              }
            }.padding({ left: 20, right: 20 }).height(200)
          }.divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 }) // 每行之间的分界线
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')
        }.layoutWeight(1)

        if (!this.isShow) {
          Row() {
            Button("保存")
              .fontColor(Color.White)
              .backgroundColor(Color.Red)
              .type(ButtonType.Normal)
              .width('100%')
              .borderRadius(20)
              .onClick(() => {
                updateKnowledge(this.info).then(rst=>{
                  let data=JSON.parse(rst.result.toString());
                  promptAction.showToast({
                    message: data.message,
                    duration: 1000,
                  });
                })
              })
          }.alignItems(VerticalAlign.Bottom).padding(10).backgroundColor('#ffffff')
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
              }.height(60).width('100%').justifyContent(FlexAlign.Center)
              .onClick(() => {
                this.getAllImg()
                this.isShow = false
              })
            }

            ListItem() {
              Row() {
                Text("取消")
              }.height(60).width('100%').justifyContent(FlexAlign.Center)
              .onClick(() => {
                this.isShow = false
              })
            }
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#ffffff')
          .divider({ strokeWidth: 1, color: "#f1f1f1" }) // 每行之间的分界线
          .borderRadius(20)
        }
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .fullHeight(120)
      .dragBar(false) // 默认开启
      .halfHeight(120) //
      .onChange((width: number, height: number, mode: PanelMode) => {
        console.info(`width:${width},height:${height},mode:${mode}`)
      })
    }
    .height('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

function updateKnowledge(info:any){
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/knowledge/${info.knowledgeId}'
  return req.request(
    url,
    {
      method:http.RequestMethod.PUT,
      header:{
        Authorization:globalThis.token
      },
      extraData:{
        content:info.content,
        knowledgeId:info.knowledgeId,
        title:info.title,
        picPath:info.picPath
      }
    })
}