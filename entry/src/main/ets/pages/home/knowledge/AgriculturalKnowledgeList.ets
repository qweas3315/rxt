/**
 * 农业知识列表
 */
import router from '@ohos.router'
import { getKnowledgePageApi } from '../../../api/knowledge'
import { AppConfig } from '../../../config'
import { IPageInfo, IResponse } from '../../../model/common'
import { IKnowledge } from '../../../model/knowledge'

@Entry
@Component
struct AgriculturalKnowledgeList {
  @State pageNum: number = 1
  @State knowledgeList: Array<IKnowledge> = []
  private scroller: Scroller = new Scroller();
  private controller: VideoController = new VideoController();

  async handleLoadKnowLedge() {
    try {
      const res = await getKnowledgePageApi(this.pageNum)
      const data: IResponse<IPageInfo<IKnowledge>> = <IResponse<IPageInfo<IKnowledge>>> JSON.parse(res.result.toString())
      data.data.list.forEach((item: IKnowledge) => {
        this.knowledgeList.push(item)
      })
    } catch (error) {
      console.error('handleLoadKnowLedge.error: ', error.message)
    }
  }

  handleShowTitle(content: string) {
    return content.length > 10 ? content.substring(0, 10) + "..." : content
  }

  handleShowContent(content) {
    return content.length > 40 ? content.substring(0, 40) + "..." : content
  }

  aboutToAppear() {
    this.handleLoadKnowLedge()
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('农业知识')
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

      Scroll(this.scroller) {
        Column() {
          List() {
            ForEach(this.knowledgeList, (item: IKnowledge) => {
              ListItem() {
                Row() {
                  if (item.picPath.lastIndexOf('.mp4') == -1) {
                    Image(`${AppConfig.baseUrl}/file/${item.picPath}`)
                      .width(100)
                      .height(100)
                      .borderRadius(5)
                  }
                  if (item.picPath.lastIndexOf('.mp4') >= 0) {
                    Video({
                      src: `${AppConfig.baseUrl}/file/${item.picPath}`,
                      controller: this.controller
                    })
                      .width(100)
                      .height(100)
                      .borderRadius(5)
                  }
                  Flex({ direction: FlexDirection.Column }) {
                    Text(`${this.handleShowTitle(item.title)}`)
                      .fontSize(15)
                      .fontWeight(FontWeight.Bold)
                    Text(`${this.handleShowContent(item.content)}`)
                      .flexGrow(1)
                      .fontSize(13)
                      .width('70%')
                    Text(`[作者:${item.ownName}]`)
                      .width('70%')
                      .textAlign(TextAlign.End)
                      .fontSize(14)
                  }
                  .padding(5)
                  .flexGrow(1)
                  .margin({ left: 10 })
                }
                .height(120)
                .width('95%')
                .borderRadius(10)
                .backgroundColor('#ffffff')
                .padding(10)
                .margin(5)
                .onClick(() => {
                  globalThis.routerList = [`${router.getState().path}${router.getState().name}`]
                  router.replaceUrl({
                    url: 'pages/home/knowledge/AgriculturalKnowledgeDetail',
                    params: { knowledgeDetail: item }
                  })
                })
              }
            })
          }
        }.width('100%').height("100%")
      }
      .height('100%')
      .scrollable(ScrollDirection.Vertical)
      .onScrollEdge(() => {
        if (this.pageNum < globalThis.navigateLastPage) {
          this.pageNum += 1;
          this.handleLoadKnowLedge();
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}