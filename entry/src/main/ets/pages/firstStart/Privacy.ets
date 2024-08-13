import { router } from '@kit.ArkUI'

@Entry
@Component
struct Privacy{

  build() {
    Column(){
      Text('隐私政策')
        .fontSize('20fp')
        .textAlign(TextAlign.Center)
        .margin({top: 10, bottom: 10})

      Text('本声明的重要组成部分，服务如何处理您的个人信息，您如何行使您的数据主体权利，相关的数据控制者以及如何联系该数据控制者等基本情况，由该隐私通知进行阐述。若隐私通知与本声明之间存在不一致，以该隐私通知为准，隐私通知中未约定的，以本声明为准。')
        .fontSize('18fp')
        .margin({left: 24, right: 24})

      Text('返回')
        .fontColor('#007dff')
        .fontSize('20fp')
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Medium)
        .margin({top: 12})
        .onClick(()=>{
          router.back();
        })
    }
    .justifyContent(FlexAlign.Center)
    .height('100%')
  }
}