/**
 * 首页组件
 */
import promptAction from '@ohos.promptAction'
import { searchAllByKeys } from '../../api/order'
import { AppConfig } from '../../config'
import { IPageInfo, IResponse } from '../../model/common'
import { IOrderInfo } from '../../model/order'
import HomeBroadcast from './component/Broadcast'
import HomeNavigator from './component/Navigator'

@Preview
@Component
export default struct Home {
  @State keyword: string = '苹果'
  @State pageNum: number = 1;
  @State goodsList: Array<IOrderInfo> = []
  private scroller: Scroller = new Scroller()

  async handleSearch(current: number) {
    if (this.keyword.trim().length === 0) {
      promptAction.showToast({ message: '请输入搜索内容后进行搜索', duration: 1000 })
      return
    }
    this.pageNum = current
    try {
      const res = await searchAllByKeys({ keyword: this.keyword, pageNum: this.pageNum })
      const data: IResponse<IPageInfo<IOrderInfo>> = <IResponse<IPageInfo<IOrderInfo>>> JSON.parse(res.result.toString())
      console.info('searchAllByKeys1', res.result)
      promptAction.showToast({ message: JSON.stringify(data), duration: 1000 })
      if (data.flag) {
        this.goodsList = []
        this.goodsList = data.data?.list || []
        console.info('goodsList: ', this.goodsList)
      }
    } catch (error) {
      console.error('handleSearch.error: ', error.message)
    }
  }

  showContent(content: string) {
    return content.length > 15 ? content.substring(0, 15) : content
  }

  showTitle(title: string) {
    return title.length > 15 ? title.substring(0, 15) : title
  }

  build() {
    Column() {
      Row() {
        Text("青岛")
          .padding({ left: 5 })
        Text()
          .height(35)
          .border({ width: 1, color: '#C6C9CD' })
          .margin({ left: 5, right: 5 })
        Image($r('app.media.Search_1'))
          .width(20)
          .height(20)
          .margin({ left: 10 })
        TextInput({ placeholder: '搜索', text: this.keyword })
          .onChange((value: string) => {
            this.keyword = value
          })
          .layoutWeight(1)
          .borderWidth(0)
          .borderRadius(1)
          .backgroundColor(Color.White)
          .height(50)
          .placeholderColor(Color.Gray)
        Button('确定')
          .margin({ right: 10 })
          .backgroundColor(Color.Transparent)
          .onClick(() => this.handleSearch(1))
          .fontColor(Color.Black)
      }
      .backgroundColor(Color.White)
      .width('95%')
      .margin(10)
      .borderRadius(5)

      HomeBroadcast()
      HomeNavigator()
      if (this.goodsList.length > 0) {
        Scroll(this.scroller) {
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.goodsList, (item) => {
              Column() {
                Image(`${AppConfig.baseUrl}/file/${item.picture}`)
                  .height(100)
                  .width('100%')
                Column() {
                  Row() {
                    Image(item.type == 'goods' ? $r('app.media.gong') : $r('app.media.xu'))
                      .width(30)
                      .height(30)
                    Text(this.showTitle(item.title))
                      .height(30)
                      .lineHeight(30)
                      .margin({ left: 10 })
                      .fontSize(18)
                      .fontWeight(FontWeight.Bolder)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .margin({ top: 5 })

                  Row() {
                    Text(this.showContent(item.content))
                      .textOverflow({ overflow: TextOverflow.Clip })
                      .width('100%')
                      .height(30)
                      .lineHeight(30)
                  }

                  Row() {
                    Text('￥' + item.price)
                      .fontColor(Color.Red)
                      .fontSize(18)
                  }
                  .height(20)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .width('100%')
                }
                .layoutWeight(1)
                .width('100%')
                .alignItems(HorizontalAlign.Start)
              }
              .width('47%')
              .height(200)
              .borderRadius(5)
              .borderWidth(1)
              .borderColor('#ffffff')
              .margin(5)
              .padding(10)
              .onClick(() => {
              })
            })
          }.width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .height(400)
        .margin({ top: 10, right: 10, left: 10 })
        .onScrollEdge(() => {
          // if (this.keyword == '') {
          //   this.getAllGoods(this.pageNum + 1)
          // } else {
          //   this.getGoodsByParam(this.pageNum + 1)
          // }
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