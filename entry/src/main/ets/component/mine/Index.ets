import router from '@ohos.router'
import { getUserInfoApi } from '../../api/user'
import { AppConfig } from '../../config'
import { UserRoleEnum } from '../../enums/role'
import { IResponse } from '../../model/common'
import { IUser } from '../../model/user'
import PageHeader from '../header'
import BasicInfo from './component/Basic'
import FinancingInfo from './component/Financing'
import { UserMineNavigator, AdminMineNavigator, ExpertMineNavigator } from './component/Navigator'
import OtherOperate from './component/Operate'

@Preview
@Component
export default struct Mine {
  @State userInfo: IUser | undefined = undefined
  private scroller: Scroller = new Scroller();

  async aboutToAppear() {
    console.info('userInfo: ', globalThis.userInfo)
    if (globalThis.userInfo) {
      this.userInfo = globalThis.userInfo
      return
    }
    if (globalThis.token) {
      try {
        const res = await getUserInfoApi()
        const data: IResponse<IUser> = <IResponse<IUser>> JSON.parse(res.result.toString())
        if (data.code === 20000) {
          this.userInfo = data.data
          globalThis.userInfo = this.userInfo
        }
        console.info('this.userInfo', this.userInfo)
      } catch (error) {
        console.error('getUserInfoApi.error: ', error.message)
      }
    }
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        Column() {
          PageHeader({ title: '我的' })
          Row() {
            if (this.userInfo) {
              Image(`${AppConfig.baseUrl}/file/${this.userInfo.avatar}`)
                .width(70)
                .height(70)
                .borderRadius(35)
            } else {
              Image($r('app.media.nologin'))
                .width(70)
                .height(70)
                .borderRadius(35)
            }
            Row() {
              if (this.userInfo) {
                Column() {
                  Text(this.userInfo.userName)
                    .fontSize(18)
                    .fontColor('#FFFFFF')
                    .fontWeight(700)
                    .height(25)
                    .textAlign(TextAlign.Start)
                  Text(this.userInfo.phone)
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                    .fontWeight(400)
                    .height(20)
                    .textAlign(TextAlign.Start)
                }

                Row() {
                  Text('修改资料')
                    .height(30)
                    .fontSize(12)
                    .fontColor('#FFFFFF')
                    .margin({ right: 5 })
                  Image($r('app.media.chevron_right'))
                    .width(20)
                    .height(20)
                }
              } else {
                Text('登  录')
                  .fontSize(18)
                  .fontColor('#FFFFFF')
                  .fontWeight(700)
                  .height(25)
                  .onClick(() => router.pushUrl({ url: "pages/Login" }))
              }
            }
            .margin({ left: 17 })
            .justifyContent(FlexAlign.SpaceBetween)
            .flexGrow(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .height(67)
          .margin({ top: 20 })
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(185)
        .backgroundColor('#35ce3a')

        if (this.userInfo?.role === UserRoleEnum.ADMIN) {
          AdminMineNavigator()
        } else if (this.userInfo?.role === UserRoleEnum.EXPERT) {
          ExpertMineNavigator()
        } else {
          UserMineNavigator()
        }
        BasicInfo()
        FinancingInfo()
        OtherOperate()
      }
      .width('100%')
      .backgroundImageSize(ImageSize.Cover)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}