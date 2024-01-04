/**
 * 回答问题
 */
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import http from '@ohos.net.http';
import { AppConfig } from '../../../config';
@Entry
@Component
struct QuestionAnswering {
  @State item:any={};

  build() {
    Row() {
      Column() {
        Stack({alignContent:Alignment.Start}) {
          Text('问答问题').width('100%').height(60).fontSize(20).width('100%')
            .textAlign(TextAlign.Center).fontColor(Color.Grey)
          Image($r('app.media.iv_back_selected')).width(40).height(40)
            .onClick(() => {
              router.back();
            }).margin({left:10})
        }.height(60).width('100%').margin({top:10})

        Column(){
          //基本信息
          List(){
            ListItem(){
              Row(){
                Text('问题标题:').width(100)
                TextInput({text:this.item.title}).onChange((val)=>{
                  this.item.title=val
                }).borderWidth(0).backgroundColor(Color.Transparent)
              }
            }.padding({left:20,right:20}).height(60)
            ListItem(){
              Row(){
                Text('内容:').width(100)
                Text(this.item.question).borderWidth(0).backgroundColor(Color.Transparent)
              }
            }.padding({left:20,right:20}).height(60)
            ListItem(){
              Row(){
                Text('回答:').width(100)
                TextInput({text:this.item.answer}).onChange((val)=>{
                  this.item.answer=val
                }).borderWidth(0).backgroundColor(Color.Transparent)
              }
            }.padding({left:20,right:20}).height(60)
          }.divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 }) // 每行之间的分界线
          .borderRadius(10)
          .margin(5)
          .backgroundColor('#ffffff')
        }.layoutWeight(1)
        Row(){
          Button("回答").fontColor(Color.White).backgroundColor(Color.Red)
            .type(ButtonType.Normal)
            .width('100%')
            .borderRadius(20)
            .onClick(()=>{
              updateQuestion(this.item)
                .then(data=>{
                  let code=JSON.parse(data.result.toString()).code;
                  if(code==20000){
                    promptAction.showToast({
                      message: '操作成功!',
                      duration: 2000,
                    });
                    setTimeout(()=>{
                      router.replaceUrl({url:'pages/info/expert/ExpertQustionAllPage'})
                    },2000)
                  }else{
                    promptAction.showToast({
                      message: '操作失败!',
                      duration: 2000,
                    });
                  }
                })
            })
        }.alignItems(VerticalAlign.Bottom).padding(10).backgroundColor('#ffffff')
        .width('100%')
      }
      .width('100%')
    }
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

function updateQuestion(item:any){
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/question/update'
  return req.request(
    url,
    {
      method:http.RequestMethod.PUT,
      header:{
        Authorization:globalThis.token
      },
      extraData:{
        answer:item.answer,
        expertName:item.expertName,
        phone:item.phone,
        plantName:item.plantName,
        id:item.id,
        question:item.question,
        questioner:item.questioner,
        status:1,
        title:item.title
      }
    })
}