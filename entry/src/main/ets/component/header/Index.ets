@Preview
@Component
export default struct PageHeader {
  @Prop title: string
  build() {
    Row() {
      Text(this.title)
        .fontColor('#F8FAFC')
        .width(44)
        .height(28)
        .fontSize(22)
        .margin({ left: 24, top: 14 })
    }.width('100%')
  }
}