/**
 * 轮播图
 */
@Preview
@Component
export default  struct HomeBroadcast {
  private broadcastList: Array<Resource> = [
    $r('app.media.banner_01'),
    $r('app.media.banner_02'),
    $r('app.media.banner_03'),
    $r('app.media.banner_04'),
    $r('app.media.banner_05'),
  ]
  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Swiper() {
        ForEach(this.broadcastList, item => {
          Image(item).borderRadius(20)
        })
      }.autoPlay(true)
      .loop(true)
      .duration(1000)
    }.width('95%').height(150).margin({ right: 20, left: 20 })
  }
}