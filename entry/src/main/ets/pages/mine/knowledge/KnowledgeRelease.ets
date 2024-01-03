/**
 * 知识发布
 */
import router from '@ohos.router'

@Entry
@Component
struct KnowledgeRelease {
  private scroller: Scroller = new Scroller()
  @State isShow: boolean = false

  build() {
    Stack() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('添加知识')
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
      }

      Row() {
        Text('设置照片')

      }


      // if(!this.isShow) {
      //   Row() {
      //     Button("保存")
      //       .fontColor(Color.White)
      //       .backgroundColor(Color.Red)
      //       .type(ButtonType.Normal)
      //       .width('100%')
      //       .borderRadius(20)
      //       .onClick( () => {
      //
      //       })
      //   }
      //   .alignItems(VerticalAlign.Bottom)
      //   .padding(10)
      //   .backgroundColor('#FFFFFF')
      //   .width('100%')
      // }
    }
  }
}