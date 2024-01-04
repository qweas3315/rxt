import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import { AppConfig } from '../../../config'

@Preview
@Entry
@Component
struct ShowUserInfoPage {
  @State user:any={}
  @State show:boolean=false;
  @State roleChange:number=0
  scroller: Scroller = new Scroller()
  // 从路由中获取用户信息
  aboutToAppear(){
    this.user=router.getParams()["item"];
    let role=this.user.role
    // 判断用户身份，确定select默认选择的项
    if(role =='expert'){
      this.roleChange=1
    }else if(role == 'admin'){
      this.roleChange=2
    }
  }
  showDate(time:string):string{
    return time.substring(0,10)
  }
  build() {
    Stack({alignContent:Alignment.Top}){
      Stack({ alignContent: Alignment.Start }) {
        Text('用户信息')
          .width('100%')
          .height(60)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Grey)
        Image($r('app.media.iv_back_selected')).width(40).height(40)
          .onClick(() => {
            router.back();
          }).margin({ left: 10 })
      }.height(60).width('100%').margin({ top: 10 })
      Scroll(this.scroller){
        Column(){
          List(){
            ListItem(){
              Row() {
                Text("用户名:").width(80)
                Text(this.user.userName).borderRadius(5).layoutWeight(1)
              }.height(60).backgroundColor("#b0e2eafc").width('100%')
              .padding({left:10,right:10})
            }
            ListItem(){
              Row() {
                Text("昵称:").width(80)
                Text(this.user.nickName)
              }.height(60).backgroundColor("#b0f1f1f1").width('100%').padding({left:10})
            }
            ListItem(){
              Row() {
                Text("身份证:").width(80)
                Text(this.user.identityNum)
              }.height(60).backgroundColor("#b0e2eafc").width('100%').padding({left:10})
            }
            ListItem(){
              Row() {
                Text("角色:").width(80)
                Text(this.user.role)
              }.height(60).backgroundColor("#b0f1f1f1").width('100%').padding({left:10})
            }
            ListItem(){
              Row() {
                Text("电话:").width(80)
                Text(this.user.phone)
              }.height(60).backgroundColor("#b0e2eafc").width('100%').padding({left:10})
            }
            ListItem(){
              Row() {
                Text("地址:").width(80)
                Text(this.user.address)
              }.height(60).backgroundColor("#b0f1f1f1").width('100%').padding({left:10})
            }
            ListItem(){
              Row() {
                Text("创建日期:").width(80)
                Text(this.showDate(this.user.createTime))
              }.height(60).backgroundColor("#b0e2eafc").width('100%').padding({left:10})
            }
            ListItem(){
              Row() {
                Text("修改日期:").width(80)
                Text(this.showDate(this.user.updateTime))
              }.height(60).backgroundColor("#b0f1f1f1").width('100%').padding({left:10})
            }
          }.layoutWeight(1).width('100%')
          Row(){
            Button("修改").type(ButtonType.Normal).borderRadius(10).width(80).onClick(()=>{
              this.show=true;
            })
            Button("删除").type(ButtonType.Normal).backgroundColor(Color.Red)
              .borderRadius(10).width(80)
              .onClick(()=>{
                AlertDialog.show({
                  title: '提示',
                  message: "你确定要删除该用户吗？",
                  primaryButton: {
                    value: '取消',
                    action: () => {
                    }
                  },
                  secondaryButton:{
                    value:'确定',
                    action:()=>{
                      // deleteUserInfo(this.user.userName)
                      //   .then(rst=>{
                      //     let data=JSON.parse(rst.result.toString());
                      //     if(data.code==20000){
                      //       promptAction.showToast({message:'删除成功!',duration:2000})
                      //       setTimeout(()=>{
                      //         router.clear();
                      //         router.replaceUrl({url:'pages/admin/ShowUsersPage'})
                      //       },2000);
                      //     }else{
                      //       promptAction.showToast({message:data.data,duration:2000})
                      //     }
                      //   })
                    }
                  }
                })
              })

          }.justifyContent(FlexAlign.SpaceAround).width('100%').margin({bottom:20})
        }.width('100%').height('100%')
      }.layoutWeight(1).width('100%').margin({top:80})
      // 弹窗显示用户修改信息
      Panel(this.show) { // 展示日程
        Column(){
          List(){
            ListItem(){
              Row() {
                Text("昵称:").width(60)
                TextInput({text:this.user.nickName}).onChange(v=>{
                  this.user.nickName=v;
                }).layoutWeight(1).borderRadius(5)
              }.height(60).backgroundColor("#b0f1f1f1").width('100%')
              .padding({left:10,right:10})
            }
            ListItem(){
              Row() {
                Text("身份证:").width(60)
                TextInput({text:this.user.identityNum}).onChange(v=>{
                  this.user.identityNum=v;
                }).layoutWeight(1).borderRadius(5)
              }.height(60).backgroundColor("#b0e2eafc").width('100%')
              .padding({left:10,right:10})
            }
            ListItem(){
              Row() {
                Text("角色:").width(60)
                // TextInput({text:this.user.role}).onChange(v=>{
                //   this.user.role=v
                // }).layoutWeight(1).borderRadius(5)
                Select([
                  {value:'user'},
                  {value:'expert'},
                  {value:'admin'}
                ]).selected(this.roleChange)
                  .value('选择角色')
                  .onSelect((index,value)=>{
                    this.user.role=value
                  })
              }.height(60).backgroundColor("#b0f1f1f1").width('100%').padding({left:10,right:10})
            }
            ListItem(){
              Row() {
                Text("电话:").width(60)
                TextInput({text:this.user.phone}).onChange(v=>{
                  this.user.phone=v;
                }).layoutWeight(1).borderRadius(5)
              }.height(60).backgroundColor("#b0e2eafc").width('100%').padding({left:10,right:10})
            }
            ListItem(){
              Row() {
                Text("地址:").width(60)
                TextInput({text:this.user.address}).onChange(v=>{
                  this.user.address=v;
                }).layoutWeight(1).borderRadius(5)
              }.height(60).backgroundColor("#b0f1f1f1").width('100%').padding({left:10,right:10})
            }
          }.width('100%')
          Row(){
            // Button("确定").type(ButtonType.Normal).borderRadius(10).width(80).onClick(()=>{
            //   this.user.user_name=this.user.userName
            //   updateUserInfo(this.user).then(rst=>{
            //     console.info("============updateUserInfo="+rst.result.toString())
            //     let data=JSON.parse(rst.result.toString());
            //     if(data.code==20000){
            //       promptAction.showToast({message:'修改成功!',duration:2000})
            //       this.show=false
            //     }else{
            //       promptAction.showToast({message:data.message,duration:2000})
            //     }
            //   })
            // })
            // Button("取消").type(ButtonType.Normal).borderRadius(10).width(80).onClick(()=>{
            //   this.show=false;
            // })
          }.justifyContent(FlexAlign.SpaceAround).width('100%').margin({top:10})
        }.width('100%')
      }
      .type(PanelType.Foldable).mode(PanelMode.Half)
      .dragBar(true) // 默认开启
      .halfHeight(400) // 默认一半
    }.width('100%').height("100%")
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}