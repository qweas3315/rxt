import PageHeader from '../../component/header'
import BasicInfo from './component/basic'
import FinancingInfo from './component/financing'
import MineCardInfo from './component/info'
import MineNavigator from './component/navigator'
import OtherOperate from './component/operate'

@Preview
@Component
export default struct Mine {
  @State isLogin: boolean = false

  build() {
    Column() {
      PageHeader({ title: '我的' })
      MineCardInfo({ isLogin: this.isLogin })
      MineNavigator()
      BasicInfo()
      FinancingInfo()
      OtherOperate()
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg4'))
    .backgroundImageSize(ImageSize.Cover)
  }
}