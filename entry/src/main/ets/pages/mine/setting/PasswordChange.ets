/**
 * 修改密码
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { updatePasswordApi } from '../../../api/user';

@Entry
@Component
struct PasswordChange {
  @State oldPassword: string = '';
  @State newPassword: string = '';
  @State reNewPassword: string = '';

  async handleUpdatePassword() {
    try {
      const res = await updatePasswordApi(this.newPassword, this.oldPassword)
      const code = JSON.parse(res.result.toString()).code;
      if (code == 20000) {
        promptAction.showToast({
          message: '修改成功!下次请使用新密码登录!',
          duration: 1000,
        });
        setTimeout(() => {
          const routerList: Array<string> = globalThis.routerList
          const routerUrl = routerList.pop();
          globalThis.routerList = routerList;
          router.replaceUrl({ url: routerUrl })
        }, 1000)
      } else {
        promptAction.showToast({
          message: '修改失败!',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('handleUpdatePassword.error: ', error.message)
    }
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('修改密码')
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
              Text('原始密码:')
                .width(100)
              TextInput()
                .type(InputType.Password)
                .onChange((value: string) => this.oldPassword = value)
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('新密码:')
                .width(100)
              TextInput()
                .type(InputType.Password)
                .onChange((value: string) => this.newPassword = value)
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)

          ListItem() {
            Row() {
              Text('确认新密码:')
                .width(100)
              TextInput()
                .type(InputType.Password)
                .onChange((value: string) => this.reNewPassword = value)
                .borderWidth(0)
                .backgroundColor(Color.Transparent)
            }
          }
          .padding({ left: 20, right: 20 })
          .height(60)
        }
        .divider({ strokeWidth: 1, color: '#f1f1f1', startMargin: 20, endMargin: 20 })
        .borderRadius(10)
        .margin(5)
        .backgroundColor('#ffffff')
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)

      Row() {
        Button("保存")
          .fontColor(Color.White)
          .backgroundColor(Color.Red)
          .type(ButtonType.Normal)
          .width('100%')
          .borderRadius(20)
          .onClick(() => this.handleUpdatePassword())
      }
      .alignItems(VerticalAlign.Bottom)
      .padding(10)
      .backgroundColor('#ffffff')
      .width('100%')
    }
    .height('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}