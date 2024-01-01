@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder tabBuilder(title: string, index: number, selectedIcon: Resource, normalIcon: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedIcon : normalIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontColor(this.currentIndex === index ? '#059669' : '#94A388')
        .margin({ top: $r('app.float.tab_text_margin_top') })
        .fontSize(12)
        .fontFamily('宋体')
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Tabs({ index: this.currentIndex, controller: this.tabsController, barPosition: BarPosition.End }) {
        TabContent() {
          MineHeader()
        }.tabBar(this.tabBuilder('首页', 0, $r('app.media.home3'), $r('app.media.home1')))

        TabContent() {
          Text('这是搜索页')
        }.tabBar(this.tabBuilder('搜索', 1, $r('app.media.Search_3'), $r('app.media.Search_1')))

        TabContent() {
          Text('这是购物车')
        }.tabBar(this.tabBuilder('购物车', 2, $r('app.media.Bag'), $r('app.media.Bag2_3x')))

        TabContent() {
          Text('这是个人中心')
        }.tabBar(this.tabBuilder('我的', 3, $r('app.media.user_3'), $r('app.media.user_1')))
      }
      .barHeight(56)
      .onChange((index: number) => this.currentIndex = index)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}