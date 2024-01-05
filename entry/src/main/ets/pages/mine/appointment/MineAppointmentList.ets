/**
 * 我的预约列表
 */
import router from '@ohos.router';
import { getUserReserveApi } from '../../../api/reserve';
import { IResponse } from '../../../model/common';
import { IReserve } from '../../../model/reserve';

@Entry
@Component
struct AppointmentList {
  @State isShow: boolean = false
  @State appointmentList: Array<IReserve> = [];
  @State appointment: IReserve = {}
  @State isEdit: boolean = false;

  async handleReserveList() {
    try {
      const res = await getUserReserveApi()
      const data: IResponse<Array<IReserve>> = <IResponse<Array<IReserve>>> JSON.parse(res.result.toString())
      data.data.forEach((item: IReserve) => {
        this.appointmentList.push(item)
      })
    } catch (error) {
      console.error('handleReserveList.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleReserveList()
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('预约信息')
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

      List() {
        ForEach(this.appointmentList, (item: IReserve) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.plantName)
                  .margin(3)
                  .fontWeight(FontWeight.Bolder)
                Text("专家名称:" + item.expertName)
                  .margin(3)
                Text("作物条件:" + item.plantCondition)
                  .margin(3)
                Text("土壤条件:" + item.soilCondition)
                  .margin(3)
                Text("面积:" + item.area + "亩")
                  .margin(3)
                if (item.status == 0) {
                  Text('未处理')
                    .backgroundColor('#fef0f0')
                    .fontColor('#f56c6c')
                    .margin(3)
                } else {
                  Text('已处理')
                    .backgroundColor('#409eff')
                    .fontColor('#f5f7fa')
                    .margin(3)
                }
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Row() {
                Text("详情")
                  .margin({ right: 10 })
                  .onClick(() => {
                    globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
                    router.replaceUrl({
                      url: 'pages/mine/appointment/MineAppointmentDetail',
                      params: { appointmentDetail: item }
                    })
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

    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}