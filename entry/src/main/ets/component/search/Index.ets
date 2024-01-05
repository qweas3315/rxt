import router from '@ohos.router';
import { getOrderPage, searchAllByKeys } from '../../api/order';
import { AppConfig } from '../../config';
import { IPageInfo, IResponse } from '../../model/common';
import { IOrderInfo } from '../../model/order';
import { timeUtil } from '../../utils/common';

@Preview
@Component
export default struct SearchComponent {
  @State pageNum: number = 1;
  @State goodsList: Array<IOrderInfo> = [];
  @State keyword: string = '';
  private scroller: Scroller = new Scroller()

  async handleLoadGoodsPage(current: number) {
    this.pageNum = current
    try {
      const res = await getOrderPage(this.pageNum)
      const data: IResponse<IPageInfo<IOrderInfo>> = <IResponse<IPageInfo<IOrderInfo>>> JSON.parse(res.result.toString())
      data.data.list.forEach((item: IOrderInfo) => {
        this.goodsList.push(item)
      })
    } catch (error) {
      console.error('handleLoadGoodsPage.error: ', error.message)
    }
  }

  async handleSearch(current: number) {
    if (this.keyword.trim().length === 0) {
      this.handleLoadGoodsPage(1)
      return
    }
    this.pageNum = current
    try {
      const res = await searchAllByKeys({ keyword: this.keyword, pageNum: this.pageNum })
      const data: IResponse<IPageInfo<IOrderInfo>> = <IResponse<IPageInfo<IOrderInfo>>> JSON.parse(res.result.toString())
      data.data.list.forEach((item: IOrderInfo) => {
        this.goodsList.push(item)
      })
    } catch (error) {
      console.error('handleSearch.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleLoadGoodsPage(1);
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.Search_1'))
          .width(20)
          .height(20)
          .margin({ left: 10 })
        TextInput({ placeholder: '搜索' })
          .layoutWeight(1)
          .borderWidth(0)
          .borderRadius(1)
          .backgroundColor(Color.White)
          .height(50)
          .placeholderColor(Color.Gray)
          .onChange((value: string) => this.keyword = value)
        Text('确定')
          .margin({ right: 20 })
          .onClick(() => {
            this.goodsList = []
            this.handleSearch(1)
          })
      }
      .backgroundColor(Color.White)
      .width('95%')
      .margin(10)
      .borderRadius(5)

      if (this.goodsList.length > 0) {
        Scroll(this.scroller) {
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.goodsList, (item: IOrderInfo) => {
              Row() {
                Image(`${AppConfig.baseUrl}/file/${item.picture}`)
                  .width(100)
                  .height(100)
                  .borderRadius(10)
                  .margin({ right: 5 })
                Flex({ direction: FlexDirection.Column }) {
                  Row() {
                    Text(`[${item.type == 'goods' ? '供' : '需'}]${item.content}`)
                      .width(280)
                  }
                  .alignItems(VerticalAlign.Top)

                  Text('￥' + item.price)
                    .fontColor(Color.Red)
                    .height(20)
                    .lineHeight(20)
                    .flexGrow(1)
                  Row() {
                    Text(item.ownName)
                      .margin({ right: 5 })
                      .fontSize(12)
                    Text('|')
                      .fontSize(12)
                      .margin({ left: 10, right: 10 })
                    Text(timeUtil(item.createTime))
                      .fontSize(12)
                  }
                }
                .flexGrow(1)
                .height(100)
                .padding(5)
              }
              .width('100%')
              .height(120)
              .margin(5)
              .padding(10)
              .borderRadius(10)
              .onClick(() => {
                const routerList: Array<string> = globalThis.routerList;
                routerList.push(`${router.getState().path}${router.getState().name}`)
                globalThis.routerList = routerList
                router.replaceUrl({
                  url: 'pages/home/goods/GoodsSourcePurchaseDetail',
                  params: { 'goodsDetail': item }
                })
              })
              .shadow({ radius: 5, color: '#f2f2f2', offsetX: 5, offsetY: 5 })
              .backgroundColor('#ffffff')
            })
          }
          .width('100%')
          .margin({ bottom: 80 })
        }
        .scrollable(ScrollDirection.Vertical)
        .onScrollEdge(() => {
          if (this.keyword.trim().length === 0) {
            this.handleLoadGoodsPage(this.pageNum + 1)
          } else {
            this.handleSearch(this.pageNum + 1)
          }
        })
      } else {
        Text("没有符合条件的数据")
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}