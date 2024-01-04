/**
 * 专家知识管理
 */
import router from '@ohos.router'
import http from '@ohos.net.http';
import { AppConfig } from '../../../config'
@Entry
@Component
struct MineKnowledgeList {
  private controller:VideoController;
  @State knowledgeDatas: Array<any> = [];
  private scroller: Scroller = new Scroller();
  showMst(str:string){
    let msg='';
    let num=str.length;
    if(num>40){
      msg=str.substring(0,40)+"..."
    }else{
      msg=str;
    }
    return msg;
  }
  showTitle(str:string){
    let msg='';
    let num=str.length;
    if(num>10){
      msg=str.substring(0,10)+"..."
    }else{
      msg=str;
    }
    return msg;
  }
  selectExpertKnowledge(){
    selectExpertKnowledge().then(data=>{
      this.knowledgeDatas = JSON.parse(data.result.toString()).data;
    })
  }
  aboutToAppear(){
    this.selectExpertKnowledge()
  }

  build() {
    Column(){
      Stack({alignContent:Alignment.Start}) {
        Text('我的知识').width('100%').height(60).fontSize(20).width('100%')
          .textAlign(TextAlign.Center).fontColor(Color.Grey)
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.back();
          }).margin({left:10})
      }.height(60).width('100%').margin({top:10})

      Scroll(this.scroller) {
        Column() {
          List(){
            ForEach(this.knowledgeDatas, (item, i) => {
              ListItem(){
                Row() {
                  if (item.picPath.lastIndexOf('.mp4')==-1) {
                    Image(`${AppConfig.baseUrl}/file/${item.picPath}`)
                      .width(100).height(100).borderRadius(5)
                  }
                  if(item.picPath.lastIndexOf('.mp4')>=0){
                    Video({
                      src:`${AppConfig.baseUrl}/file/${item.picPath}`,
                      controller: this.controller
                    }).width(100).height(100).borderRadius(5)
                  }
                  Flex({ direction: FlexDirection.Column }) {
                    Text(`${this.showTitle(item.title)}`).fontSize(15).fontWeight(FontWeight.Bold)
                    Text(`${this.showMst(item.content)}`)
                      .flexGrow(1).fontSize(13).width('70%')
                    Text(`[作者:${item.ownName}]`).width('70%').textAlign(TextAlign.End).fontSize(14)
                  }
                  .padding(5)
                  .flexGrow(1)
                  .margin({left:10})
                }
                .height(120)
                .width('95%')
                .borderRadius(10)
                .backgroundColor('#ffffff')
                .padding(10)
                .margin(5)
                .onClick(()=>{
                  router.replaceUrl({
                    url: 'pages/info/expert/ExperKnowledgeInfoPage',
                    params: { 'info': item }
                  })
                })
              }
            }, item => item)
          }
        }.width('100%').height("100%")
      }.scrollable(ScrollDirection.Vertical)
      .height('100%')

    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

function selectExpertKnowledge(){
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/knowledge/selectByUsername/'
  return req.request(
    url,
    {
      header:{
        Authorization:globalThis.token
      },
      method:http.RequestMethod.GET
    })
}