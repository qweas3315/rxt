/**
 * 商品货源和求购需求详情
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { addCartApi } from '../../../api/cart';
import { AppConfig } from '../../../config';
import { IOrderInfo } from '../../../model/order'

@Entry
@Component
struct GoodsSourceDetail {
  @State goodsDetail: IOrderInfo = null
  @State isShow: boolean = false

  async handleAddCart() {
    if (globalThis.token) {
      try {
        const res = await addCartApi(this.goodsDetail.orderId)
        const data = JSON.parse(res.result.toString());
        if (data.code == 20000) {
          promptAction.showToast({ message: "添加商品到购物车成功！", duration: 2000 })
        } else {
          promptAction.showToast({ message: "添加商品到购物车失败！", duration: 2000 })
        }
      } catch (error) {
        console.error('handleAddCart.error: ', error.message)
      }
    } else {
      AlertDialog.show({
        title: '提示',
        message: "请先登录！",
        primaryButton: {
          value: '确定',
          action: () => {
          }
        }
      })
    }
  }

  aboutToAppear() {
    this.goodsDetail = router.getParams()['goodsDetail'];
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('详细信息')
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
            const routerUrl = globalThis.routerList[0]
            globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
            router.replaceUrl({ url: routerUrl })
          })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })
      .zIndex(1)

      Column() {
        Image(`${AppConfig.baseUrl}/file/${this.goodsDetail.picture}`)
          .width('100%')
          .height(300)
          .margin({ bottom: 10 })
          .borderRadius(10)
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text(this.goodsDetail.title)
            .fontSize(30)
        }
        .height(60)

        Divider()
          .margin(10)
          .color(Color.Gray)
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Start }) {
          Text(this.goodsDetail.content)
            .fontSize(20)
        }
        .height(200)
        .padding({ left: 10 })

        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Text(`￥${this.goodsDetail.price}`)
            .fontSize(25)
            .fontColor(Color.Red)
        }
        .height(40)
        .padding({ left: 10 })

        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Text(`发布时间:${this.goodsDetail.createTime.substring(0, 10)}`)
            .fontSize(16)
          Text(`最近修改时间:${this.goodsDetail.updateTime.substring(0, 10)}`)
            .fontSize(16)
        }
        .height(50)
        .padding({ left: 10 })
        .margin({ bottom: 10 })

        Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
          Column() {
            Image($r('app.media.pl'))
              .width(20)
              .height(20)
              .margin({ bottom: 5 })
            Text("评论")
              .fontSize(14)
          }

          Column() {
            Button('加入购物车')
              .visibility(this.goodsDetail.type == 'goods' ? Visibility.Visible : Visibility.None)
              .backgroundColor(Color.Red)
              .onClick(() => this.handleAddCart())
            Button('联系买家')
              .visibility(this.goodsDetail.type == 'needs' ? Visibility.Visible : Visibility.None)
              .onClick(() => {
                if (globalThis.token) {
                  this.isShow = true
                } else {
                  AlertDialog.show({
                    title: '提示',
                    message: "请先登录！",
                    primaryButton: {
                      value: '确定',
                      action: () => {
                      }
                    }
                  })
                }
              })
          }
        }.margin({ bottom: 10 })
      }.zIndex(-1).margin({ top: 70, bottom: 10, left: 10, right: 10 })

      //显示卖家信息
      Panel(this.isShow) {
        Column() {
          List() {
            ListItem() {
              Text("买家姓名:" + this.goodsDetail.ownName)
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Text("买家地址:" + this.goodsDetail.address)
            }
            .padding({ left: 20, right: 20 })
            .height(60)

            ListItem() {
              Row() {
                Button("取消")
                  .type(ButtonType.Normal)
                  .onClick(() => this.isShow = false)
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
            }
            .padding({ left: 20, right: 20 })
            .height(60)
          }
          .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
        }
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .dragBar(true)
      .halfHeight(200)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}