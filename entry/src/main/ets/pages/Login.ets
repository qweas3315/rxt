import router from '@ohos.router'
@Entry
@Component
struct Login {
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
              .onClick(() => router.back())
          }
          .height(60)
          .width('100%')
          .margin({ top: 10 })
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