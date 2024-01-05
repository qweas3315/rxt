/**
 * 我的购买商品列表
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { getUserBuyGoods } from '../../../api/order';
import { AppConfig } from '../../../config';
import { IResponse } from '../../../model/common';
import { IOrderInfo } from '../../../model/order';

@Entry
@Component
struct MinePurchasedGoodsList {
  @State goodsList: Array<IOrderInfo> = [];
  @State status: Array<string> = ["", '已发货', "未发货"];
  @State colors: Array<string> = ["", "#C13AC23C", "#e2c25a3a"];

  async handleLoadUserBuys() {
    try {
      const res = await getUserBuyGoods()
      const data: IResponse<Array<IOrderInfo>> = <IResponse<Array<IOrderInfo>>> JSON.parse(res.result.toString())
      this.goodsList = data.data || []
    } catch (error) {
      console.error('MinePurchasedGoodsList.error: ', error.message)
    }
  }

  handleShowTime(content: string) {
    return content.substring(0, content.indexOf(".") - 3).replace("T", " ");
  }

  @Builder GoodsItem(item) {
    Row() {
      Image(AppConfig.baseUrl + "/file/" + item.picture)
        .width(90)
        .border({ width: 0.5, color: '#CFCFCF', radius: 5 })
        .margin({ top: 10, bottom: 10, right: 10 })
      Column() {
        Text("姓名:" + item?.ownName)
          .fontSize(14)
          .fontColor('#ff323232')
          .height('30%')
          .fontWeight(FontWeight.Bolder)
        Text("创建日期:" + this.handleShowTime(item?.createTime))
          .fontSize(14)
          .fontColor('#ff323232')
          .height('20%')
        Text("更新日期:" + this.handleShowTime(item?.updateTime))
          .fontSize(14)
          .fontColor('#ff323232')
          .height('20%')
        Text("收货地址:" + item?.address)
          .fontSize(14)
          .fontColor('#ff323232')
          .height('20%')
        Blank()
        Row() {
          Text('￥' + item?.totalPrice)
            .fontSize(15)
            .fontColor('#dc1c22')
          Blank()
          Text(this.status[item?.purchaseStatus])
            .fontColor(this.colors[item?.purchaseStatus])
            .fontSize(15)
        }
        .width('100%')
        .margin({ top: 5 })
        .alignItems(VerticalAlign.Bottom)
      }
      .layoutWeight(1)
      .height('100%')
      .padding({ top: 15, bottom: 15, right: 10 })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(120)
    .backgroundColor(Color.White)
    .margin({ bottom: 5 })
  }

  aboutToAppear() {
    this.handleLoadUserBuys()
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('我的购买')
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
          .onClick(() => {
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })
      .zIndex(1)

      if (!this.goodsList || this.goodsList.length === 0) {
        Column() {
          Image($r('app.media.illustration_3x'))
            .width(200)
            .height(200)
          Text("你还没有买商品")
            .fontSize(24)
            .fontColor('#0F172A')
            .height(50)
            .lineHeight(50)
            .fontWeight(400)
          Text('快去看看吧！')
            .fontSize(16)
            .fontColor('#64748B')
            .height(30)
            .lineHeight(30)
          Text('去购物')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#059669')
            .height(60)
            .width(260)
            .borderRadius(12)
            .margin({ top: 30 })
            .textAlign(TextAlign.Center)
            .fontWeight(400)
            .onClick(() => {
              globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
              router.replaceUrl({
                url: 'pages/home/goods/GoodsSourcePurchaseList',
                params: { 'type': 'goods' }
              })
            })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('100%').height('100%')
      } else {
        List() {
          ForEach(this.goodsList, (item: IOrderInfo) => {
            ListItem() {
              this.GoodsItem(item)
            }
          })
        }
        .layoutWeight(1)
      }
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}