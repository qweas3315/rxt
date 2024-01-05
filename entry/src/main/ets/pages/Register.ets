/**
 * 注册页面
 */
import router from '@ohos.router'
import { userRegisterApi } from '../api/user'
import { IResponse } from '../model/common'

@Entry
@Component
struct Register {
  @State userName: string = ''
  @State nickName: string = ''
  @State password: string = ''

  async handleRegister() {
    try {
      const res = await userRegisterApi({
        userName: this.userName,
        nickName: this.nickName,
        password: this.password,
        avatar: 'rongxiaotong.gif'
      })
      const data: IResponse<boolean> = <IResponse<boolean>> JSON.parse(res.result.toString())
      if (data.code === 20000) {
        AlertDialog.show({
          title: '提示',
          message: data.message,
          primaryButton: {
            value: '确定',
            action: () => {
              const routerList: Array<string> = globalThis.routerList
              const routerUrl = routerList.pop();
              globalThis.routerList = routerList;
              router.replaceUrl({ url: routerUrl })
            }
          }
        });
      } else {
        AlertDialog.show({
          title: '提示',
          message: <string> <unknown> data.data,
          primaryButton: {
            value: '确定',
            action: () => {
            }
          }
        });
      }
    } catch (error) {
      console.error('handleRegister.error: ', error.message)
    }
  }

  build() {
    Stack() {
      Row() {
      }
      .width('100%')
      .height('100%')
      .opacity(0.35)
      .backgroundImageSize(ImageSize.Contain)

      Row() {
        Column() {
          Stack({ alignContent: Alignment.Start }) {
            Text('用户注册')
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

          Row() {
            Text('账 号:')
              .fontSize(14)
              .margin({ left: 15 })
              .fontColor(Color.Grey)
            TextInput({ placeholder: '请输入账号' })
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Grey)
              .fontSize(12)
              .onChange((value: string) => this.userName = value)
          }
          .width('90%')
          .height(50)
          .margin({ top: 40 })
          .backgroundColor('#ffffff')
          .borderRadius(10)

          Row() {
            Text('用户名:')
              .fontSize(14)
              .margin({ left: 15 })
              .fontColor(Color.Grey)
            TextInput({ placeholder: '请输入用户名称' })
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Grey)
              .fontSize(12)
              .onChange((value: string) => this.nickName = value)
          }
          .width('90%')
          .height(50)
          .margin({ top: 40 })
          .backgroundColor('#ffffff')
          .borderRadius(10)

          Row() {
            Text('密 码:')
              .fontSize(14)
              .margin({ left: 15 })
              .fontColor(Color.Grey)
            TextInput({ placeholder: '请输入密码' })
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Grey)
              .fontSize(12)
              .type(InputType.Password)
              .onChange((value: string) => this.password = value)
          }
          .width('90%')
          .height(50)
          .margin({ top: 30 })
          .backgroundColor('#ffffff')
          .borderRadius(10)

          Row() {
            Text('确认密码:')
              .fontSize(14)
              .margin({ left: 15 })
              .fontColor(Color.Grey)
            TextInput({ placeholder: '请再次输入密码' })
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Grey)
              .fontSize(12)
              .type(InputType.Password)
          }
          .width('90%')
          .height(50)
          .margin({ top: 30 })
          .backgroundColor('#ffffff')
          .borderRadius(10)

          Row() {
            Button("注   册", { type: ButtonType.Normal })
              .width('100%')
              .height(50)
              .borderRadius(8)
              .backgroundColor('#ffffff')
              .fontColor(Color.Grey)
              .fontSize(16)
              .onClick(() => this.handleRegister())
          }
          .width('90%')
          .height(50)
          .margin({ top: 30 })

          Row() {
            Text("已有账号")
              .fontSize(14)
              .margin({ right: 10 })
            Text("登录")
              .fontSize(14)
              .margin({ right: 10 })
              .onClick(() => {
                const routerList: Array<string> = globalThis.routerList
                const routerUrl = routerList.pop();
                globalThis.routerList = routerList;
                router.replaceUrl({ url: routerUrl })
              })
          }
          .width('90%')
          .height(30)
          .margin({ top: 30 })
          .justifyContent(FlexAlign.End)
        }
        .width('100%')
        .height('100%')
      }
      .height('100%')
      .backgroundColor('#e0ebf4')
      .opacity(0.9)
    }
  }
}