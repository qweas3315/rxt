/**
 * 专家预约管理
 */
import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import { AppConfig } from '../../../config';
import http from '@ohos.net.http';

@Entry
@Component
struct ExpertAppointmentList {
  @State isShow:boolean=false
  @State reserveList: any = [];
  @State item:any={}
  @State isEdit:boolean =false;
  scroller: Scroller = new Scroller()

  findExpertReserveAll(){
    findExpertReserveAll().then(rst=>{
      promptAction.showDialog({message: rst.result.toString()})
      let items=JSON.parse(rst.result.toString()).data;
      for(let item of items){
        this.reserveList.push(item);
      }
    })
  }

  aboutToAppear() {
    this.findExpertReserveAll()
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
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.back();
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })
      Scroll(this.scroller) {
        List() {
          ForEach(this.reserveList, (item, index) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.plantName).margin(3).fontWeight(FontWeight.Bolder)
                  Text(item.plantDetail).margin(3)
                  Text("咨询者:" + item.questioner).margin(3)
                  Text("联系方式:" + item.phone).margin(3)
                  Text("作物条件:" + item.plantCondition).margin(3)
                  Text("土壤条件:" + item.soilCondition)
                    .margin(3)
                  Text("面积:" + item.area + "亩").margin(3)
                  if (item.status == 0) {
                    Text('未处理').backgroundColor('#fef0f0').fontColor('#f56c6c').margin(3)
                  } else {
                    Text('已处理').backgroundColor('#409eff').fontColor('#f5f7fa').margin(3)
                  }
                }.alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Row() {
                  Text("详情").margin({ right: 10 }).onClick(() => {
                    this.item=item
                    this.isShow=true
                  })
                  if (item.status == 0) {
                    Text("确认预约").margin({ right: 10 })
                      .onClick(() => {
                        item.status=1
                        updateReserve(item).then(rst=>{
                          let code = JSON.parse(rst.result.toString()).code;
                          if (code == 20000) {
                            promptAction.showToast({
                              message: '修改成功!',
                              duration: 1000,
                            });
                            setTimeout(() => {
                              router.replaceUrl({url:'pages/info/expert/ExpertReserveAllPage'})
                            }, 2000)
                          } else {
                            promptAction.showToast({
                              message: '修改失败!',
                              duration: 2000,
                            });
                          }
                        })

                      })
                  }
                  Text("删除").margin({ right: 10 }).onClick(() => {
                    AlertDialog.show({
                      title: '提示',
                      message: "你确定要删除[" + item.expertName + "]的预约吗?",
                      primaryButton: {
                        value: '取消',
                        action: () => {
                        }
                      },
                      secondaryButton: {
                        value: '删除',
                        action: () => {
                          deleteExpertReserve(item.id).then((res)=>{
                            let code = JSON.parse(res.result.toString()).code;
                            if (code == 20000) {
                              promptAction.showToast({
                                message: '删除成功!',
                                duration: 1000,
                              });
                              router.replaceUrl({ url: 'pages/info/MyReservePage' })
                            } else {
                              promptAction.showToast({
                                message: '删除失败!',
                                duration: 2000,
                              });
                            }
                          })

                        }
                      }
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
          }, (item, index) => item + index)
        }
      }.margin({ top: 60, bottom: 60 }).width('100%').layoutWeight(1)
      Panel(this.isShow){
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
              Image($r('app.media.iv_back_selected')).width(40).height(40)
                .onClick(() => {
                  router.back();
                }).margin({ left: 10 })
            }.height(60).width('100%').margin({ top: 10 })

            Column() {
              //基本信息
              List() {
                ListItem() {
                  Row() {
                    Text('种植作物:').width(120)
                    Text(this.item.plantName)
                  }
                }.padding({ left: 20, right: 20 }).height(60)

                ListItem() {
                  Row() {
                    Text('作物详细信息:').width(120)
                    Text(this.item.plantDetail)
                  }
                }.padding({ left: 20, right: 20 }).height(60)

                ListItem() {
                  Row() {
                    Text('地址:').width(120)
                    Text(this.item.address)
                  }
                }.padding({ left: 20, right: 20 }).height(60)

                ListItem() {
                  Row() {
                    Text('土壤条件:').width(120)
                    Text(this.item.soilCondition)
                  }
                }.padding({ left: 20, right: 20 }).height(60)

                ListItem() {
                  Row() {
                    Text('面积:').width(120)
                    Text( this.item.area +"亩")
                  }
                }.padding({ left: 20, right: 20 }).height(60)

                ListItem() {
                  Row() {
                    Text('作物条件:').width(120)
                    Text( this.item.plantCondition)
                  }
                }.padding({ left: 20, right: 20 }).height(60)

                ListItem() {
                  Row() {
                    Text('预约状态:').width(120)
                    if (this.item.status == 0) {
                      Text('未处理').backgroundColor('#fef0f0').fontColor('#f56c6c').margin(3).padding(5)
                    } else {
                      Text('已处理').backgroundColor('#409eff').fontColor('#f5f7fa').margin(3).padding(5)
                    }
                  }
                }.padding({ left: 20, right: 20 }).height(60)

                // Row() {
                //   Button("取消")
                //     .type(ButtonType.Normal)
                //     .onClick(()=>{
                //     this.isShow=false
                //   })
                //
                // }
                // .padding({ left: 20, right: 20 }).height(60)
              }.divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 }) // 每行之间的分界线
              .borderRadius(10)
              .margin(5)
              .backgroundColor('#ffffff')
            }.layoutWeight(1)
            Row(){
              Button("取消")
                .type(ButtonType.Normal)
                .onClick(()=>{
                  this.isShow=false
                })
            }
          }
          .width('100%')

        }
        .height('100%')
        .backgroundImage($r('app.media.bg'))
        .backgroundImageSize(ImageSize.Cover)
      }
      .type(PanelType.Foldable).mode(PanelMode.Full)
      .halfHeight(500) // 默认一半
      .dragBar(false)
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

function updateReserve(item:any) {
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/reserve/update'
  return req.request(
    url,
    {
      method:http.RequestMethod.PUT,
      header:{
        Authorization:globalThis.token
      },
      extraData:{
        id:item.id,
        expertName:item.expertName,
        questioner:item.questioner,
        area:item.area,
        address:item.address,
        plantName:item.plantName,
        soilCondition:item.soilCondition,
        plantCondition:item.plantCondition,
        plantDetail:item.plantDetail,
        phone:item.phone,
        message:item.message,
        answer:item.answer,
        status:item.status
      }
    })
}

function deleteExpertReserve(id:string) {
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/reserve/delete/${id}'
  return req.request(
    url,
    {
      method:http.RequestMethod.DELETE,
      header:{
        Authorization:globalThis.token
      }
    })
}

function findExpertReserveAll() {
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/reserve/selectByKind/expert'
  return req.request(
    url,
    {
      method:http.RequestMethod.GET,
      header:{
        Authorization:globalThis.token
      }
    })
}