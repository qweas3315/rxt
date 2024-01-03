/**
 * 专家问答管理
 */
import router from '@ohos.router'

@Entry
@Component
struct ExpertChatManage {
  private scroller: Scroller = new Scroller()

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('信息问答')
          .width('100%')
          .height(60)
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
        Image($r('app.media.iv_back_selected'))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back()
          })
          .margin({ left: 10 })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      Scroll(this.scroller) {
        List() {

        }
      }
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}