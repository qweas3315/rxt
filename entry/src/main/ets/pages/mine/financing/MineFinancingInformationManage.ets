/**
 * 我的融资信息管理
 */
import router from '@ohos.router'
@Entry
@Component
struct MineFinancingInformationManage {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text("融资信息")
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
          .margin({ top: 10 })
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })

    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
    .height('100%')
  }
}