interface INavigator {
  title: string;
  icon: Resource
}

@Preview
@Component
export default struct MineNavigator {
  private navigatorList: Array<INavigator> = [
    { title: '我的问答', icon: $r('app.media.3D') },
    { title: '我的预约', icon: $r('app.media.Clock1') },
    { title: '我的购买', icon: $r('app.media.car') },
    { title: '我的售卖', icon: $r('app.media.Inbox') },
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
      })
      Blank()
    }
    .width(350)
    .height(90)
    .backgroundColor('#FFFFFF')
    .margin({ top: 40, left: 12, right: 12 })
    .borderRadius(10)
    .shadow({ radius: 4, color: '#EBEBEB', offsetX: 2 })
    .justifyContent(FlexAlign.SpaceAround)
  }
}