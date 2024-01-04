import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { getAllAddressApi, getDefaultAddressApi } from '../../api/address';
import { deleteCartApi, getCartListApi, submitCartApi, updateCartCountApi } from '../../api/cart';
import { AppConfig } from '../../config';
import { IAddress } from '../../model/address';
import { IPageInfo, IResponse } from '../../model/common';
import { IOrderInfo, IShoppingModel } from '../../model/order';

interface IGoods {
  shoppingId: number,
  content: string,
  count: number,
  orderId: number,
  ownName: string,
  picture: string,
  price: string,
  isSelected: boolean,
  title: string
}

@Preview
@Component
export default struct ShoppingCart {
  @State isAllSelected: boolean = false;
  @State goodsList: Array<IGoods> = [];
  @State defaultAddress: IAddress = {
    consignee: '',
    addressDetail: '',
    phone: ''
  }
  @State addresses: Array<IAddress> = [];
  @State showAddress: boolean = false;
  @State totalPrice: number = 0;
  @State isFlag: boolean = true;
  @State selectedCount: number = 0;
  @State userId: string = '';
  @State selectAddressIndex: number = 0;

  async handleLoadCartList() {
    try {
      const res = await getCartListApi()
      const data: IResponse<Array<IShoppingModel>> = <IResponse<Array<IShoppingModel>>> JSON.parse(res.result.toString())
      data.data.forEach((item: IShoppingModel) => {
        this.goodsList.push({
          shoppingId: item?.shoppingId,
          content: item?.content,
          count: item?.count,
          orderId: item?.orderId,
          ownName: item?.ownName,
          picture: item?.picture,
          price: item?.price,
          isSelected: false,
          title: item?.title
        })
      })
      console.error('handleLoadCartList.goodsList: ', JSON.stringify(this.goodsList))
    } catch (error) {
      console.error('handleLoadCartList.error: ', error.message)
    }
  }

  async handleLoadAddress() {
    try {
      const res = await getDefaultAddressApi()
      console.info('handleLoadAddress.getDefaultAddressApi:', res.result.toString())
      const data: IResponse<IAddress> = <IResponse<IAddress>> JSON.parse(res.result.toString())
      if (data?.data) {
        this.defaultAddress = data.data
      }
    } catch (error) {
      console.error('handleLoadAddress.getDefaultAddressApi.error: ', error.message)
    }
    try {
      const res = await getAllAddressApi()
      console.info('handleLoadAddress.getAllAddressApi:', res.result.toString())
      const data: IResponse<Array<IAddress>> = <IResponse<Array<IAddress>>> JSON.parse(res.result.toString())
      this.addresses = data.data || []
    } catch (error) {
      console.error('handleLoadAddress.getAllAddressApi.error: ', error.message)
    }
  }

  handleShowAddress(content: string) {
    return content.length > 15 ? content.substring(0, 15) + '...' : content
  }

  handleSelectedConvert(item, index) {
    this.goodsList.splice(index, 1, {
      shoppingId: item.shoppingId,
      content: item.content,
      count: item.count,
      orderId: item.orderId,
      ownName: item.ownName,
      picture: item.picture,
      price: item.price,
      isSelected: item.isSelected,
      title: item.title
    })
    this.handleCalculateTotalPrice()
  }

  handleCalculateTotalPrice() {
    let total = 0
    this.selectedCount = 0
    this.goodsList.forEach((item: IGoods) => {
      if (item.isSelected) {
        this.selectedCount++
        total += parseFloat(item.price) * parseInt(<string> <unknown> item.count)
      }
    })
    this.totalPrice = total
    this.isAllSelected = this.selectedCount === this.goodsList.length
  }

  handleAddOrSubtractGoods(data: IGoods, index: number, type: -1 | 1) {
    if (data.count == 1 && type === -1) {
      return
    }
    data.count += type
    this.goodsList.splice(index, 1, {
      shoppingId: data.shoppingId,
      content: data.content,
      count: data.count,
      orderId: data.orderId,
      ownName: data.ownName,
      picture: data.picture,
      price: data.price,
      isSelected: data.isSelected,
      title: data.title
    })
    this.handleCalculateTotalPrice()
    this.handleUpdateGoodsCount(data);
  }

  async handleUpdateGoodsCount(data: IGoods) {
    try {
      await updateCartCountApi(data.shoppingId, data.count)
    } catch (error) {
      console.error('handleUpdateGoodsCount.updateCartCountApi.error: ', error.message)
    }
  }

