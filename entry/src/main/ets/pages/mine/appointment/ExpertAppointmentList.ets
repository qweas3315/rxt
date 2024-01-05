/**
 * 专家预约管理
 */
import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import { AppConfig } from '../../../config';
import http from '@ohos.net.http';
import { IReserve } from '../../../model/reserve';
import { deleteReserveApi, getExpertReserveApi, updateReserveApi } from '../../../api/reserve';
import { IResponse } from '../../../model/common';

@Entry
@Component
struct ExpertAppointmentList {
  @State isShow: boolean = false
  @State reserveList: Array<IReserve> = [];
  @State reserve: IReserve = {}
  @State isEdit: boolean = false;
  private scroller: Scroller = new Scroller()

  async handleLoadReserve() {
    try {
      const res = await getExpertReserveApi()
      const data: IResponse<Array<IReserve>> = <IResponse<Array<IReserve>>> JSON.parse(res.result.toString())
      data.data.forEach((item: IReserve) => {
        this.reserveList.push(item)
      })
      this.reserveList.push({
        address: 'string',
        answer: 'string',
        area: 'string',
        expertName: 'string',
        id: 2,
        message: 'string',
        phone: 'string',
        plantCondition: 'string',
        plantDetail: 'string',
        plantName: 'string',
        questioner: 'string',
        soilCondition: 'string',
        status: 1
      })
    } catch (error) {
      console.error('handleLoadReserve.error: ', error.message)
    }
  }

  async handleConfirmReserve(data: IReserve) {
    data.status = 1
    try {
      const res = await updateReserveApi(data)
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '修改成功!',
          duration: 1000,
        });
        setTimeout(() => {
          router.replaceUrl({ url: 'pages/mine/appointment/ExpertAppointmentList' })
        }, 2000)
      } else {
        promptAction.showToast({
          message: '修改失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleConfirmReserve.error: ', error.message)
    }
  }

  async handleDeleteReserve(data: IReserve) {
    AlertDialog.show({
      title: '提示',
      message: "你确定要删除[" + data.expertName + "]的预约吗?",
      primaryButton: {
        value: '取消',
        action: () => {
        }
      },
      secondaryButton: {
        value: '删除',
        action: async () => {
          try {
            const res = await deleteReserveApi(<string> <unknown> data.id)
            const code = JSON.parse(res.result.toString()).code;
            if (code == 20000) {
              promptAction.showToast({
                message: '删除成功!',
                duration: 1000,
              });
              router.replaceUrl({ url: 'pages/mine/appointment/ExpertAppointmentList' })
            } else {
              promptAction.showToast({
                message: '删除失败!',
                duration: 2000,
              });
            }
          } catch (error) {
            console.error('handleConfirmReserve.error: ', error.message)
          }
        }
      }
    })
  }

  aboutToAppear() {
    this.handleLoadReserve()
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
          .onClick(() => router.back())
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      Scroll(this.scroller) {
        List() {
          ForEach(this.reserveList, (item: IReserve) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.plantName)
                    .margin(3)
                    .fontWeight(FontWeight.Bolder)
                  Text(item.plantDetail)
                    .margin(3)
                  Text("咨询者:" + item.questioner)
                    .margin(3)
                  Text("联系方式:" + item.phone)
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
                      this.reserve = item
                      this.isShow = true
                    })
                  if (item.status == 0) {
                    Text("确认预约")
                      .margin({ right: 10 })
                      .onClick(() => this.handleConfirmReserve(item))
                  }
                  Text("删除")
                    .margin({ right: 10 })
                    .onClick(() => this.handleDeleteReserve(item))
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
      }
      .margin({ top: 60, bottom: 60 })
      .width('100%')
      .layoutWeight(1)

      Panel(this.isShow) {
        Row() {
          Column() {
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
                .onClick(() => router.back())
            }
            .height(60)
            .width('100%')
            .margin({ top: 10 })

            Column() {
              List() {
                ListItem() {
                  Row() {
                    Text('种植作物:')
                      .width(120)
                    Text(this.reserve.plantName)
                  }
                }
                .padding({ left: 20, right: 20 })
                .height(60)

                ListItem() {
                  Row() {
                    Text('作物详细信息:')
                      .width(120)
                    Text(this.reserve.plantDetail)
                  }
                }
                .padding({ left: 20, right: 20 })
                .height(60)

                ListItem() {
                  Row() {
                    Text('地址:')
                      .width(120)
                    Text(this.reserve.address)
                  }
                }
                .padding({ left: 20, right: 20 })
                .height(60)

                ListItem() {
                  Row() {
                    Text('土壤条件:')
                      .width(120)
                    Text(this.reserve.soilCondition)
                  }
                }
                .padding({ left: 20, right: 20 })
                .height(60)

                ListItem() {
                  Row() {
                    Text('面积:')
                      .width(120)
                    Text(this.reserve.area + "亩")
                  }
                }
                .padding({ left: 20, right: 20 })
                .height(60)

                ListItem() {
                  Row() {
                    Text('作物条件:')
                      .width(120)
                    Text(this.reserve.plantCondition)
                  }
                }
                .padding({ left: 20, right: 20 })
                .height(60)

                ListItem() {
                  Row() {
                    Text('预约状态:')
                      .width(120)
                    if (this.reserve.status == 0) {
                      Text('未处理')
                        .backgroundColor('#fef0f0')
                        .fontColor('#f56c6c')
                        .margin(3)
                        .padding(5)
                    } else {
                      Text('已处理')
                        .backgroundColor('#409eff')
                        .fontColor('#f5f7fa')
                        .margin(3)
                        .padding(5)
                    }
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
              Button("取消")
                .type(ButtonType.Normal)
                .onClick(() => this.isShow = false)
            }
          }
          .width('100%')

        }
        .height('100%')
        .backgroundImage($r('app.media.bg'))
        .backgroundImageSize(ImageSize.Cover)
      }
      .type(PanelType.Foldable).mode(PanelMode.Full)
      .halfHeight(500)
      .dragBar(false)
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}
