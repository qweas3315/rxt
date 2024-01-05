import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { IUser } from '../../../model/user'

interface INavigator {
  title: string;
  icon: Resource;
  fun: () => void;
}

@Preview
@Component
export struct UserMineNavigator {
  private navigatorList: Array<INavigator> = [
    {
      title: '我的问答',
      icon: $r('app.media.3D'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/chat/MineChatList' })
        }
      }
    },
    {
      title: '我的预约',
      icon: $r('app.media.Clock1'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/appointment/MineAppointmentList' })
        }
      }
    },
    {
      title: '我的购买',
      icon: $r('app.media.car'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/goods/MinePurchasedGoodsList' })
        }
      }
    },
    {
      title: '我的售卖',
      icon: $r('app.media.Inbox'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/goods/MineSoldGoodsList' })
        }
      }
    },
  ]

  build() {
    Row() {
      ForEach(this.navigatorList, (item: INavigator) => {
        Blank()
        Column() {
          Image(item.icon)
            .width(30)
            .height(30)
          Text(item.title)
            .fontSize(14)
            .fontColor('#666666')
            .height(25)
        }
        .onClick(item.fun)
      })
      Blank()
    }
    .width(351)
    .height(90)
    .backgroundColor('#FFFFFF')
    .margin({ top: -40, left: 12, right: 12 })
    .borderRadius(10)
    .shadow({ radius: 4, color: '#EBEBEB', offsetX: 0, offsetY: 2 })
    .justifyContent(FlexAlign.SpaceAround)
  }
}

@Preview
@Component
export struct AdminMineNavigator {
  build() {
    Row() {
      Text("欢迎管理员登录")
    }
    .width(351)
    .height(90)
    .margin({ top: -40, left: 12, right: 12 })
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .shadow({ radius: 4, color: '#EBEBEB', offsetX: 0, offsetY: 2 })
    .justifyContent(FlexAlign.SpaceAround)
  }
}

@Preview
@Component
export struct ExpertMineNavigator {
  @State userInfo: IUser | undefined = undefined
  private navigatorList: Array<INavigator> = [
    {
      title: '我的问答',
      icon: $r('app.media.3D'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/chat/ExpertChatManage' })
        }
      }
    },
    {
      title: '我的预约',
      icon: $r('app.media.Clock1'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/appointment/ExpertAppointmentList' })
        }
      }
    },
    {
      title: '我的知识',
      icon: $r('app.media.car'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/knowledge/ExpertKnowledgeList' })
        }
      }
    },
    {
      title: '专家信息',
      icon: $r('app.media.Inbox'),
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/mine/setting/ExpertInformationChange' })
        }
      }
    },
  ]

  build() {
    Row() {
      ForEach(this.navigatorList, (item: INavigator) => {
        Blank()
        Column() {
          Image(item.icon)
            .width(30)
            .height(30)
          Text(item.title)
            .fontSize(14)
            .fontColor('#666666')
            .height(25)
        }
        .onClick(item.fun)
      })
      Blank()
    }
    .width(351)
    .height(90)
    .backgroundColor('#FFFFFF')
    .margin({ top: -40, left: 12, right: 12 })
    .borderRadius(10)
    .shadow({ radius: 4, color: '#EBEBEB', offsetX: 0, offsetY: 2 })
    .justifyContent(FlexAlign.SpaceAround)
  }
}