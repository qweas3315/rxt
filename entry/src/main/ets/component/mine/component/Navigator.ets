interface INavigator {
  title: string;
  icon: Resource
}

@Preview
@Component
export struct UserMineNavigator {
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
  private navigatorList: Array<INavigator> = [
    { title: '我的问答', icon: $r('app.media.3D') },
    { title: '我的预约', icon: $r('app.media.Clock1') },
    { title: '我的知识', icon: $r('app.media.car') },
    { title: '专家信息', icon: $r('app.media.Inbox') },
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
    .width(351)
    .height(90)
    .backgroundColor('#FFFFFF')
    .margin({ top: -40, left: 12, right: 12 })
    .borderRadius(10)
    .shadow({ radius: 4, color: '#EBEBEB', offsetX: 0, offsetY: 2 })
    .justifyContent(FlexAlign.SpaceAround)
  }
}