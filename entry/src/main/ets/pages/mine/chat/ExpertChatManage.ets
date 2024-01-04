/**
 * 专家问答管理
 */
import router from '@ohos.router'
import http from '@ohos.net.http';
import { AppConfig } from '../../../config';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct ExpertChatManage {
  @State isShow: boolean = false
  @State wenDaData: any = [];
  @State wenDa: any = {}
  private scroller: Scroller = new Scroller()

  findExpertQuestion() {
    getExpertQuestion().then(rst=>{
      promptAction.showDialog({message: rst.result.toString()})
      this.wenDaData=JSON.parse(rst.result.toString()).data;
    })
  }

  // aboutToAppear() {
  //   this.findExpertQuestion()
  // }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('问答信息')
          .width('100%')
          .height(60)
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
        Image($r('app.media.iv_back_selected'))
          .width(40)
          .height(40)
          .onClick(() => {
            router.back()
          })
          .margin({ left: 10 })
      }
      .height(60)
      .width('100%')
      .margin({ top: 10 })

      Scroll(this.scroller) {
        List() {
          ForEach(this.wenDaData, (item, index) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.title).margin(3).fontWeight(FontWeight.Bolder)
                  Text(item.question).margin(3)
                  Text("提问者:" + item.questioner).margin(3)
                  Text("电话:" + item.phone)
                  if (item.status == 0) {
                    Text('未回答').backgroundColor('#fef0f0').fontColor('#f56c6c').margin(3).padding(5)
                  } else {
                    Text('已回答').backgroundColor('#409eff').fontColor('#f5f7fa').margin(3).padding(5)
                  }
                }.alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Row() {
                  Text("详情").margin({ right: 10 }).onClick(() => {
                    this.isShow = true;
                    this.wenDa = item;
                  })
                }
                if (item.status == 0) {
                  Text("回答").margin({ right: 10 }).onClick(() => {
                    router.replaceUrl({ url: 'pages/info/expert/AnswerQuestionaPage', params: { wenda: item } })
                  })
                } else {
                  Text("    ").margin({ right: 10 })
                }
                Text("删除").margin({ right: 10 }).onClick(() => {
                  AlertDialog.show({
                    title: '提示',
                    message: "你确定要删除[" + item.title + "]吗?",
                    primaryButton: {
                      value: '取消',
                      action: () => {
                      }
                    },
                    secondaryButton: {
                      value: '删除',
                      action: () => {
                        deleteQuestion(item.id).then(data => {
                          let code = JSON.parse(data.result.toString()).code;
                          if (code == 20000) {
                            promptAction.showToast({
                              message: '删除成功!',
                              duration: 1000,
                            });
                            this.wenDaData.splice(index, 1);
                          } else {
                            promptAction.showToast({
                              message: '删除失败!',
                              duration: 2000,
                            });
                          }
                        })
                      }
                    }
                  })
                })
              }
            }
            .borderWidth(1)
            .borderRadius(10)
            .borderColor(Color.Grey)
            .margin(10)
            .padding(10)
            .width('95%')
          },(item, index) => item + index)
        }
      }
      .width('100%').layoutWeight(1).margin({ top: 60, bottom: 60 })

      Panel(this.isShow) {
        Column() {
          Text('详情').margin({ top: 10, bottom: 20 })
          Row() {
            Text('问题标题:').width(90).textAlign(TextAlign.End)
            Text(this.wenDa.title)
          }.margin({ bottom: 20 }).width('100%')
          Row() {
            Text('问题内容:').width(90).textAlign(TextAlign.End)
            Text(this.wenDa.question)
          }.margin({ bottom: 20 }).width('100%')
          Row() {
            Text('问题状态:').width(90).textAlign(TextAlign.End)
            if (this.wenDa.status == 0) {
              Text('未回答').backgroundColor('#fef0f0').fontColor('#f56c6c').margin(3).padding(5)
            } else {
              Text('已回答').backgroundColor('#409eff').fontColor('#f5f7fa').margin(3).padding(5)
            }
          }.margin({ bottom: 20 }).width('100%')
          Row() {
            Button('取消').type(ButtonType.Normal).onClick(() => {
              this.isShow = false;
            })
          }.width('100%').justifyContent(FlexAlign.Center)
        }
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .dragBar(true) // 默认开启
      .halfHeight(300) // 默认一半

    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

function getExpertQuestion() {
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'/question/selectByKind/expert'
  return req.request(
    url,
    {
      method:http.RequestMethod.GET,
      header:{
        Authorization:globalThis.token
      }
    })
}

function deleteQuestion(id:string){
  const req = http.createHttp()
  const url = AppConfig.baseUrl+'question/delete/${id}'
  return req.request(
    url,
    {
      method:http.RequestMethod.DELETE,
      header:{
        Authorization:globalThis.token
      }
    })
}