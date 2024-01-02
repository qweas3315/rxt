import { builderCellItem, CellTitle } from './Common'

interface IInfoItem {
  icon: Resource;
  title: string;
}

@Preview
@Component
export default struct FinancingInfo {
  private financingList: Array<IInfoItem> = [
    { icon: $r('app.media.message_dots'), title: '智能匹配' },
    { icon: $r('app.media.notes'), title: '融资申请' },
    { icon: $r('app.media.star'), title: '我的融资' }
  ]

  build() {
    Column() {
      CellTitle({ title: '融资信息' })
      List() {
        ForEach(this.financingList, (item: IInfoItem) => {
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