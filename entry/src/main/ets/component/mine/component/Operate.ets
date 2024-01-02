import { builderCellItem, CellTitle } from './Common'

interface IInfoItem {
  icon: Resource;
  title: string;
}

@Preview
@Component
export default struct OtherOperate {
  private otherOperateList: Array<IInfoItem> = [
    { icon: $r('app.media.nologin'), title: '注销' }
  ]

  build() {
    Column() {
      CellTitle({ title: '其他操作' })
      List() {
        ForEach(this.otherOperateList, (item: IInfoItem) => {
          ListItem() {
            builderCellItem(item.title, item.icon)
          }
        })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .divider({ strokeWidth: 1, color: '#F1F1F1', startMargin: 0, endMargin: 0 })
    }
  }
}