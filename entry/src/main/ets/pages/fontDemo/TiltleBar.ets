import { router } from '@kit.ArkUI';
import { preferences } from '@kit.ArkData';

@Component
export default struct TitleBar{
  isBack: boolean = true;
  title: string = '';
  @Link changeFontSize: preferences.ValueType;

  build() {
    Row(){
      if(this.isBack){
        Image('pages/fontDemo/images/ic_back.png')
          .width(24)
          .height(24)
          .margin({right: 4})
          .onClick(()=>{
            router.back();
          })

      }

      Text(this.title)
        .fontColor('#000')
        .fontSize(this.changeFontSize+'fp')
        .fontWeight(FontWeight.Medium)
        .margin({left: 8})
    }
    .width('100%')
    .height('7%')
    .backgroundColor('#fff')
    .padding({left: 16})
  }
}