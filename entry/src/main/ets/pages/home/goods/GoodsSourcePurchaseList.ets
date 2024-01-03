/**
 * 商品货源和求购需求列表
 */
import router from '@ohos.router';
import { getGoodsPage } from '../../../api/order';
import { AppConfig } from '../../../config';
import { IPageInfo, IResponse } from '../../../model/common';
import { IOrderInfo } from '../../../model/order'

@Entry
@Component
struct GoodsSourceList {
  @State goodsList: Array<IOrderInfo> = []
  @State pageNum: number = 1
  @State type: string = '';
  private scroller: Scroller = new Scroller();

  async handleLoadGoodsPage() {
    try {
      const res = await getGoodsPage(this.type, this.pageNum)
      const data: IResponse<IPageInfo<IOrderInfo>> = <IResponse<IPageInfo<IOrderInfo>>> JSON.parse(res.result.toString())
      data.data.list.forEach((item: IOrderInfo) => {
        this.goodsList.push(item)
      })
    } catch (error) {
      console.error('handleLoadGoodsPage.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.type = router.getParams()['type'];
    this.handleLoadGoodsPage()
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Stack({ alignContent: Alignment.Start }) {
        Text(this.type == 'goods' ? '商品货源' : '求购需求')
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
        Image($r('app.media.iv_back_selected'))
          .width(40)
          .height(40)
          .margin({ left: 10 })
          .onClick(() => router.back())
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      Row() {
        Scroll(this.scroller) {
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.goodsList, (item: IOrderInfo) => {
              Column() {
                Image(`${AppConfig.baseUrl}/file/${item.picture}`)
                  .width('100%')
                  .height(160)
                  .borderRadius(10)
                Flex({ direction: FlexDirection.Column }) {
                  Text(`[${item.ownName}]`)
                    .margin({ right: 5 })
                  Text(`${item.content}`)
                    .height(30)
                    .lineHeight(30)
                  Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                    Text('￥' + item.price)
                      .fontColor(Color.Red)
                      .height(20)
                      .lineHeight(20)
                  }
                }
                .padding(5)
              }
              .width('47%')
              .height(260)
              .borderRadius(10)
              .backgroundColor('#ffffff')
              .opacity(0.8)
              .shadow({ radius: 5, color: '#f2f2f2', offsetX: 5, offsetY: 5 })
              .margin(5)
              .padding(10)
            })
          }.width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .onScrollEdge(() => {
          if (this.pageNum < globalThis.navigateLastPage) {
            this.pageNum += 1;
            this.handleLoadGoodsPage();
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}