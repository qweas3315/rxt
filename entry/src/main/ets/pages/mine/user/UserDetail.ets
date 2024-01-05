import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import { AppConfig } from '../../../config'
import http from '@ohos.net.http';
import { IUser } from '../../../model/user';
import { deleteUserApi, updateUserApi } from '../../../api/user';

@Preview
@Entry
@Component
struct ShowUserInfoPage {
  @State userDetail: IUser = {}
  @State show: boolean = false;
  @State roleChange: number = 0
  private scroller: Scroller = new Scroller()

  handleShowDate(content: string): string {
    return content.substring(0, 10)
  }

  handleDelete() {
    AlertDialog.show({
      title: '提示',
      message: "你确定要删除该用户吗？",
      primaryButton: {
        value: '取消',
        action: () => {
        }
      },
      secondaryButton: {
        value: '确定',
        action: async () => {

          try {
            const res = await deleteUserApi(this.userDetail.userName)
            const data = JSON.parse(res.result.toString());
            if (data.code == 20000) {
              promptAction.showToast({ message: '删除成功!', duration: 2000 })
              setTimeout(() => {
                // router.clear();
                router.back()
              }, 2000);
            } else {
              promptAction.showToast({ message: data.data, duration: 2000 })
            }
          } catch (error) {
            console.error('handleDelete.error: ', error.message)
          }
        }
      }
    })
  }

  async handleSaveUser() {
    try {
      this.userDetail.password = undefined
      const res = await updateUserApi(this.userDetail)
      console.info('handleLoadKnowledgeList: ', JSON.stringify(res))
      const data = JSON.parse(res.result.toString());
      if (data.code == 20000) {
        promptAction.showToast({ message: '修改成功!', duration: 2000 })
        this.show = false
      } else {
        promptAction.showToast({ message: data.message, duration: 2000 })
      }
    } catch (error) {
      console.error('handleLoadKnowledgeList.error: ', error.message)
    }
  }

