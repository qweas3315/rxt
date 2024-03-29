import router from '@ohos.router'
import { userLoginApi } from '../api/user'
import { IResponse } from '../model/common'

@Entry
@Component
struct Login {
  @State username: string = ''
  @State password: string = ''

  async handleLogin() {
    const res = await userLoginApi({ username: this.username, password: this.password })
    const data: IResponse<string> = <IResponse<string>> JSON.parse(res.result.toString())
    if (data.code == 20000) {
      globalThis.token = data.data
      const routerList: Array<string> = globalThis.routerList
      const routerUrl = routerList.pop();
      globalThis.routerList = routerList;
      router.replaceUrl({ url: routerUrl })
    } else {
      AlertDialog.show({
        title: '提示',
        message: "账号或密码有误",
        primaryButton: {
          value: '确定',
          action: () => {
          }
        }
      })
    }
  }

  build() {
    Stack() {
      Row() {
      }
      .width('100%')
      .height('100%')
      .backgroundImage($r('app.media.bj'))
      .opacity(0.35)
      .backgroundImageSize(ImageSize.Contain)

      Row() {
        Column() {
          Stack({ alignContent: Alignment.Start }) {
            Text('用户登录')
              .width('100%')
              .height(60)
              .textAlign(TextAlign.Center)
              .fontColor(Color.Gray)
            Image($r('app.media.iv_back_selected'))
              .width(40)
              .height(40)
              .margin({ left: 10 })
              .onClick(() => {
                router.replaceUrl({ url: 'pages/Index' })
              })
          }
          .height(60)
          .width('100%')
          .margin({ top: 10 })

          Image($r('app.media.log'))
            .width(140)
            .height(140)
            .margin({ top: 40 })
          Text('融销通')
            .fontColor('#a4cd3d')
            .fontSize(24)
            .margin(15)

          Row() {
            Text('账 号：')
              .fontSize(14)
              .margin({ left: 15 })
              .fontColor(Color.Gray)
            TextInput({ placeholder: '请输入账号', text: this.username })
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Gray)
              .fontSize(12)
              .onChange((value: string) => this.username = value)
          }
          .width('90%')
          .height(40)
          .margin({ top: 40 })
          .backgroundColor(Color.White)
          .borderRadius(10)

          Row() {
            Text('密 码：')
              .fontSize(14)
              .margin({ left: 15 })
              .fontColor(Color.Gray)
            TextInput({ placeholder: '请输入密码', text: this.password })
              .borderWidth(0)
              .backgroundColor(Color.Transparent)
              .flexGrow(1)
              .placeholderColor(Color.Gray)
              .fontSize(12)
              .type(InputType.Password)
              .onChange((value: string) => this.password = value)
          }
          .width('90%')
          .height(40)
          .margin({ top: 40 })
          .backgroundColor(Color.White)
          .borderRadius(10)

          Button('登 录', { type: ButtonType.Normal })
            .width('90%')
            .height(50)
            .margin({ top: 40 })
            .borderRadius(8)
            .backgroundColor(Color.White)
            .fontColor(Color.Gray)
            .fontSize(16)
            .onClick(() => this.handleLogin())
          Row() {
            Text("快速注册")
              .fontSize(14)
              .margin({ right: 10 })
              .onClick(() => {
                const routerList: Array<string> = globalThis.routerList;
                routerList.push(`${router.getState().path}${router.getState().name}`)
                globalThis.routerList = routerList
                router.replaceUrl({ url: "pages/Register" })
              })
          }
          .width('90%')
          .height(30)
          .margin({ top: 30 })
          .justifyContent(FlexAlign.End)
        }
        .width('100%')
        .height("100%")
      }
      .height('100%')
      .backgroundColor('#E0EBF4')
      .opacity(0.9)
    }
  }
}