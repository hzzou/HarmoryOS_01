import { common } from '@kit.AbilityKit'

@Entry
@Component
struct Home{
  context?: common.UIAbilityContext;

  onPageShow(): void {
    this.context = getContext(this) as common.UIAbilityContext;
  }
  build() {
    Column(){
      Image('pages/firstStart/images/ic_home.png')
        .width('100%')
        .height('50%')
      Column(){
        Text('Hello World')
          .fontSize($r('sys.float.ohos_id_text_size_headline5'))
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .fontWeight(FontWeight.Bolder)
          .textAlign(TextAlign.Center)

        Blank()
        Button('退出')
          .width('20%')
          .height('10%')
          .onClick(()=>{
            this.context?.terminateSelf();
          })
      }
      .padding({top: '5%', bottom: '5%'})
      .width('100%')
      .height('50%')
      .backgroundColor($r('sys.color.ohos_id_color_background'))
    }
  }
}