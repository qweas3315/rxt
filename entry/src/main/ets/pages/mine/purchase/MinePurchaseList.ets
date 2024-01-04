/**
 * 我的求购列表
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { deleteUserPurchaseGoods, getUserPurchaseGoodsList } from '../../../api/order';
import { AppConfig } from '../../../config';
import { IResponse } from '../../../model/common';
import { IOrderInfo } from '../../../model/order';

@Entry
@Component
struct MinePurchaseList {
  @State goodsList: Array<IOrderInfo> = [];
  @State pageNum: number = 1;
  private scroller: Scroller = new Scroller();

  async handleLoadPurchaseList() {
    try {
      const res = await getUserPurchaseGoodsList('needs', this.pageNum)
      const data: IResponse<Array<IOrderInfo>> = <IResponse<Array<IOrderInfo>>> JSON.parse(res.result.toString())
      data?.data.forEach((item: IOrderInfo) => this.goodsList.push(item))
      this.goodsList.push({
        address: 'address',
        content: 'content',
        cooperationName: 'cooperationName',
        createTime: 'createTime',
        orderId: 1,
        orderStatus: 0,
        ownName: 'ownName',
        picture: 'picture',
        price: 'price',
        title: 'title',
        type: 'type',
        updateTime: 'updateTime'
      })
    } catch (error) {
      console.error('MinePurchasedGoodsList.error: ', error.message)
    }
  }

  handleDeletePurchase(item: IOrderInfo, index: number) {
    AlertDialog.show({
      title: '提示',
      message: "你确定要删除[" + item.title + "]吗?",
      primaryButton: {
        value: '取消',
        action: () => {
        }
      },
      secondaryButton: {
        value: '删除',
        action: async () => {
          try {
            const res = await deleteUserPurchaseGoods(item.orderId)
            const code = JSON.parse(res.result.toString()).code;
            if (code == 20000) {
              promptAction.showToast({
                message: '删除成功!',
                duration: 1000,
              });
              this.goodsList.splice(index - 1, 1);
            } else {
              promptAction.showToast({
                message: '删除失败!',
                duration: 1000,
              });
            }
          } catch (error) {
            console.error('MinePurchasedGoodsList.error: ', error.message)
          }
        }
      }
    })
  }

  aboutToAppear() {
    this.handleLoadPurchaseList()
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('求购需求')
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
        Row() {
          Text('发布')
            .margin({ right: 10 })
            .onClick(() => router.replaceUrl({
              url: 'pages/mine/purchase/MinePurchaseRelease',
              params: { type: 'add' }
            }))
        }
        .justifyContent(FlexAlign.End).width('100%')

        Image($r('app.media.iv_back_selected'))
          .width(40)
          .height(40)
          .margin({ left: 10 })
          .onClick(() => router.back())
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      if (this.goodsList.length === 0) {
        Row() {
          Text('你还没发布任何信息，请去发布吧！')
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
      } else {
        Row() {
          Scroll(this.scroller) {
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
              ForEach(this.goodsList, (item, index) => {
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
                      Row() {
                        Text('编辑')
                          .fontSize(12)
                          .margin({ right: 5 })
                          .onClick(() => router.pushUrl({
                            url: 'pages/mine/purchase/MinePurchaseRelease',
                            params: { type: 'edit', purchaseInfo: item }
                          }))
                        Text('删除')
                          .fontSize(12)
                          .onClick(() => this.handleDeletePurchase(item, index))
                      }
                      .height(20)
                    }
                  }
                  .padding(5)
                }
                .width('47%')
                .height(260)
                .borderRadius(10)
                .backgroundColor('#ffffff')
                .opacity(0.8)
                .shadow({ radius: 5, color: Color.Gray, offsetX: 5, offsetY: 5 })
                .margin(5)
                .padding(10)
                .onClick(() => router.pushUrl({
                  url: 'pages/GoodsInfoPage',
                  params: { 'info': item }
                }))
              })
            }
            .width('100%')
          }
          .scrollable(ScrollDirection.Vertical)
          .onScrollEdge(() => {
            if (this.pageNum < globalThis.navigateLastPage) {
              this.pageNum += 1;
              this.handleLoadPurchaseList();
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(VerticalAlign.Top)
      }
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}