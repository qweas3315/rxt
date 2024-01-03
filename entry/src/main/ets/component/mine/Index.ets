import PageHeader from '../header'
import BasicInfo from './component/Basic'
import FinancingInfo from './component/Financing'
import MineCardInfo from './component/Info'
import {UserMineNavigator} from './component/Navigator'
import OtherOperate from './component/Operate'

@Preview
@Component
export default struct Mine {
  @State isLogin: boolean = false

  build() {
    Column() {
      PageHeader({ title: '我的' })
      MineCardInfo({ isLogin: this.isLogin })
      UserMineNavigator()
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