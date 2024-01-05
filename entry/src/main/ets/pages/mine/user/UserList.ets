/**
 * 用户列表
 */
import router from '@ohos.router'
import http from '@ohos.net.http'
import { AppConfig } from '../../../config'
import { IUser } from '../../../model/user'
import { getUserListApi } from '../../../api/user'
import { IPageInfo, IResponse } from '../../../model/common'

@Entry
@Component
struct UserList {
  @State userList: Array<IUser> = []
  private scroller: Scroller = new Scroller()

  async handleLoadUserList() {
    try {
      const res = await getUserListApi()
      console.info('handleLoadUserList: ', res.result.toString())
      const data: IResponse<IPageInfo<IUser>> = <IResponse<IPageInfo<IUser>>> JSON.parse(res.result.toString())
      data?.data?.list.forEach((item: IUser) => {
        this.userList.push(item)
      })
    } catch (error) {
      console.error('handleLoadUserList.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleLoadUserList()
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('用户信息')
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
        ListItem() {
          Row() {
            Text("姓名")
              .width('20%')
              .textAlign(TextAlign.Center)
              .fontSize(12)
            Text("昵称")
              .width('20%')
              .textAlign(TextAlign.Center)
              .fontSize(12)
            Text("角色")
              .width('10%')
              .textAlign(TextAlign.Center)
              .fontSize(12)
            Text("电话")
              .width('30%')
              .textAlign(TextAlign.Center)
              .fontSize(12)
            Text("操作")
              .width('20%')
              .textAlign(TextAlign.Center)
              .fontSize(12)
          }
          .height(60)
          .backgroundColor("#b0f4f4f4")
        }
      }

      Scroll(this.scroller) {
        Column() {
          List() {
            ForEach(this.userList, (item, index) => {
              ListItem() {
                Row() {
                  Text(item?.userName)
                    .width('20%')
                    .textAlign(TextAlign.Center)
                    .fontSize(12)
                  Text(item?.nickName)
                    .width('20%')
                    .textAlign(TextAlign.Center)
                    .fontSize(12)
                  Text(item?.role)
                    .width('10%')
                    .textAlign(TextAlign.Center)
                    .fontSize(12)
                  Text(item?.phone)
                    .width('30%')
                    .textAlign(TextAlign.Center)
                    .fontSize(12)
                  Text("明细")
                    .width('20%')
                    .textAlign(TextAlign.Center)
                    .fontSize(12)
                }
                .height(60)
                .backgroundColor(index % 2 == 0 ? "#b0e2eafc" : '#b0f1f1f1')
                .onClick(() => {
                  globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
                  router.replaceUrl({ url: 'pages/mine/user/UserDetail', params: { userDetail: item } })
                })
              }
            });
          }
          .backgroundColor('#ffffff')
          .margin({ bottom: 5 })
        }
        .width('100%')
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height("100%")
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}