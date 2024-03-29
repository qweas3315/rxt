/**
 * 专家指导
 */
import router from '@ohos.router'
import ExpertInformationList from '../../../component/guidance/ExpertInformationList'
import QuestionAnswerInformationList from '../../../component/guidance/QuestionAnswerInformationList'

@Entry
@Component
struct ExpertGuidance {
  @State currentIndex: number = 0
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
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })

      Tabs({
        index: this.currentIndex,
        barPosition: BarPosition.Start
      }) {
        TabContent() {
          QuestionAnswerInformationList()
        }
        .tabBar(this.TabBuilder('问答信息列表', 0))

        TabContent() {
          ExpertInformationList()
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