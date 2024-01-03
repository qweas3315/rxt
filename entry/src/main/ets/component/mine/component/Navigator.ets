import router from '@ohos.router'

interface INavigator {
  title: string;
  icon: Resource;
  fun: () => void;
}

@Preview
@Component
export struct UserMineNavigator {
  private navigatorList: Array<INavigator> = [
    { title: '我的问答', icon: $r('app.media.3D'), fun: () => router.pushUrl({ url: '' }) },
    { title: '我的预约', icon: $r('app.media.Clock1'), fun: () => router.pushUrl({ url: '' }) },
    { title: '我的购买', icon: $r('app.media.car'), fun: () => router.pushUrl({ url: '' }) },
    { title: '我的售卖', icon: $r('app.media.Inbox'), fun: () => router.pushUrl({ url: '' }) },
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
  private navigatorList: Array<INavigator> = [
    { title: '我的问答', icon: $r('app.media.3D'), fun: () => router.pushUrl({ url: '' }) },
    { title: '我的预约', icon: $r('app.media.Clock1'), fun: () => router.pushUrl({ url: '' }) },
    { title: '我的知识', icon: $r('app.media.car'), fun: () => router.pushUrl({ url: '' }) },
    { title: '专家信息', icon: $r('app.media.Inbox'), fun: () => router.pushUrl({ url: '' }) },
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