  handleDeleteGoods() {
    AlertDialog.show({
      title: '提示',
      message: this.isAllSelected ? '清空购物车？' : '删除已选中的商品？',
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('Callback when the second button is clicked')
        }
      },
      secondaryButton: {
        value: '确定',
        action: () => {
          this.goodsList.forEach(async (item: IGoods) => {
            if (item.isSelected) {
              await deleteCartApi(item.shoppingId)
            }
          })
          if (this.isAllSelected) {
            this.goodsList = []
            this.totalPrice = 0
            this.isAllSelected = false
          } else {
            const newArray: Array<IGoods> = []
            this.goodsList.forEach((item: IGoods) => {
              if (!item.isSelected) {
                newArray.push(item)
              }
            })
            this.goodsList = newArray
            this.handleCalculateTotalPrice()
          }
        }
      }
    })
  }

  // 商品详情
  @Builder GoodsItem(item: IGoods, index: number) {
    Row() {
      Row() {
        Image(item.isSelected ? $r('app.media.selected_on') : $r('app.media.selected_off'))
          .width(22)
          .height(22)
      }
      .width(45)
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        item.isSelected = !item.isSelected
        this.handleSelectedConvert(item, index)
      })

      Image(AppConfig.baseUrl + "/file/" + item.picture)
        .width(90)
        .border({ width: 0.5, color: '#CFCFCF', radius: 5 })
        .margin({ top: 10, bottom: 10, right: 10 })
      Column() {
        Text(item.title)
          .fontSize(14)
          .fontColor('#ff323232')
        if (item.content.trim().length !== 0) {
          Text(item.content)
            .fontSize(12)
            .fontColor('#ff6a6a6a')
            .borderRadius(5)
            .padding({ left: 5, right: 5, top: 2, bottom: 2 })
            .margin({ top: 5 })
        }
        Blank()
        Row() {
          Text('￥' + item.price)
            .fontSize(15)
            .fontColor('#dc1c22')
          Blank()
          Row() {
            Text('－')
              .fontColor('#484848')
              .fontSize(10)
              .width(18)
              .height(18)
              .textAlign(TextAlign.Center)
              .onClick(() => this.handleAddOrSubtractGoods(item, index, -1))
            Divider()
              .strokeWidth(1)
              .color('#a1a1a1')
              .vertical(true)
              .height(18)
            Text('' + item.count)
              .width(30)
              .height(18)
              .fontSize(11)
              .fontColor('#484848')
              .textAlign(TextAlign.Center)

            Divider()
              .strokeWidth(1)
              .color('#a1a1a1')
              .vertical(true)
              .height(18)
            Text('＋')
              .fontColor('#484848')
              .fontSize(14)
              .width(18)
              .height(18)
              .textAlign(TextAlign.Center)
              .onClick(() => this.handleAddOrSubtractGoods(item, index, 1))
          }
          .border({ width: 1, color: '#a1a1a1', radius: 3 })
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
    this.handleLoadCartList()
    this.handleLoadAddress()
  }

  build() {
    Column() {
      if (!globalThis.token) {
        Column() {
          Image($r('app.media.illustration_3x'))
            .width(200)
            .height(200)
          Text("未登录")
            .fontSize(24)
            .fontColor('#0F172A')
            .height(50)
            .lineHeight(50)
            .fontWeight(400)
          Text('请先登录！')
            .fontSize(16)
            .fontColor('#64748B')
            .height(30)
            .lineHeight(30)
          Text('去登录')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor('#059669')
            .height(60)
            .width(260)
            .borderRadius(12)
            .margin({ top: 30 })
            .textAlign(TextAlign.Center)
            .fontWeight(400)
            .onClick(() => router.pushUrl({ url: 'pages/Login' }))
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height('100%')
      } else if (this.goodsList.length === 0) {
        Column() {
          Image($r('app.media.illustration_3x'))
            .width(200)
            .height(200)
          Text("购物车是空的")
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
            .onClick(() => router.pushUrl({
              url: 'pages/home/goods/GoodsSourcePurchaseList',
              params: { type: 'goods' }
            }))
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height('100%')
      } else {
        Row() {
          Row() {
            Image($r('app.media.dingwei'))
              .width(40)
              .height(40)
              .margin({ left: 0, right: 5 })
            Text(this.handleShowAddress(this.defaultAddress?.addressDetail))
              .fontColor(Color.Grey)
          }
          .onClick(() => this.showAddress = true)

          Blank()
          Text(this.isFlag ? '编辑' : '完成')
            .fontSize(16)
            .fontColor(Color.Grey)
            .onClick(() => this.isFlag = !this.isFlag)
        }
        .height(60)
        .width('100%')
        .padding({ left: 0, right: 20 })
        .backgroundColor('#f3f3f3')

        Stack() {
          Column() {
            Row() {
              Text("全部 " + this.goodsList.length + " 种")
                .margin({ left: 20 })
                .width('100%')
                .fontColor(Color.Red)
            }
            .height(50)
            .backgroundColor('rgba(255,255,255,0.5)')
            .margin({ bottom: 5 })

            List() {
              ForEach(this.goodsList, (item, index) => {
                ListItem() {
                  this.GoodsItem(item, index)
                }
              })
            }
            .layoutWeight(1)
            .visibility(this.showAddress ? Visibility.Hidden : Visibility.Visible)

            Row() {
              Row() {
                Image(this.isAllSelected ? $r('app.media.selected_on') : $r('app.media.selected_off'))
                  .width(22)
                  .height(22)
                Text('全选')
                  .fontSize(13)
                  .margin({ left: 5, top: 3 })
              }.onClick(() => {
                let temp: Array<IGoods> = this.goodsList;
                this.goodsList = new Array();
                this.isAllSelected = !this.isAllSelected
                temp.forEach((item: IGoods) => {
                  this.goodsList.push({
                    shoppingId: item?.shoppingId,
                    content: item?.content,
                    count: item?.count,
                    orderId: item?.orderId,
                    ownName: item?.ownName,
                    picture: item?.picture,
                    price: item?.price,
                    isSelected: this.isAllSelected,
                    title: item?.title
                  })
                })
                this.handleCalculateTotalPrice()
              })

              Blank()
              if (this.totalPrice > 0 && this.isFlag) {
                Text('合计：')
                  .fontSize(12)
                  .fontColor('#808080')
                Text('￥')
                  .fontSize(12)
                  .fontColor('#dc1c22')
                  .baselineOffset(-2)
                Text('' + this.totalPrice.toFixed(2))
                  .fontSize(15)
                  .fontColor('#dc1c22')
              }
              if (this.isFlag) {
                Text(this.selectedCount == 0 ? '结算' : '结算(' + this.selectedCount + ')')
                  .width(80)
                  .height(32)
                  .backgroundColor('#dc1c22')
                  .fontColor(Color.White)
                  .fontSize(16)
                  .textAlign(TextAlign.Center)
                  .borderRadius(20)
                  .margin({ left: 10 })
                  .onClick(() => {
                    let buyItems = []
                    let noBuyItems = []
                    this.goodsList.forEach((item: IGoods) => {
                      let a = item
                      if (item.isSelected) {
                        buyItems.push(item)
                      } else {
                        noBuyItems.push(item)
                      }
                    })
                    let userId = this.defaultAddress.id;
                    submitCartApi(userId, this.totalPrice, buyItems as any)
                      .then((res) => {
                        let data = JSON.parse(res.result.toString());
                        if (data.code = 20000) {
                          this.goodsList = noBuyItems;
                          router.pushUrl({ url: 'pages/cart/PayResult' })
                        }
                        promptAction.showToast({
                          message: data.message,
                          duration: 2000
                        })
                      })
                  })
              } else {
                Text("删除")
                  .width(80)
                  .height(32)
                  .backgroundColor(Color.White)
                  .fontColor(Color.Gray)
                  .fontSize(12)
                  .textAlign(TextAlign.Center)
                  .borderRadius(20)
                  .onClick(() => this.handleDeleteGoods())
              }
            }
            .visibility(this.showAddress ? Visibility.Hidden : Visibility.Visible)
            .width('100%')
            .height(60)
            .backgroundColor('rgba(255,255,255,0.2)')
            .padding({ left: 20, right: 20 })
          }
          .layoutWeight(1)
          .padding({ bottom: 70 })

          Panel(this.showAddress) {
            Column() {
              Text('更换地址')
                .height(50)
              Divider()
              List() {
                ForEach(this.addresses, (item, index) => {
                  ListItem() {
                    Row() {
                      Radio({ value: item.id, group: 'addgroup' })
                        .checked(item.isDefault)
                        .onChange((isChecked: boolean) => {
                          if (isChecked) {
                            this.selectAddressIndex = index;
                          }
                        })
                      Text(item.addressDetail)
                      Text(item.phone)
                    }
                    .width('100%')
                    .height(50)
                  }.padding(10)
                })
              }

              Button("选择地址", { type: ButtonType.Normal })
                .width('90%')
                .onClick(() => {
                  this.defaultAddress = this.addresses[this.selectAddressIndex];
                  this.showAddress = false;
                })
                .borderRadius(10)
                .height(40)
                .margin({ top: 20 })
            }
          }
          .type(PanelType.Foldable)
          .mode(PanelMode.Half)
          .fullHeight(700)
          .onChange((width: number, height: number, mode: PanelMode) => {
            console.info(`width:${width},height:${height},mode:${mode}`)
          })
        }
        .height('100%')
        .flexGrow(1)
      }

    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}