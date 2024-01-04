/**
 * 专家问答管理
 */
import router from '@ohos.router'

@Entry
@Component
struct ExpertChatManage {
  @State isShow: boolean = false
  @State wenDaData: any = [];
  @State wenDa: any = {}
  private scroller: Scroller = new Scroller()

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('问答信息')
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
          ForEach(this.wenDaData, (item, index) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.title).margin(3).fontWeight(FontWeight.Bolder)
                  Text(item.question).margin(3)
                  Text("提问者:" + item.questioner).margin(3)
                  Text("电话:" + item.phone)
                  if (item.status == 0) {
                    Text('未回答').backgroundColor('#fef0f0').fontColor('#f56c6c').margin(3).padding(5)
                  } else {
                    Text('已回答').backgroundColor('#409eff').fontColor('#f5f7fa').margin(3).padding(5)
                  }
                }.alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Row() {
                  Text("详情").margin({ right: 10 }).onClick(() => {
                    this.isShow = true;
                    this.wenDa = item;
                  })
                }
              }
            }

          },(item, index) => item + index)

        }
      }
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}