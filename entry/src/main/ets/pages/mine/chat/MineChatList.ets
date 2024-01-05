/**
 * 我的问答列表
 */
import router from '@ohos.router';
import { selectByKindApi } from '../../../api/question';
import { IResponse } from '../../../model/common';
import { IQuestion } from '../../../model/question';

@Entry
@Component
struct MineChatList {
  @State isShow: boolean = false
  @State questionList: Array<IQuestion> = [];
  @State question: IQuestion = {}

  async handleLoadQuestion() {
    try {
      const res = await selectByKindApi()
      const data: IResponse<Array<IQuestion>> = <IResponse<Array<IQuestion>>> JSON.parse(res.result.toString())
      this.questionList = data.data
    } catch (error) {
      console.error('handleUpdatePassword.error: ', error.message)
    }
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
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
        Image($r('app.media.iv_back_selected'))
          .width(40)
          .height(40)
          .margin({ left: 10 })
          .onClick(() => {
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      List() {
        ForEach(this.questionList, (item: IQuestion) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.title)
                  .margin(3)
                  .fontWeight(FontWeight.Bolder)
                Text(item.question)
                  .margin(3)
                Text("专家名称:" + item.expertName)
                  .margin(3)
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
            }
            .borderWidth(1)
            .borderRadius(10)
            .borderColor(Color.Grey)
            .margin(10)
            .padding(10)
            .width('95%')
          }
        })
      }
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
              .width(300)
          }
          .margin({ bottom: 20 })
          .width('100%')

          Row() {
            Text('专家姓名:')
              .width(90)
              .textAlign(TextAlign.End)
            Text(this.question.expertName)
          }
          .margin({ bottom: 20 })
          .width('100%')
          Row() {
            Text('回答内容:')
              .width(90)
              .textAlign(TextAlign.End)
            Text(this.question.answer)
              .width(300)
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
                .margin(3).padding(5)
            } else {
              Text('已回答')
                .backgroundColor('#409eff')
                .fontColor('#f5f7fa')
                .margin(3).padding(5)
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
      .halfHeight(350)
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}