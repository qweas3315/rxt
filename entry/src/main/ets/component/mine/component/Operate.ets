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
export default struct OtherOperate {
  @State userInfo: IUser | undefined = undefined
  private otherOperateList: Array<IInfoItem> = [
    {
      icon: $r('app.media.nologin'),
      title: '注销',
      fun: () => {
        if (!globalThis.token) {
          promptAction.showToast({ message: "您未登录，无法注销！", duration: 2000 })
        } else {
          globalThis.token = ''
          globalThis.userInfo = null
          const routerList: Array<string> = globalThis.routerList;
          routerList.push(`${router.getState().path}${router.getState().name}`)
          globalThis.routerList = routerList
          router.replaceUrl({ url: 'pages/Index' })
        }
      }
    }
  ]

  build() {
    Column() {
      CellTitle({ title: '其他操作' })
      List() {
        ForEach(this.otherOperateList, (item: IInfoItem) => {
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