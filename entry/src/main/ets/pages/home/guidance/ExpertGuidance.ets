/**
 * 专家指导
 */
import router from '@ohos.router'
@Entry
@Component
struct ExpertGuidance {
  @State currentIndex: number = 1
  private tabsController: TabsController = new TabsController()

  @Builder TabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .margin({ top: $r('app.float.tab_text_margin_top') })
        .fontSize(20)
        .fontFamily("宋体")
        .fontColor(Color.White)
    }
    .backgroundColor(this.currentIndex === targetIndex ? '#059669' : '#94A3B8')
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('专家指导')
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.back();
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })

      Tabs({
        index: this.currentIndex,
        barPosition: BarPosition.Start
      }) {
        TabContent() {
          Text('问答列表')
        }
        .tabBar(this.TabBuilder('问答信息列表', 0))

        TabContent() {
          Text('专家列表')
        }
        .tabBar(this.TabBuilder('专家信息列表', 1))
      }
      .onChange((index) => this.currentIndex = index)
      .barHeight(56)
    }
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}