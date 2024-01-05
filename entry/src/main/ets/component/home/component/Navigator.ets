/**
 * 首页导航
 */
import router from '@ohos.router'

interface IHomeNavigator {
  title: string;
  icon: Resource;
  fun: () => void;
}

@Preview
@Component
export default struct HomeNavigator {
  private navigatorList: Array<IHomeNavigator> = [
    {
      title: '商品货源',
      icon: $r('app.media.image'),
      fun: () => {
        globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
        router.replaceUrl({ url: 'pages/home/goods/GoodsSourcePurchaseList', params: { type: 'goods' } })
      }
    },
    {
      title: '求购需求',
      icon: $r('app.media.icon2'),
      fun: () => {
        globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
        router.replaceUrl({ url: 'pages/home/goods/GoodsSourcePurchaseList', params: { type: 'needs' } })
      }
    },
    {
      title: '农业知识',
      icon: $r('app.media.icon3'),
      fun: () => {
        globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
        router.replaceUrl({ url: 'pages/home/knowledge/AgriculturalKnowledgeList' })
      }
    },
    {
      title: '专家指导',
      icon: $r('app.media.icon4'),
      fun: () => {
        globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
        router.replaceUrl({ url: 'pages/home/guidance/ExpertGuidance' })
      }
    }
  ]

  build() {
    Flex({ justifyContent: FlexAlign.SpaceAround }) {
      ForEach(this.navigatorList, (item: IHomeNavigator) => {
        Column() {
          Image(item.icon).width(70).margin({ bottom: 10 })
          Text(item.title).fontSize(14)
        }.onClick(item.fun)
      })
    }.margin({ top: 20, bottom: 20 })
  }
}