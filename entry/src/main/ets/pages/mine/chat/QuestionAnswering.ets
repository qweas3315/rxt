/**
 * 回答问题
 */
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import http from '@ohos.net.http';
import { AppConfig } from '../../../config';
import { IQuestion } from '../../../model/question';
import { updateQuestionApi } from '../../../api/question';

@Entry
@Component
struct QuestionAnswering {
  @State questionDetail: IQuestion = {};

  async handleAnswerQuestion() {
    try {
      const res = await updateQuestionApi(this.questionDetail)
      console.info('handleAnswerQuestion: ', JSON.stringify(this.questionDetail))
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '操作成功!',
          duration: 2000,
        });
        setTimeout(() => {
          router.back()
        }, 2000)
      } else {
        promptAction.showToast({
          message: '操作失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleAnswerQuestion.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.questionDetail = router.getParams()['questionDetail']
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('问答问题')
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
            .onClick(() => router.back())
        }
        .height(60)
        .width('100%')
        .margin({ top: 10 })

        Column() {
          List() {
            ListItem() {
              Row() {
                Text('问题标题:')
                  .width(100)
                TextInput({ text: this.questionDetail.title })
                  .onChange((value: string) => this.questionDetail.title = value)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Text('内容:')
                  .width(100)
                Text(this.questionDetail.question)
                  .borderWidth(0)
                  .backgroundColor(Color.Transparent)
              }
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Text('回答:')
                  .width(100)
                TextInput({ text: this.questionDetail.answer })
                  .onChange((value: string) => this.questionDetail.answer = value)
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
        .layoutWeight(1)

        Row() {
          Button("回答")
            .fontColor(Color.White)
            .backgroundColor(Color.Red)
            .type(ButtonType.Normal)
            .width('100%')
            .borderRadius(20)
            .onClick(() => this.handleAnswerQuestion())
        }.alignItems(VerticalAlign.Bottom).padding(10).backgroundColor('#ffffff')
        .width('100%')
      }
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}