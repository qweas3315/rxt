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
export struct UserBasicInfo {
  private basicInfoList: Array<IInfoItem> = [
    {
      icon: $r('app.media.user'),
      title: '我的需求',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: 'pages/mine/goods/ReleaseGoodsList', params: { pageType: 'needs' } })
        }
      }
    },
    {
      icon: $r('app.media.tabler_credit_card'),
      title: '我发布的',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: 'pages/mine/goods/ReleaseGoodsList', params: { pageType: 'goods' } })
        }
      }
    },
    {
      icon: $r('app.media.map_pin'),
      title: '收货地址',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: 'pages/mine/address/MineShippingAddressManage' })
        }
      }
    }
  ]

  build() {
    Column() {
      CellTitle({ title: '基础信息' })
      List() {
        ForEach(this.basicInfoList, (item: IInfoItem) => {
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

@Preview
@Component
export struct ExpertBasicInfo {
  private basicInfoList: Array<IInfoItem> = [
    {
      icon: $r('app.media.fabu'),
      title: '发布知识',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: 'pages/mine/knowledge/KnowledgeRelease' })
        }
      }
    },
    {
      icon: $r('app.media.map_pin'),
      title: '收货地址',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: 'pages/mine/address/MineShippingAddressManage' })
        }
      }
    }
  ]

  build() {
    Column() {
      CellTitle({ title: '基础信息' })
      List() {
        ForEach(this.basicInfoList, (item: IInfoItem) => {
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

@Preview
@Component
export struct AdminBasicInfo {
  private basicInfoList: Array<IInfoItem> = [
    {
      icon: $r('app.media.user'),
      title: '用户管理',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: 'pages/mine/user/UserList' })
        }
      }
    },
    {
      icon: $r('app.media.goods'),
      title: '商品货源',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: '' })
        }
      }
    },
    {
      icon: $r('app.media.goods'),
      title: '求购需求',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "请先登录！", duration: 2000 })
        } else {
          router.pushUrl({ url: '' })
        }
      }
    }
  ]

  build() {
    Column() {
      CellTitle({ title: '基础信息' })
      List() {
        ForEach(this.basicInfoList, (item: IInfoItem) => {
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