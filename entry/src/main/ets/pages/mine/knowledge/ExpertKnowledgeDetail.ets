/**
 * 专家知识详情
 */
import router from '@ohos.router'
import http from '@ohos.net.http';
import { AppConfig } from '../../../config';
import promptAction from '@ohos.promptAction';
@Entry
@Component
struct ExpertKnowledgeDetail {
  private controller: VideoController;
  @State info: any = '';
  @State message: string = 'Hello World'

  deleteKnowledge(){
    deleteKnowledge(this.info.knowledgeId).then(rst=>{
      let data=JSON.parse(rst.result.toString())
      promptAction.showToast({message:data.message,duration:2000})
      setTimeout(()=>{
        router.replaceUrl({url:"pages/mine/knowledge/ExpertKnowledgeList"})
      },2000)
    })
  }

  aboutToAppear() {
    this.info = router.getParams()['info'];
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
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.replaceUrl({url:'pages/info/expert/ExpertKnowledgePage'});
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })

      Row() {
        Text(this.info.title).fontSize(16)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(50)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 20 })

      Row() {
        Text(`作者:${this.info.ownName}`).margin({ right: 10 }).fontSize(14)
        Text(`日期:${this.info.createTime.substring(0, 10)}`).fontSize(14)
      }
      .justifyContent(FlexAlign.End)
      .width('100%')
      .margin({ top: 10, bottom: 10 })
      .height(30)
      .alignItems(VerticalAlign.Center)

      if (this.info.picPath.lastIndexOf('.mp4') == -1) {
        Image(`${AppConfig.baseUrl}/file/${this.info.picPath}`)
          .width('100%')
          .height(200)
          .margin({ bottom: 10 })
      }
      if (this.info.picPath.lastIndexOf('.mp4') >= 0) {
        Video({
          src: `${AppConfig.baseUrl}/file/${this.info.picPath}`,
          controller: this.controller
        })
          .width('100%')
          .height(200)
          .margin({ bottom: 10 })
      }
      Row() {
        Text(this.info.content).fontSize(16).lineHeight(30)
      }.width('100%').margin({ top: 10, bottom: 10 }).layoutWeight(1).alignItems(VerticalAlign.Top)

      Row() {
        Button("修改").width(80).borderRadius(10).margin({right:20})
          .onClick(()=>{
            router.replaceUrl({url:'pages/info/expert/ExpertKnowledgeEditPage',params:{info:this.info}})
          })
        Button("删除").width(80).borderRadius(10).onClick(()=>{
          AlertDialog.show({
            title: '提示',
            message: "你确定要删除该知识吗？",
            primaryButton: {
              value: '取消',
              action: () => {

              }
            },
            secondaryButton:{
              value:'删除',
              action:()=>{
                this.deleteKnowledge()
              }
            }
          })

        })
      }.margin({ bottom: 10 }).width('100%').justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

function deleteKnowledge(id:string){
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/knowledge/${id}'
  return req.request(
    url,
    {
      method:http.RequestMethod.DELETE,
      header:{
        Authorization:globalThis.token
      },
      extraData:{
        knowledgeId:id
      }
    })
}