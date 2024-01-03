/**
 * 搜索框
 */
import promptAction from '@ohos.promptAction'
import { searchAllByKeys } from '../../../api/order'

@Preview
@Component
export default struct HomeSearch {
  @State keyword: string = ''

  handleSearch() {
    if (this.keyword.trim().length === 0) {
      promptAction.showToast({ message: '请输入搜索内容后进行搜索', duration: 1000 })
      return
    }
  }

  build() {
    Row() {
      Text("青岛")
        .padding({ left: 5 })
      Text()
        .height(35)
        .border({ width: 1, color: '#C6C9CD' })
        .margin({ left: 5, right: 5 })
      Image($r('app.media.Search_1'))
        .width(20)
        .height(20)
        .margin({ left: 10 })
      TextInput({ placeholder: '搜索' })
        .onChange((value: string) => {
          this.keyword = value
        })
        .layoutWeight(1)
        .borderWidth(0)
        .borderRadius(1)
        .backgroundColor(Color.White)
        .height(50)
        .placeholderColor(Color.Gray)
      Button('确定')
        .margin({ right: 10 })
        .backgroundColor(Color.Transparent)
        .onClick(() => this.handleSearch())
        .fontColor(Color.Black)
    }
    .backgroundColor(Color.White)
    .width('95%')
    .margin(10)
    .borderRadius(5)
  }
}