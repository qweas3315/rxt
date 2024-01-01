@Preview
@Component
export struct CellTitle {
  @Prop title: string

  build() {
    Column() {
      Text(this.title).titleStyle()
    }
  }
}

@Extend(Text) function titleStyle() {
  .fontSize(16)
  .fontColor('#0F142A')
  .height(30)
  .width('100%')
  .margin({ left: 20, top: 10, bottom: 10 })
}

@Builder
export function builderCellItem(label: string, icon: Resource) {
  Row() {
    Image(icon)
      .width(20)
      .height(20)
      .margin({ right: 10 })
    Text(label)
      .height(20)
      .fontSize(16)
      .fontColor('#0F172A')
      .flexGrow(1)
      .fontWeight(400)
    Image($r('app.media.chevron_right'))
      .width(16)
      .width(16)
  }
  .width('100%')
  .height(55)
  .padding({ left: 20, right: 20 })
}