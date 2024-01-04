/**
 * 用户列表
 */
import router from '@ohos.router'
import http from '@ohos.net.http'
import { AppConfig } from '../../../config'

@Entry
@Component
struct UserList {
  @State users:any = []
  private scroller: Scroller = new Scroller()
  baseUrl = 'http://101.201.59.201:9090'

  aboutToAppear() {
    findAllUser().then(rst=>{
      this.users=JSON.parse(rst.result.toString()).data.list;
    });
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('用户信息')
          .width('100%')
          .height(60)
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
        Image($r('app.media.iv_back_selected'))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back()
          })
          .margin({ left: 10 })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      List() {
        ListItem() {
          Row() {
            Text("姓名").width('20%').textAlign(TextAlign.Center).fontSize(12)
            Text("昵称").width('20%').textAlign(TextAlign.Center).fontSize(12)
            Text("角色").width('10%').textAlign(TextAlign.Center).fontSize(12)
            Text("电话").width('30%').textAlign(TextAlign.Center).fontSize(12)
            Text("操作").width('20%').textAlign(TextAlign.Center).fontSize(12)
          }.height(60).backgroundColor("#b0f4f4f4")
        }
      }

      Scroll(this.scroller) {
        Column(){
          List(){
            ForEach(this.users,(item,index)=>{
              ListItem(){
                Row(){
                  Text(item.userName).width('20%').textAlign(TextAlign.Center).fontSize(12)
                  Text(item.nickName).width('20%').textAlign(TextAlign.Center).fontSize(12)
                  Text(item.role).width('10%').textAlign(TextAlign.Center).fontSize(12)
                  Text(item.phone).width('30%').textAlign(TextAlign.Center).fontSize(12)
                  Text("明细").width('20%').textAlign(TextAlign.Center).fontSize(12)
                }.height(60).backgroundColor(index%2==0 ? "#b0e2eafc" : '#b0f1f1f1')
                .onClick(()=>{
                  router.pushUrl({url:'pages/admin/ShowUserInfoPage',params:{item:item}})
                })
              }
            }, item => item.userName);
          }.backgroundColor('#ffffff')
          .margin({bottom:5})
        }.width('100%').layoutWeight(1)
      }
    }.height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}
export const findAllUser = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/search/1`, {
    method: http.RequestMethod.GET,
    header: {
      Authorization: globalThis.token
    }
  })
}
// function findAllUser() {
//   return HttpManager.getInstance()
//     .request({
//       url:`http://101.201.59.201:9090/user`,
//       method:http.RequestMethod.GET,
//       header:{
//         Authorization:globalThis.token
//       }
//     })
// throw new Error('Function not implemented.');
// }
