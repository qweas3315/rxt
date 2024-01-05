/**
 * 专家信息管理
 */
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { searchExpertApi, updateExpertApi } from '../../../api/user'
import { IResponse } from '../../../model/common'
import { IExpert } from '../../../model/question'

@Entry
@Component
struct ExpertInformationChange {
  @State expert: IExpert = {}

  async handleLoadExpert() {
    try {
      const res = await searchExpertApi()
      const data: IResponse<IExpert> = <IResponse<IExpert>> JSON.parse(res.result.toString())
      this.expert = data.data || {
        belong: '',
        phone: '',
        position: '',
        profession: '',
        realName: '',
        userName: ''
      }
      console.info('handleLoadExpert: ', res.result.toString())
    } catch (error) {
      console.error('handleLoadExpert.error: ', error.message)
    }
  }

  async handleUpdateExpert() {
    try {
      const res = await updateExpertApi(this.expert)
      const data = JSON.parse(res.result.toString());
      promptAction.showToast({ message: data.message, duration: 2000 })
    } catch (error) {
      console.error('handleUpdateExpert.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.handleLoadExpert()
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('专家信息')
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

      Column() {
        List() {
          ListItem() {
            Row() {
              Text('真实姓名:')
                .width(100)
              TextInput({ text: this.expert.realName })
                .onChange((value: string) => this.expert.realName = value)
                .borderRadius(5)
                .height(40)
                .width(250)
            }
            .width('100%')
          }
          .padding({ left: 20, right: 20 })
          .height(80)

          ListItem() {
            Row() {
              Text('手机号码:')
                .width(100)
              TextInput({ text: this.expert.phone })
                .onChange((value: string) => this.expert.phone = value)
                .borderRadius(5)
                .height(40)
                .width(250)
            }
            .width('100%')
          }
          .padding({ left: 20, right: 20 })
          .height(80)

          ListItem() {
            Row() {
              Text('从事专业:')
                .width(100)
              TextInput({ text: this.expert.profession })
                .onChange((value: string) => this.expert.profession = value)
                .borderRadius(5)
                .height(40)
                .width(250)
            }
            .width('100%')
          }
          .padding({ left: 20, right: 20 })
          .height(80)

          ListItem() {
            Row() {
              Text('职位:')
                .width(100)
              TextInput({ text: this.expert.position })
                .onChange((value: string) => this.expert.position = value)
                .borderRadius(5)
                .height(40)
                .width(250)
            }
            .width('100%')
          }
          .padding({ left: 20, right: 20 })
          .height(80)

          ListItem() {
            Row() {
              Text('所属单位:')
                .width(100)
              TextInput({ text: this.expert.belong })
                .onChange((value: string) => this.expert.belong = value)
                .borderRadius(5)
                .height(40)
                .width(250)
            }
            .width('100%')
          }
          .padding({ left: 20, right: 20 })
          .height(80)
        }
        .height('100%')
      }
      .width("100%")
      .height('100%')

      Row() {
        Button("修改")
          .width(100).borderRadius(5)
          .onClick(() => this.handleUpdateExpert())
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: -200 })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}