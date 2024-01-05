/**
 * 预约专家
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { addReserveApi } from '../../../api/reserve';
import { IResponse } from '../../../model/common';
import { IReserve } from '../../../model/reserve'

@Entry
@Component
struct AppointmentExpert {
  @State reserve: IReserve = {
    address: '',
    area: '',
    expertName: '',
    phone: '',
    plantCondition: '',
    plantDetail: '',
    plantName: '',
    soilCondition: '',
    status: 0
  }

  async handleAddReserve() {
    try {
      const res = await addReserveApi(this.reserve)
      const data: IResponse<any> = <IResponse<any>> JSON.parse(res.result.toString())
      if (data?.code === 20000) {
        promptAction.showToast({
          message: '提交成功!',
          duration: 1000,
        });
        setTimeout(() => {
          const routerUrl = globalThis.routerList[0]
          globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
          router.replaceUrl({ url: routerUrl })
        }, 1000)
      } else {
        promptAction.showToast({ message: '提交失败!', duration: 2000 });
      }
    } catch (error) {
      console.error('handleAddReserve.error: ', error.message)
    }
  }

  aboutToAppear() {
    let expertName = router.getParams()["expertName"];
    this.reserve.expertName = expertName;
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('预约专家')
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
        List() {
          ListItem() {
            Row() {
              Text('地址:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.reserve.address = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('种植作物:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.reserve.plantName = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('作物详细信:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.reserve.plantDetail = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('作物条件:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.reserve.plantCondition = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('土壤条件:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.reserve.soilCondition = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('面积:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.reserve.area = value)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('电话:')
                .width(100)
              TextInput()
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
                .onChange((value: string) => this.reserve.phone = value)
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
        Button("保存")
          .fontColor(Color.White)
          .backgroundColor(Color.Red)
          .type(ButtonType.Normal)
          .width('100%')
          .borderRadius(20)
          .onClick(() => this.handleAddReserve())
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