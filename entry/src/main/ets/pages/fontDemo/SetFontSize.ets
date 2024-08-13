import ChatItem from './ChatItem';
import TitleBar from './TiltleBar';
import { preferences } from '@kit.ArkData';
import PreferenceUtil from './PreferenceUtil';

export interface contentInter{
  content: string;
  direction: string;
}

export interface fontSizeInter{
  name: string;
  value: number;
}

@Entry
@Component
struct SetFontSize{
  private contentArr: contentInter[] = [
    {content: '你知道现在可以在健康生活添加各种健康目标打卡吗？', direction: 'right'},
    {content: '知道，我添加了运动和饮食相关的目标。', direction: 'left'},
    {content: '太好了，感觉怎么样', direction: 'right'},
    {content: '生活状态越来越好，你也一起试试吧！', direction: 'left'},
  ];

  @State changeFontSize: preferences.ValueType = 16;
  @State fontSizeText: string = '标准';

  onPageShow(): void {
    PreferenceUtil.getPreference('MyPreference', 'FontSize', this.changeFontSize).then((value: preferences.ValueType)=>{
      this.changeFontSize = value;
    })
  }


  build() {
    Column(){
      TitleBar({title: '字体大小设置', changeFontSize: $changeFontSize})
      if(this.changeFontSize > 0){
        List(){
          ForEach(this.contentArr, (item: contentInter)=>{
            ListItem(){
              ChatItem({item: item, changeFontSize: this.changeFontSize})
            }
          }, (item: contentInter)=>JSON.stringify(item))
        }
        .layoutWeight(1)
      }

      SliderLayout({fontSizeText: $fontSizeText, changeFontSize: $changeFontSize})
    }
    .backgroundColor('#dedede')
    .height('100%')
    .width('100%')
  }
}


@Component
struct SliderLayout{
  @Watch('sizeChange') @Link changeFontSize: preferences.ValueType;
  @Link fontSizeText: string;
  private fontSizeArr: fontSizeInter[] = [
    {name: '小', value: 14},
    {name: '标准', value: 16},
    {name: '大', value: 18},
    {name: '超大', value: 20},
    {name: '特大', value: 22},
  ];

  // sizeChange函数带的参数是变量名，指明哪个变量在变化，不是变量值
  sizeChange(){
    this.fontSizeArr.map((ele)=>{
      if(ele.value === this.changeFontSize){
        this.fontSizeText = ele.name;
      }
    })
  }

  build() {
    Column(){
      Text('文字大小')
        .fontSize('14fp')
        .fontColor('#182431')
        .margin({left: '6.5%', top: '3%'})
        .fontWeight(FontWeight.Medium)

      Column(){
        Text(this.fontSizeText)
          .fontSize('14fp')
          .fontColor('#182431')

        Row(){
          Text('A')
            .fontColor('#182431')
            .fontSize('20fp')
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.End)
            .width('12%')
            .padding({right: 10})

          Slider({
            value: this.changeFontSize as number,
            min: 14,
            max: 22,
            step: 2,
            style: SliderStyle.InSet
          })
            .showSteps(true)
            .width('75%')
            .onChange((value: number)=>{
              console.log(value+' change')
              this.fontSizeArr.map((ele)=>{
                if(ele.value === value){
                  this.fontSizeText = ele.name;
                  this.changeFontSize = value;
                  PreferenceUtil.setPreference('MyPreference', 'FontSize', value);
                }
              })
            })

          Text('A')
            .fontColor('#182431')
            .fontSize('24fp')
            .fontWeight(FontWeight.Bold)
            .width('13%')
            .padding({left: 8})
        }
      }
      .backgroundColor('#fff')
      .borderRadius(24)
      .width('93%')
      .padding({top: 16, bottom: 20})
      .margin({left: '3%', right: '3%', top: '1%', bottom: '6%'})
    }
    .alignItems(HorizontalAlign.Start) // 交叉轴上
    .justifyContent(FlexAlign.End)
  }
}