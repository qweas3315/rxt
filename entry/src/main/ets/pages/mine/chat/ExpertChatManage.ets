/**
 * 专家问答管理
 */
import router from '@ohos.router'
import http from '@ohos.net.http';
import { AppConfig } from '../../../config';
import promptAction from '@ohos.promptAction';
import { IQuestion } from '../../../model/question';
import { deleteQuestionApi, getExpertQuestionApi } from '../../../api/question';
import { IResponse } from '../../../model/common';

@Entry
@Component
struct ExpertChatManage {
  @State isShow: boolean = false
  @State questionList: Array<IQuestion> = [];
  @State question: IQuestion = {}
  private scroller: Scroller = new Scroller()

  async handleLoadQuestion() {
    try {
      const res = await getExpertQuestionApi()
      const data: IResponse<Array<IQuestion>> = <IResponse<Array<IQuestion>>> JSON.parse(res.result.toString())
      data.data.forEach((item: IQuestion) => {
        this.questionList.push(item)
      })
    } catch (error) {
      console.error('handleLoadQuestion.error: ', error.message)
    }
  }

  handleDeleteQuestion(data: IQuestion, index: number) {
    AlertDialog.show({
      title: '提示',
      message: "你确定要删除[" + data.title + "]吗?",
      primaryButton: {
        value: '取消',
        action: () => {
        }
      },
      secondaryButton: {
        value: '删除',
        action: async () => {
          try {
            const res = await deleteQuestionApi(<string> <unknown> data.id)
            const code = JSON.parse(res.result.toString()).code;
            if (code == 20000) {
              promptAction.showToast({
                message: '删除成功!',
                duration: 1000,
              });
              this.questionList.splice(index, 1);
            } else {
              promptAction.showToast({
                message: '删除失败!',
                duration: 2000,
              });
            }
          } catch (error) {
            console.error('handleDeleteQuestion.error: ', error.message)
          }
        }
      }
    })
  }

  aboutToAppear() {
    this.handleLoadQuestion()
  }

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
          .margin({ left: 10 })
          .onClick(() => router.back())
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      Scroll(this.scroller) {
        List() {
          ForEach(this.questionList, (item: IQuestion, index: number) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.title)
                    .margin(3)
                    .fontWeight(FontWeight.Bolder)
                  Text(item.question)
                    .margin(3)
                  Text("提问者:" + item.questioner)
                    .margin(3)
                  Text("电话:" + item.phone)
                  if (item.status == 0) {
                    Text('未回答')
                      .backgroundColor('#fef0f0')
                      .fontColor('#f56c6c')
                      .margin(3)
                      .padding(5)
                  } else {
                    Text('已回答')
                      .backgroundColor('#409eff')
                      .fontColor('#f5f7fa')
                      .margin(3)
                      .padding(5)
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Row() {
                  Text("详情")
                    .margin({ right: 10 })
                    .onClick(() => {
                      this.isShow = true;
                      this.question = item;
                    })
                }

                if (item.status == 0) {
                  Text("回答")
                    .margin({ right: 10 })
                    .onClick(() => router.replaceUrl({
                      url: 'pages/mine/chat/QuestionAnswering',
                      params: { questionDetail: item }
                    }))
                } else {
                  Text("    ")
                    .margin({ right: 10 })
                }
                Text("删除")
                  .margin({ right: 10 })
                  .onClick(() => this.handleDeleteQuestion(item, index))
              }
            }
            .borderWidth(1)
            .borderRadius(10)
            .borderColor(Color.Grey)
            .margin(10)
            .padding(10)
            .width('95%')
          })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .margin({ top: 60, bottom: 60 })

      Panel(this.isShow) {
        Column() {
          Text('详情')
            .margin({ top: 10, bottom: 20 })
          Row() {
            Text('问题标题:')
              .width(90)
              .textAlign(TextAlign.End)
            Text(this.question.title)
          }
          .margin({ bottom: 20 })
          .width('100%')

          Row() {
            Text('问题内容:')
              .width(90)
              .textAlign(TextAlign.End)
            Text(this.question.question)
          }
          .margin({ bottom: 20 })
          .width('100%')

          Row() {
            Text('问题状态:')
              .width(90)
              .textAlign(TextAlign.End)
            if (this.question.status == 0) {
              Text('未回答')
                .backgroundColor('#fef0f0')
                .fontColor('#f56c6c')
                .margin(3)
                .padding(5)
            } else {
              Text('已回答')
                .backgroundColor('#409eff')
                .fontColor('#f5f7fa')
                .margin(3)
                .padding(5)
            }
          }
          .margin({ bottom: 20 })
          .width('100%')

          Row() {
            Button('取消')
              .type(ButtonType.Normal)
              .onClick(() => this.isShow = false)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .dragBar(true)
      .halfHeight(300)
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}