import router from '@ohos.router';
import ShoppingCart from '../component/cart/Index';
import Home from '../component/home/Index';
import Mine from '../component/mine';
import SearchComponent from '../component/search/Index';

interface ITab {
  title: string;
  index: number;
  selectedIcon: Resource;
  normalIcon: Resource;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabList: Array<ITab> = [
    { title: '首页', index: 0, selectedIcon: $r('app.media.home3'), normalIcon: $r('app.media.home1') },
    { title: '搜索', index: 1, selectedIcon: $r('app.media.Search_3'), normalIcon: $r('app.media.Search_1') },
    { title: '购物车', index: 2, selectedIcon: $r('app.media.Bag'), normalIcon: $r('app.media.Bag2_3x') },
    { title: '我的', index: 3, selectedIcon: $r('app.media.user_3'), normalIcon: $r('app.media.user_1') }
  ];

  @Builder tabBuilder({title, index, selectedIcon, normalIcon}: ITab) {
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

  aboutToAppear() {
    globalThis.routerList = []
    if (globalThis.lastHomeIndex == undefined) {
      this.currentIndex = 0
    } else {
      this.currentIndex = globalThis.lastHomeIndex
    }
    // if (globalThis?.currentHomeComponentIndex?.length > 0) {
    //   this.currentIndex = globalThis.currentHomeComponentIndex[0] || 0
    //   globalThis.currentHomeComponentIndex = []
    // } else {
    //   this.currentIndex = 0
    //   globalThis.currentHomeComponentIndex = []
    // }
  }

  build() {
    Column() {
      Tabs({ index: this.currentIndex, controller: this.tabsController, barPosition: BarPosition.End }) {
        ForEach(this.tabList, (tab: ITab) => {
          TabContent() {
            if (tab.index === 0) {
              Home()
            } else if (tab.index === 1) {
              SearchComponent()
            } else if (tab.index === 2) {
              ShoppingCart()
            } else if (tab.index === 3) {
              Mine()
            }
          }.tabBar(this.tabBuilder(tab))
        })
      }
      .barHeight(56)
      .onChange((index: number) => {
        this.currentIndex = index
        // const indexList: Array<number> = globalThis?.currentHomeComponentIndex || []
        // indexList.push(index)
        // globalThis.currentHomeComponentIndex = indexList
        // console.info('TabsChange: ', this.tabsController)
      })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}