  aboutToAppear() {
    this.userDetail = router.getParams()["userDetail"];
    if (this.userDetail?.role == 'expert') {
      this.roleChange = 1
    } else if (this.userDetail?.role == 'admin') {
      this.roleChange = 2
    }
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack({ alignContent: Alignment.Start }) {
        Text('用户信息')
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
            ListItem() {
              Row() {
                Text("用户名:")
                  .width(80)
                Text(this.userDetail?.userName)
                  .borderRadius(5)
                  .layoutWeight(1)
              }
              .height(60)
              .backgroundColor("#b0e2eafc")
              .width('100%')
              .padding({ left: 10, right: 10 })
            }

            ListItem() {
              Row() {
                Text("昵称:")
                  .width(80)
                Text(this.userDetail?.nickName)
              }
              .height(60)
              .backgroundColor("#b0f1f1f1")
              .width('100%')
              .padding({ left: 10 })
            }

            ListItem() {
              Row() {
                Text("身份证:")
                  .width(80)
                Text(this.userDetail?.identityNum)
              }
              .height(60)
              .backgroundColor("#b0e2eafc")
              .width('100%')
              .padding({ left: 10 })
            }

            ListItem() {
              Row() {
                Text("角色:")
                  .width(80)
                Text(this.userDetail?.role)
              }
              .height(60)
              .backgroundColor("#b0f1f1f1")
              .width('100%')
              .padding({ left: 10 })
            }

            ListItem() {
              Row() {
                Text("电话:")
                  .width(80)
                Text(this.userDetail?.phone)
              }
              .height(60)
              .backgroundColor("#b0e2eafc")
              .width('100%')
              .padding({ left: 10 })
            }

            ListItem() {
              Row() {
                Text("地址:")
                  .width(80)
                Text(this.userDetail?.address)
              }
              .height(60)
              .backgroundColor("#b0f1f1f1")
              .width('100%')
              .padding({ left: 10 })
            }

            ListItem() {
              Row() {
                Text("创建日期:")
                  .width(80)
                Text(this.handleShowDate(this.userDetail?.createTime))
              }
              .height(60)
              .backgroundColor("#b0e2eafc")
              .width('100%')
              .padding({ left: 10 })
            }

            ListItem() {
              Row() {
                Text("修改日期:")
                  .width(80)
                Text(this.handleShowDate(this.userDetail?.updateTime))
              }
              .height(60)
              .backgroundColor("#b0f1f1f1")
              .width('100%')
              .padding({ left: 10 })
            }
          }
          .layoutWeight(1)
          .width('100%')

          Row() {
            Button("修改")
              .type(ButtonType.Normal)
              .borderRadius(10)
              .width(80)
              .onClick(() => this.show = true)
            Button("删除")
              .type(ButtonType.Normal)
              .backgroundColor(Color.Red)
              .borderRadius(10)
              .width(80)
              .onClick(() => this.handleDelete())

          }
          .justifyContent(FlexAlign.SpaceAround)
          .width('100%')
          .margin({ bottom: 20 })
        }
        .width('100%')
        .height('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .margin({ top: 80 })

      Panel(this.show) {
        Column() {
          List() {
            ListItem() {
              Row() {
                Text("昵称:")
                  .width(60)
                TextInput({ text: this.userDetail?.nickName })
                  .onChange((value: string) => this.userDetail.nickName = value)
                  .layoutWeight(1)
                  .borderRadius(5)
              }
              .height(60)
              .backgroundColor("#b0f1f1f1")
              .width('100%')
              .padding({ left: 10, right: 10 })
            }

            ListItem() {
              Row() {
                Text("身份证:")
                  .width(60)
                TextInput({ text: this.userDetail?.identityNum })
                  .onChange((value: string) => this.userDetail.identityNum = value)
                  .layoutWeight(1)
                  .borderRadius(5)
              }
              .height(60)
              .backgroundColor("#b0e2eafc")
              .width('100%')
              .padding({ left: 10, right: 10 })
            }

            ListItem() {
              Row() {
                Text("角色:")
                  .width(60)
                Select([
                  { value: 'user' },
                  { value: 'expert' },
                  { value: 'admin' }
                ])
                  .selected(this.roleChange)
                  .value('选择角色')
                  .onSelect((_, value) => this.userDetail.role = value)
              }
              .height(60)
              .backgroundColor("#b0f1f1f1")
              .width('100%')
              .padding({ left: 10, right: 10 })
            }

            ListItem() {
              Row() {
                Text("电话:")
                  .width(60)
                TextInput({ text: this.userDetail?.phone })
                  .onChange((value: string) => this.userDetail.phone = value)
                  .layoutWeight(1)
                  .borderRadius(5)
              }
              .height(60)
              .backgroundColor("#b0e2eafc")
              .width('100%')
              .padding({ left: 10, right: 10 })
            }

            ListItem() {
              Row() {
                Text("地址:")
                  .width(60)
                TextInput({ text: this.userDetail?.address })
                  .onChange((value: string) => this.userDetail.address = value)
                  .layoutWeight(1)
                  .borderRadius(5)
              }
              .height(60)
              .backgroundColor("#b0f1f1f1")
              .width('100%')
              .padding({ left: 10, right: 10 })
            }
          }.width('100%')

          Row() {
            Button("确定")
              .type(ButtonType.Normal)
              .borderRadius(10)
              .width(80)
              .onClick(() => this.handleSaveUser())
            Button("取消")
              .type(ButtonType.Normal)
              .borderRadius(10)
              .width(80)
              .onClick(() => this.show = false)
          }
          .justifyContent(FlexAlign.SpaceAround)
          .width('100%')
          .margin({ top: 10 })
        }
        .width('100%')
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .dragBar(true)
      .halfHeight(400)
    }
    .width('100%')
    .height("100%")
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}

export function deleteUserInfo(userName: string) {

  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/${userName}`, {
    method: http.RequestMethod.DELETE,
    header: {
      Authorization: globalThis.token
    }
  })
}

export function updateUserInfo(user: any) {

  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/${user.userName}`, {
    method: http.RequestMethod.PUT,
    header: {
      Authorization: globalThis.token
    },
    extraData: {
      address: user.address,
      identityNum: user.identityNum,
      nickName: user.nickName,
      phone: user.phone,
      role: user.role,
      user_name: user.userName
    }
  })

}