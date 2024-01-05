/**
 * 提问问题
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { IQuestion } from '../../../model/question'
import { addQuestionApi } from '../../../api/question';
import { IResponse } from '../../../model/common';

@Entry
@Component
struct AskQuestions {
  @State question: IQuestion = {
    expertName: '',
    phone: '',
    plantName: '',
    question: '',
    status: 0,
    title: ''
  }

  async handleAddQuestion() {
    try {
      const res = await addQuestionApi(this.question)
      const data: IResponse<any> = <IResponse<any>> JSON.parse(res.result.toString())
      if (data?.code === 20000) {
        promptAction.showToast({
          message: '提交成功!',
          duration: 1000,
        });
        setTimeout(() => {
          const routerList: Array<string> = globalThis.routerList
          const routerUrl = routerList.pop();
          globalThis.routerList = routerList;
          router.replaceUrl({ url: routerUrl })
        }, 1000)
      } else {
        promptAction.showToast({ message: '提交失败!', duration: 2000 });
      }
    } catch (error) {
      console.error('handleAddQuestion.error: ', error.message)
    }
  }

  aboutToAppear() {
    let expertName = router.getParams()["expertName"];
    this.question.expertName = expertName;
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('提问问题')
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

      Column() {
        List() {
          ListItem() {
            Row() {
              Text('标题:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.question.title = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('内容:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.question.question = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('农作物名称:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.question.plantName = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('手机号码:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.question.phone = value)
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
      .width('100%')
      .layoutWeight(1)


      Row() {
        Button("提交")
          .fontColor(Color.White)
          .backgroundColor(Color.Red)
          .type(ButtonType.Normal)
          .width('100%')
          .borderRadius(20)
          .onClick(() => this.handleAddQuestion())
      }
      .alignItems(VerticalAlign.Bottom)
      .padding(10)
      .backgroundColor('#ffffff')
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}