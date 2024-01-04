import router from '@ohos.router';
import { getAllAddressApi, getDefaultAddressApi } from '../../api/address';
import { getCartListApi } from '../../api/cart';
import { IAddress } from '../../model/address';
import { IOrderInfo } from '../../model/order';

@Preview
@Component
export default struct ShoppingCart {
  @State isAllSelected: boolean = false;
  @State goodsList: Array<IOrderInfo> = [];
  @State defaultAddress: IAddress = {
    consignee: '',
    addressDetail: '',
    phone: ''
  }
  @State addresses: Array<IAddress> = [];
  @State selectedGoods: Array<IOrderInfo> = [];
  @State showAddress: boolean = false;
  @State totalPrice: number = 0;
  @State checkBoxNames: Array<string> = []
  @State isFlag: boolean = true;
  @State selectedCount: number = 0;
  @State userId: string = '';
  @State selectAddressIndex: number = 0;

  async handleLoadCartList() {
    const res = await getCartListApi()

  }

  async handleLoadAddress() {
    const defaultAddressResponse = await getDefaultAddressApi()

    const allAddressResponse = await getAllAddressApi()
  }

  handleShowAddress(content: string) {
    return content.length > 15 ? content.substring(0, 15) + '...' : content
  }

  handleSelectedConvert(item, index) {
    // let newItem = {
    //   shoppingId: item.shoppingId,
    //   content: item.content,
    //   count: item.count,
    //   orderId: item.orderId,
    //   ownName: item.ownName,
    //   picture: item.picture,
    //   price: item.price,
    //   isSelected: item.isSelected,
    //   title: item.title
    // }
    // this.goodsList.splice(index, 1, newItem)
    // this.calculateTotalPrice()
  }

  handleCalculateTotalPrice() {

  }

  handleAddOrSubtractGoods() {

  }

  handleUpdateGoodsCount() {

  }

  handleDeleteGoods() {

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
            .onClick(() => router.pushUrl({ url: 'pages/GoodsPage', params: { 'type': 'goods' } }))
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
            Text(this.handleShowAddress(this.defaultAddress.addressDetail))
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
              ForEach(this.goodsList, (item) => {
                ListItem() {
                  // this.GoodsItem(item, index)
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
                let temp: Array<IOrderInfo> = this.goodsList;
                this.goodsList = new Array();
                this.isAllSelected = !this.isAllSelected
                for (const item of temp) {
                  let newItem = {
                    // shoppingId: item.shoppingId,
                    content: item.content,
                    // count: item.count,
                    orderId: item.orderId,
                    ownName: item.ownName,
                    picture: item.picture,
                    price: item.price,
                    isSelected: this.isAllSelected,
                    title: item.title
                  }
                  // this.goodsList.push(newItem)
                }
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
                    this.goodsList.forEach(item => {
                      let a = item
                      // if (item.isSelected) {
                      //   buyItems.push(item)
                      // } else {
                      //   noBuyItems.push(item)
                      // }
                    })
                    let userId = this.defaultAddress.id;
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


          //显示用户地址
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