/**
 * 专家知识详情
 */
import router from '@ohos.router'
import { AppConfig } from '../../../config';
import promptAction from '@ohos.promptAction';
import { IKnowledge } from '../../../model/knowledge';
import { deleteKnowledgeApi } from '../../../api/knowledge';

@Entry
@Component
struct ExpertKnowledgeDetail {
  private controller: VideoController;
  @State knowledgeDetail: IKnowledge = {};

  async handleDeleteKnowledge() {

    AlertDialog.show({
      title: '提示',
      message: "你确定要删除该知识吗？",
      primaryButton: {
        value: '取消',
        action: () => {
        }
      },
      secondaryButton: {
        value: '删除',
        action: async () => {
          try {
            const res = await deleteKnowledgeApi(<string> <unknown> this.knowledgeDetail.knowledgeId)
            const data = JSON.parse(res.result.toString())
            promptAction.showToast({ message: data.message, duration: 2000 })
            setTimeout(() => {
              const routerList: Array<string> = globalThis.routerList
              const routerUrl = routerList.pop();
              globalThis.routerList = routerList;
              router.replaceUrl({ url: routerUrl })
            }, 2000)
          } catch (error) {
            console.error('handleLoadQuestion.error: ', error.message)
          }
        }
      }
    })
  }

  aboutToAppear() {
    this.knowledgeDetail = router.getParams()['knowledgeDetail'];
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
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
            const routerList: Array<string> = globalThis.routerList
            const routerUrl = routerList.pop();
            globalThis.routerList = routerList;
            router.replaceUrl({ url: routerUrl })
          })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      Row() {
        Text(this.knowledgeDetail.title)
          .fontSize(16)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(50)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 20 })

      Row() {
        Text(`作者:${this.knowledgeDetail.ownName}`)
          .margin({ right: 10 })
          .fontSize(14)
        Text(`日期:${this.knowledgeDetail.createTime.substring(0, 10)}`)
          .fontSize(14)
      }
      .justifyContent(FlexAlign.End)
      .width('100%')
      .margin({ top: 10, bottom: 10 })
      .height(30)
      .alignItems(VerticalAlign.Center)

      if (this.knowledgeDetail.picPath.lastIndexOf('.mp4') == -1) {
        Image(`${AppConfig.baseUrl}/file/${this.knowledgeDetail.picPath}`)
          .width('100%')
          .height(200)
          .margin({ bottom: 10 })
      }
      if (this.knowledgeDetail.picPath.lastIndexOf('.mp4') >= 0) {
        Video({
          src: `${AppConfig.baseUrl}/file/${this.knowledgeDetail.picPath}`,
          controller: this.controller
        })
          .width('100%')
          .height(200)
          .margin({ bottom: 10 })
      }
      Row() {
        Text(this.knowledgeDetail.content)
          .fontSize(16)
          .lineHeight(30)
      }
      .width('100%')
      .margin({ top: 10, bottom: 10 })
      .layoutWeight(1)
      .alignItems(VerticalAlign.Top)

      Row() {
        Button("修改")
          .width(80)
          .borderRadius(10)
          .margin({ right: 20 })
          .onClick(() => {
            const routerList: Array<string> = globalThis.routerList;
            routerList.push(`${router.getState().path}${router.getState().name}`)
            globalThis.routerList = routerList
            router.replaceUrl({
              url: 'pages/mine/knowledge/ExpertKnowledgeEdit',
              params: { type: 'edit', knowledgeDetail: this.knowledgeDetail }
            })
          })
        Button("删除")
          .width(80)
          .borderRadius(10)
          .onClick(() => this.handleDeleteKnowledge())
      }
      .margin({ bottom: 10 })
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}