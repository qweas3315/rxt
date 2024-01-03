/**
 * 首页导航
 */
import router from '@ohos.router'

interface IHomeNavigator {
  title: string;
  icon: Resource;
  path: string;
}

@Preview
@Component
export default struct HomeNavigator {
  private navigatorList: Array<IHomeNavigator> = [
    { title: '商品货源', icon: $r('app.media.image'), path: 'pages/home/goods/GoodsSourceList' },
    { title: '求购需求', icon: $r('app.media.icon2'), path: 'pages/home/purchase/PurchaseDemandList' },
    { title: '农业知识', icon: $r('app.media.icon3'), path: 'pages/home/knowledge/AgriculturalKnowledgeList' },
    { title: '专家指导', icon: $r('app.media.icon4'), path: 'pages/home/guidance/ExpertGuidance' }
  ]

  build() {
    Flex({ justifyContent: FlexAlign.SpaceAround }) {
      ForEach(this.navigatorList, (item: IHomeNavigator) => {
        Column() {
          Image(item.icon).width(70).margin({ bottom: 10 })
          Text(item.title).fontSize(14)
        }.onClick(() => router.pushUrl({ url: item.path }))
      })
    }.margin({ top: 20, bottom: 20 })
  }
}