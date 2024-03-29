/**
 * 专家知识管理
 */
import router from '@ohos.router'
import http from '@ohos.net.http';
import { AppConfig } from '../../../config'
import { getExpertKnowledgeApi } from '../../../api/knowledge';
import { IResponse } from '../../../model/common';
import { IKnowledge } from '../../../model/knowledge';

@Entry
@Component
struct ExpertKnowledgeList {
  private controller: VideoController;
  @State knowledgeList: Array<IKnowledge> = [];
  private scroller: Scroller = new Scroller();

  handleShowContent(content: string) {
    return content.length > 40 ? content.substring(0, 40) + "..." : content;
  }

  handleShowTitle(content: string) {
    return content.length > 10 ? content.substring(0, 10) + "..." : content
  }

  async handleLoadKnowledgeList() {
    try {
      const res = await getExpertKnowledgeApi()
      const data: IResponse<Array<IKnowledge>> = <IResponse<Array<IKnowledge>>> JSON.parse(res.result.toString())
      data.data.forEach((item: IKnowledge) => {
        this.knowledgeList.push(item)
      })
      console.info('getExpertKnowledgeApi: ', res.result.toString())
    } catch (error) {
      console.error('handleLoadKnowledgeList.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleLoadKnowledgeList()
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('我的知识')
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

      Scroll(this.scroller) {
        Column() {
          List() {
            ForEach(this.knowledgeList, (item: IKnowledge) => {
              ListItem() {
                Row() {
                  if (item.picPath.lastIndexOf('.mp4') == -1) {
                    Image(`${AppConfig.baseUrl}/file/${item?.picPath}`)
                      .width(100)
                      .height(100)
                      .borderRadius(5)
                  }
                  if (item?.picPath.lastIndexOf('.mp4') >= 0) {
                    Video({
                      src: `${AppConfig.baseUrl}/file/${item?.picPath}`,
                      controller: this.controller
                    })
                      .width(100)
                      .height(100)
                      .borderRadius(5)
                  }
                  Flex({ direction: FlexDirection.Column }) {
                    Text(`${this.handleShowTitle(item?.title)}`)
                      .fontSize(15)
                      .fontWeight(FontWeight.Bold)
                    Text(`${this.handleShowContent(item?.content)}`)
                      .flexGrow(1)
                      .fontSize(13)
                      .width('70%')
                    Text(`[作者:${item?.ownName}]`)
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
                  const routerList: Array<string> = globalThis.routerList;
                  routerList.push(`${router.getState().path}${router.getState().name}`)
                  globalThis.routerList = routerList
                  router.replaceUrl({
                    url: 'pages/mine/knowledge/ExpertKnowledgeDetail',
                    params: { 'knowledgeDetail': item }
                  })
                })
              }
            })
          }
        }
        .width('100%')
        .height("100%")
      }
      .scrollable(ScrollDirection.Vertical)
      .height('100%')

    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}