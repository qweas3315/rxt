import { builderCellItem, CellTitle } from './Common'

interface IInfoItem {
  icon: Resource;
  title: string;
}

@Preview
@Component
export default struct UserBasicInfo {
  private basicInfoList: Array<IInfoItem> = [
    { icon: $r('app.media.user'), title: '我的需求' },
    { icon: $r('app.media.tabler_credit_card'), title: '我发布的' },
    { icon: $r('app.media.map_pin'), title: '收货地址' }
  ]

  build() {
    Column() {
      CellTitle({title: '基础信息'})
      List() {
        ForEach(this.basicInfoList, (item: IInfoItem) => {
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

@Preview
@Component
export struct ExpertBasicInfo {
  build() {

  }
}