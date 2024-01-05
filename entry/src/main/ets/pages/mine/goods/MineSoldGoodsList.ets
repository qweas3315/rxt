/**
 * 我的卖出商品列表
 */
import router from '@ohos.router';
import { getUserSellGoodsList } from '../../../api/order';
import { IResponse } from '../../../model/common';
import { IOrderInfo } from '../../../model/order';

@Entry
@Component
struct MineSoldGoodsList {
  @State goodsList: Array<IOrderInfo> = [];
  @State status: Array<string> = ["", '已发货', "未发货"];
  @State colors: Array<string> = ["", "#C13AC23C", "#e2c25a3a"];

  async handleLoadUserSellGoodsList() {
    try {
      const res = await getUserSellGoodsList()
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
      Column() {
        Text("姓名:" + item.ownName)
          .fontSize(16)
          .fontColor('#ff323232')
          .fontWeight(FontWeight.Bolder)
          .height('30%')
        Text("手机号码:" + item.phone)
          .fontSize(14)
          .fontColor('#ff323232')
          .height('20%')
        Text("收货地址:" + item.address)
          .fontSize(14)
          .fontColor('#ff323232')
          .height('20%')
        Text("创建日期:" + this.handleShowTime(item.createTime))
          .fontSize(14)
          .fontColor('#ff323232')
          .height('20%')
      }
      .layoutWeight(1)
      .height('100%')
      .padding({ top: 15, bottom: 15, right: 10 })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(HorizontalAlign.Start)
      Column() {
        Text('￥' + item.uninPricee)
          .fontSize(30)
          .fontColor('#dc1c22')
          .layoutWeight(1)
        Text(this.status[item.purchaseStatus])
          .fontColor(this.colors[item.purchaseStatus])
          .fontSize(15)
          .height('20%')
          .height(30)
      }
      .width(100)
      .margin({ top: 5 })
    }
    .width('100%')
    .height(120)
    .backgroundColor(Color.White)
    .margin({ bottom: 5 })
    .padding({ left: 10, right: 10 })
  }
  aboutToAppear() {
    this.handleLoadUserSellGoodsList()
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('我的售卖')
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
      .zIndex(1)

      if (!this.goodsList || this.goodsList.length == 0) {
        Column() {
          Image($r('app.media.illustration_3x'))
            .width(200)
            .height(200)
          Text("你商品还没有人买")
            .fontSize(24)
            .fontColor('#0F172A')
            .height(50)
            .lineHeight(50)
            .fontWeight(400)
          Text('稍等一下再看看吧！')
            .fontSize(16)
            .fontColor('#64748B')
            .height(30)
            .lineHeight(30)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height('100%')
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