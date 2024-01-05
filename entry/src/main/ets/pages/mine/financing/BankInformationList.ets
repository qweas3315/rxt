/**
 * 银行信息列表
 */
import router from '@ohos.router';
import { getBankApi } from '../../../api/finance';
import { IResponse } from '../../../model/common';
import { IBank, IFinance } from '../../../model/finance';

@Entry
@Component
struct BankInformationList {
  @State bankList: Array<IBank> = [];
  @State bankMap: Array<IBank> = [];
  private scroller: Scroller = new Scroller()

  async handleLoadBank() {
    try {
      const res = await getBankApi()
      const data: IResponse<Array<IBank>> = <IResponse<Array<IBank>>> JSON.parse(res.result.toString())
      data.data.forEach((item: IBank) => {
        this.bankList.push(item)
        this.bankMap[item.bankId] = item
      })
      globalThis.bankMap = this.bankMap;
    } catch (error) {
      console.error('handleLoadBank.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleLoadBank()
  }

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text('银行信息列表')
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
        //信息列表
        Scroll(this.scroller) {
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.bankList, (item: IBank) => {
              Row() {
                Image($r(`app.media.bank${item.bankId}`))
                  .width(188)
                  .height(188)
                  .objectFit(ImageFit.Fill)
                  .borderRadius(10)
              }
              .width('47%')
              .height(188)
              .borderRadius(5)
              .borderWidth(1)
              .borderColor(Color.Gray)
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .shadow({ radius: 5, color: Color.Gray, offsetX: 5, offsetY: 5 })
              .margin(5)
              .onClick(() =>
              router.pushUrl({ url: 'pages/mine/financing/BankInformation', params: { 'bankDetail': item } }))
            })
          }
          .padding({ bottom: 20 })
          .margin({ bottom: 80 })
        }
        .width('100%')
        .height('100%')
        .scrollable(ScrollDirection.Vertical)
      }
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}