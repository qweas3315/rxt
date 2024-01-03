/**
 * 首页组件
 */
import HomeSearch from './component/Search'
@Preview
@Component
export default struct Home {
  build() {
    Column() {
      HomeSearch()
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}