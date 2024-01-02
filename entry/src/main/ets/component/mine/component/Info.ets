import router from '@ohos.router'
@Preview
@Component
export default struct MineCardInfo {
  @Prop isLogin: boolean

  build() {
    Row() {
      if (this.isLogin) {
        Text('登录')
      } else {
        Image($r('app.media.nologin'))
          .width(70)
          .borderRadius(35)
        Text('登 录')
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(700)
          .height(25)
          .onClick(() => router.pushUrl({url: 'pages/Login'}))
      }
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .height(67)
    .margin({ top: 20 })
    .alignItems(VerticalAlign.Center)
  }
}