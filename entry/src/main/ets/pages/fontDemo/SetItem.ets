import { setInter } from './Index';
import { preferences } from '@kit.ArkData';

@Component
export default struct SetItem{
  @Prop itemData: setInter;
  @Prop changeFontSize: preferences.ValueType = 0;
  itemClick: Function = ()=>{};

  build() {
    Row(){
      Image(this.itemData.img)
        .height(24)
        .width(24)
        .margin({left: 12, right: 8})

      Text(this.itemData.name)
        .fontSize(this.changeFontSize+'fp')
        .fontColor('#182431')
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(48)
    .onClick(()=>{
      this.itemClick()
    })
  }
}