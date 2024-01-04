/**
 * 知识发布
 */
import router from '@ohos.router'

@Entry
@Component
struct KnowledgeRelease {
  private scroller: Scroller = new Scroller()
  @State isShow: boolean = false
  @State info: any = {}
  @State title: string = ''
  @State content: string = ''
  @State type: string = ''
  @State img: string = ''
  @State picPath: string = ''

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

        Row() {
          Text('设置照片')
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .height(40)
        .justifyContent(FlexAlign.Start)
        .width('100%')
        .padding({ left: 20, right: 20 })

        Column() {
          List() {
            ListItem() {
              Row() {
                Text('照片:')
                  .width(40)
                Image(this.img) //添加好的照片
                  .width(150)
                  .height(150)
                  .borderRadius(10)
                  .margin({ left: 10 })
                Column() {
                  Image($r('app.media.camera'))
                    .width(40)
                    .height(40)
                  Text('添加照片')
                    .fontSize(16)
                }
                .onClick(() => { //点击添加照片

                })
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .width(150)
                .height(150)
                .borderRadius(10)
                .backgroundColor('#F1F3F5')
                .margin({ left: 10 })
              }
            }
            .padding({ left: 20, right: 20 })
            .height(180)
          }
          .divider({ strokeWidth: 1, color: 'F1F1F1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#FFFFFF')

          List() {
            ListItem() {
              Row() {
                Text('标题:')
                  .width(40)
                TextInput({ placeholder: '添加商品标题', text: this.info.title })
                  .onChange((val) => {
                    this.info.title = val
                  })
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Text('内容:')
                  .width(40)
                TextArea({ placeholder: '添加商品内容', text: this.info.content })
                  .onChange((val) => {
                    this.info.content = val
                  })
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
                  .height(200)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(200)
          }
          .divider({ strokeWidth: 1, color: 'F1F1F1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#FFFFFF')
        }
        .layoutWeight(1)

        if (!this.isShow) {
          Row() {
            Button("保存")
              .fontColor(Color.White)
              .backgroundColor(Color.Red)
              .type(ButtonType.Normal)
              .width('100%')
              .borderRadius(20)
              .onClick(() => {
                if (this.type = 'edit') {

                } else {

                }

              })
          }
          .alignItems(VerticalAlign.Bottom)
          .padding(10)
          .backgroundColor('#FFFFFF')
          .width('100%')
        }
      }
      .width('100%')

      Panel(this.isShow) {
        Column() {

        }
      }

    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}