import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { IUser } from '../../../model/user'
import { builderCellItem, CellTitle } from './Common'

interface IInfoItem {
  icon: Resource;
  title: string;
  fun: () => void;
}

@Preview
@Component
export default struct FinancingInfo {
  @State userInfo: IUser | undefined = undefined
  private financingList: Array<IInfoItem> = [
    {
      icon: $r('app.media.message_dots'),
      title: '智能匹配',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/financing/RecommendFinanciers' })
        }
      }
    },
    {
      icon: $r('app.media.notes'),
      title: '融资申请',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/financing/BankInformationList' })
        }
      }
    },
    {
      icon: $r('app.media.star'),
      title: '我的融资',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/financing/MineFinancingInformationManage' })
        }
      }
    }
  ]

  aboutToAppear() {
    if (globalThis.userInfo) {
      this.userInfo = globalThis.userInfo
    }
  }

  build() {
    Column() {
      CellTitle({ title: '融资信息' })
      List() {
        ForEach(this.financingList, (item: IInfoItem) => {
          ListItem() {
            builderCellItem(item.title, item.icon, item.fun)
          }
        })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .divider({ strokeWidth: 1, color: '#F1F1F1', startMargin: 0, endMargin: 0 })
    }
  }
}