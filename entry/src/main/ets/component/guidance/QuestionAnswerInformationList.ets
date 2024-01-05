import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { getQuestionList } from '../../api/question'
import { IPageInfo, IResponse } from '../../model/common'
import { IQuestion } from '../../model/question'

@Preview
@Component
export default struct QuestionAnswerInformationList {
  @State questionList: Array<IQuestion> = []
  @State pageNum: number = 1

  async handleLoadQuestion() {
    try {
      const res = await getQuestionList(this.pageNum)
      const data: IResponse<IPageInfo<IQuestion>> = <IResponse<IPageInfo<IQuestion>>> JSON.parse(res.result.toString())
      if (data?.code === 20000) {
        data.data.list.forEach((item: IQuestion) => {
          this.questionList.push(item)
        })
      } else {
        data && promptAction.showToast({ message: data.message, duration: 1000 })
      }
    } catch (error) {
      console.error('handleLoadQuestion.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleLoadQuestion()
  }

  build() {
    Column() {
      Column() {
        if (this.questionList.length > 0) {
          List() {
            ForEach(this.questionList, (item: IQuestion) => {
              ListItem() {
                Column() {
                  Row() {
                    Text(item.status == 0 ? '[问]' : '[答]')
                    Text(item.title)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)

                  Row() {
                    Text('提问者:' + item?.questioner)
                      .fontSize(12)
                      .margin({ right: 10 })
                    Text('专家:' + item.expertName)
                      .fontSize(12)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.End)
                }
                .padding({ left: 20, right: 20, bottom: 20, top: 20 })
                .width('100%')
                .onClick(() => router.pushUrl({
                  url: 'pages/home/guidance/QuestionInformationDetail',
                  params: { questionDetail: item }
                }))
              }
            })
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')
        } else {
          Text('暂无数据')
            .margin({ top: 10 })
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}