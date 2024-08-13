import { contentInter } from './SetFontSize';
import { preferences } from '@kit.ArkData';

@Component
export default struct ChatItem{
  @Prop item: contentInter;
  @Prop changeFontSize: preferences.ValueType = 0;

  build() {
    Row(){
      Image(this.item.direction === 'right' ? 'pages/fontDemo/images/right_head.png' : 'pages/fontDemo/images/left_head.png')
        .width('9%')
        .aspectRatio(1)
        .margin({
          left: this.item.direction === 'right' ? '2%' : '7%',
          right: this.item.direction === 'right' ? '7%' : '2%',
        })

      ChatContent({item: this.item, changeFontSize: this.changeFontSize})
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .direction(this.item.direction === 'right' ? Direction.Rtl : Direction.Ltr)
    .margin({top: '3%'})
  }
}

@Component
struct ChatContent{
  @Prop item: contentInter;
  @Prop changeFontSize: preferences.ValueType = 0;

  @State isLineFeed: boolean = false;

  build() {
    Row(){
      Text(this.item.content)
        .fontColor('#182431')
        .fontSize(this.changeFontSize+'fp')
        .fontWeight(FontWeight.Medium)
        .onAreaChange((oldValue: Area, newValue: Area)=>{
          console.log('new:', newValue);
        })

      if(this.isLineFeed){
        Blank()
          .layoutWeight(1)
      }
    }
    .direction(Direction.Ltr)
    .padding({left: 20, right: 20, top: 12, bottom: 12})
    .backgroundColor(this.item.direction === 'right' ? '#d7e9f3' : '#fff')
    .borderRadius(24)
    .constraintSize({maxWidth: '65%'})
  }
}