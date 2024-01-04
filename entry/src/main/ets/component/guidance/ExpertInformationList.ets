import promptAction from '@ohos.promptAction'
import { getExpertListApi } from '../../api/question'
import { IPageInfo, IResponse } from '../../model/common'
import { IExpert } from '../../model/question'

@Preview
@Component
export default struct ExpertInformationList {
  @State expertList: Array<IExpert> = []
  @State pageNum: number = 1

  async handleLoadExpertList() {
    try {
      const res = await getExpertListApi(this.pageNum)
      const data: IResponse<IPageInfo<IExpert>> = <IResponse<IPageInfo<IExpert>>> JSON.parse(res.result.toString())
      if (data?.code === 20000) {
        data.data.list.forEach((item: IExpert) => {
          this.expertList.push(item)
        })
      } else {
        data && promptAction.showToast({ message: data.message, duration: 1000 })
      }
    } catch (error) {
      console.error('handleLoadExpertList.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleLoadExpertList()
  }

  build() {
    Column() {
      if (this.expertList.length > 0) {
        Column() {
          List() {
            ForEach(this.expertList, (item: IExpert) => {
              ListItem() {
                Row() {
                  Image($r('app.media.experta'))
                    .width(80)
                    .width(80)
                    .margin({ right: 10 })
                  Column() {
                    Text('专家姓名: ' + item.realName)
                      .fontSize(14)
                      .margin({ bottom: 15 })
                    Blank()
                    Text('职称: ' + item.position)
                      .fontSize(12)
                      .margin({ bottom: 10 })
                    Blank()
                    Text('从事专业: ' + item.profession)
                      .fontSize(12)
                      .margin({ bottom: 10 })
                    Blank()
                    Text('联系电话: ' + item.phone)
                      .fontSize(12)
                      .margin({ bottom: 10 })
                    Blank()
                    Text('单位: ' + item.belong)
                      .fontSize(12)
                      .margin({ bottom: 10 })
                    Blank()
                  }
                  .height('100%')
                  .alignItems(HorizontalAlign.Start)

                  Blank()
                  Column() {
                    Blank()
                    Text('向我提问')
                      .fontSize(14)
                    Blank()
                    Text('线下预约')
                      .fontSize(14)
                    Blank()
                  }
                  .height('100%')
                  .alignItems(HorizontalAlign.Start)
                }
                .padding({ left: 20, right: 20, bottom: 20, top: 20 })
                .width('100%').height(150)
              }
            })
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')
        }
        .layoutWeight(1)
        .width('100%')
      } else {
        Text('暂无数据')
          .margin({ top: 10 })
      }
    }
  }
}