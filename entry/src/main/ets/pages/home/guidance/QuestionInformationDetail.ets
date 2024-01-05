import router from '@ohos.router'
import { IQuestion } from '../../../model/question'

@Entry
@Component
struct QuestionInformationDetail {
  @State questionDetail: IQuestion = {}
  @State questionHeight: number = 0
  @State answerHeight: number = 0

  aboutToAppear() {
    this.questionDetail = router.getParams()['questionDetail']
    this.questionHeight = (this.questionDetail?.question?.length || 0) / 20 + 1
    this.answerHeight = (this.questionDetail?.answer?.length || 0) / 20 + 1
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('问答信息')
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
              const routerUrl = globalThis.routerList[0]
              globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
              router.replaceUrl({ url: routerUrl })
            })
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })

        Column() {
          Column() {
            Text(`提问者(${this.questionDetail?.questioner}):`)
              .fontSize(16)
              .width(300)
              .fontWeight(FontWeight.Bolder)
              .textAlign(TextAlign.End)
            Text(this.questionDetail?.question)
              .width(300)
              .padding({ right: 20, top: 5 })
              .fontSize(14)
          }
          .width('80%')
          .height(35 + this.questionHeight * 15)
          .border({ radius: 12, width: 1, color: '#95a5a6' })
          .backgroundColor('#D3E9FF')
          .margin({ right: 10, left: 70 })
          .padding({ top: 10 })

          Column() {
            Text(`专家(${this.questionDetail?.expertName}):`)
              .fontSize(14)
              .width(300)
              .fontWeight(FontWeight.Bolder)
              .margin({ right: 10 })
              .textAlign(TextAlign.Start)
            Text(this.questionDetail?.answer)
              .width(300)
              .padding({ right: 20, top: 5 })
              .fontSize(14)
          }
          .width('80%')
          .height(35 + this.answerHeight * 15)
          .border({ radius: 12, width: 1, color: '#95a5a6' })
          .margin({ top: 30, left: 10, right: 70, bottom: 10 })
          .borderWidth(1)
          .padding({ top: 10 })
        }
        .layoutWeight(1)
        .width('100%')
      }
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}