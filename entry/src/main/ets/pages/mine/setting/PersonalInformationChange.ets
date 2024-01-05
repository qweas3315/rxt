/**
 * 个人信息修改
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { IUser } from '../../../model/user';
import { editUserInfoApi, getUserInfoApi } from '../../../api/user';
import { IResponse } from '../../../model/common';

@Entry
@Component
struct PersonalInformationChange {
  @State userInfo: IUser = {};

  async handleEditInfo() {
    if (!/^1[3-9][0-9]{9}$/.test(this.userInfo.phone)) {
      promptAction.showToast({
        message: '手机号码输入有误!',
        duration: 2000,
      });
      return;
    }
    this.userInfo.password = undefined
    console.info('handleEditInfo: ', JSON.stringify(this.userInfo))
    const res = await editUserInfoApi(this.userInfo)
    try {
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '修改成功!',
          duration: 1000,
        });
        globalThis.info = this.userInfo
        setTimeout(() => {
          const routerList: Array<string> = globalThis.routerList
          const routerUrl = routerList.pop();
          globalThis.routerList = routerList;
          router.replaceUrl({ url: routerUrl })
        }, 1000)
      } else {
        promptAction.showToast({
          message: '修改失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleEditInfo.error: ', error.message)
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

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('修改个人信息')
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
          .onClick(() => {
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      Column() {
        List() {
          ListItem() {
            Row() {
              Text('昵称:')
                .width(100)
              TextInput({ text: this.userInfo.nickName })
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.userInfo.nickName = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('姓名:')
                .width(100)
              TextInput({ text: this.userInfo.realName })
                .onChange((value: string) => this.userInfo.realName = value)
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('手机号:')
                .width(100)
              TextInput({ text: this.userInfo.phone })
                .onChange((value: string) => this.userInfo.phone = value)
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('身份证:')
                .width(100)
              TextInput({ text: this.userInfo.identityNum })
                .onChange((value: string) => this.userInfo.identityNum = value)
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('地址:')
                .width(100)
              TextInput({ text: this.userInfo.address })
                .onChange((value: string) => this.userInfo.address = value)
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)
        }
        .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
        .borderRadius(10)
        .margin(5)
        .backgroundColor('#ffffff')
      }
      .width('100%')
      .layoutWeight(1)


      Row() {
        Button("保存")
          .fontColor(Color.White)
          .backgroundColor(Color.Red)
          .type(ButtonType.Normal)
          .width('100%')
          .borderRadius(20)
          .onClick(() => this.handleEditInfo())
      }
      .alignItems(VerticalAlign.Bottom).padding(10)
      .backgroundColor('#ffffff')
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}