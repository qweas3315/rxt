/**
 * 个人信息
 */
import request from '@ohos.request';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';
import { editUserInfoApi, getUserInfoApi } from '../../../api/user';
import { IResponse } from '../../../model/common';
import { IUser } from '../../../model/user';
import { AppConfig } from '../../../config';
import router from '@ohos.router';
import common from '@ohos.app.ability.common';

const context = getContext(this) as common.UIAbilityContext;

@Entry
@Component
struct PersonalInformation {
  @State userInfo: IUser = {}
  private uploadTask: request.UploadTask;
  @State isShow: boolean = false;
  @State imageList: Array<string> = [];

  handleLoadImageList() {
    try {
      const photoSelectOptions = new picker.PhotoSelectOptions();
      photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 1;
      const photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(photoSelectOptions)
        .then((PhotoSelectResult) => {
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
    this.uploadFile();
  }

  uploadFile() {
    let uploadConfig = {
      url: `${AppConfig.baseUrl}/file/upload/avatar`,
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
            this.userInfo.avatar = fileName
            this.userInfo.password = undefined
            editUserInfoApi(this.userInfo).then(_ => {
              globalThis.info = this.userInfo
            })
          })
        })
        .catch((error) => {
          console.error('request.uploadFile.error: ', error.message)
        })
    } catch (error) {
      console.error('uploadFile.error: ', error.message);
    }
  }

  async handleLoadUserInfo() {
    if (globalThis.userInfo) {
      console.info('handleLoadUserInfo: ', globalThis.userInfo)
      this.userInfo = globalThis.userInfo
      console.info('handleLoadUserInfo.this: ', JSON.stringify(this.userInfo))
      return
    }
    if (globalThis.token) {
      try {
        const res = await getUserInfoApi()
        const data: IResponse<IUser> = <IResponse<IUser>> JSON.parse(res.result.toString())
        if (data.code === 20000) {
          this.userInfo = data.data
          globalThis.userInfo = this.userInfo
        }
        console.info('handleLoadUserInfo.this.userInfo', this.userInfo)
      } catch (error) {
        console.error('getUserInfoApi.error: ', error.message)
      }
    }
  }

  aboutToAppear() {
    this.handleLoadUserInfo()
  }

  onPageShow() {
    this.handleLoadUserInfo()
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('个人信息')
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
        Image($r('app.media.iv_back_selected'))
          .width(40)
          .height(40)
          .margin({ left: 10 })
          .onClick(() => router.back())
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })
      .zIndex(100)

      Column() {
        List() {
          ListItem() {
            Row() {
              Text('头像:')
                .width(100)
              Blank()
              Image(`${AppConfig.baseUrl}/file/${this.userInfo.avatar}`)
                .width(70)
                .height(70)
                .borderRadius(35)
                .margin({ right: 20 })
              Image($r('app.media.chevron_right'))
                .width(16)
                .height(16)
            }
            .width('100%')
          }
          .padding({ left: 20, right: 20 })
          .height(80)
          .onClick(() => this.isShow = true
          )

          ListItem() {
            Row() {
              Text('基本信息:')
                .width(100)
              Blank()
              Image($r('app.media.chevron_right'))
                .width(16)
                .height(16)
            }
            .width('100%')
          }
          .padding({ left: 20, right: 20 }).height(80)
          .onClick(() => {
            globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
            router.replaceUrl({ url: 'pages/mine/setting/PersonalInformationChange' })
          })

          ListItem() {
            Row() {
              Text('修改密码:')
                .width(100)
              Blank()
              Image($r('app.media.chevron_right'))
                .width(16)
                .height(16)
            }
            .width('100%')
            .onClick(() => {
              globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
              router.replaceUrl({ url: 'pages/mine/setting/PasswordChange' })
            })
          }
          .padding({ left: 20, right: 20 })
          .height(80)

        }
        .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
        .borderRadius(10)
        .margin(5)
        .backgroundColor('#ffffff')
      }
      .width('100%')
      .margin({ top: 70 })
      .layoutWeight(1)

      Panel(this.isShow) {
        Column() {
          List() {
            ListItem() {
              Row() {
                Text("从手机相册选择")
              }
              .height(60)
              .width('100%')
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
              .height(60)
              .width('100%')
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
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}