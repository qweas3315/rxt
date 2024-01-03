/**
 * 组合贷款信息编辑
 */
@Entry
@Component
struct PortfolioLoanInformationEdit {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}