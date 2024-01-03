/**
 * 首页组件
 */
import HomeBroadcast from './component/Broadcast'
import HomeNavigator from './component/Navigator'
@Preview
@Component
export default struct Home {
  build() {
    Column() {
      HomeBroadcast()
      HomeNavigator()
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}