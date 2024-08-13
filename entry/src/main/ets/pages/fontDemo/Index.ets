import SetItem from './SetItem';
import TitleBar from './TiltleBar'
import { router } from '@kit.ArkUI';
import PreferenceUtil from './PreferenceUtil';
import { preferences } from '@kit.ArkData';


export interface setInter{
  id: number;
  name: string;
  img: string;
}

@Entry
@Component
struct FontPage{
  private setArr: setInter[] = [
    {id: 0, name: '显示和亮度', img: 'pages/fontDemo/images/ic_brightness.png'},
    {id: 1, name: '声音', img: 'pages/fontDemo/images/ic_voice.png'},
    {id: 2, name: '应用管理', img: 'pages/fontDemo/images/ic_manage.png'},
    {id: 3, name: '存储', img: 'pages/fontDemo/images/ic_storage.png'},
    {id: 4, name: '隐私', img: 'pages/fontDemo/images/ic_privacy.png'},
    {id: 5, name: '设置字体大小', img: 'pages/fontDemo/images/ic_setting.png'},
  ];
  @State changeFontSize: preferences.ValueType = 16;

  onPageShow(): void {
    PreferenceUtil.getPreference('MyPreference', 'FontSize', this.changeFontSize).then((value: preferences.ValueType)=>{
      //console.log(value+'')
      this.changeFontSize = value;
      console.log("读取成功")
    })
  }

  build() {
    Column(){
      // @Link传值必须用$变量名，且不能初始化
      TitleBar({isBack: false, title: '设置', changeFontSize: $changeFontSize})

      Row(){
        List(){
          ForEach(this.setArr, (item: setInter)=>{
            ListItem(){
              SetItem({itemData: item, changeFontSize: this.changeFontSize, itemClick: ()=>{
                if(item.id === 5){
                  router.pushUrl({url: 'pages/fontDemo/SetFontSize'});
                }
              }})
            }
          }, (item: setInter)=>JSON.stringify(item))
        }
        .divider({
          strokeWidth: 1,
          color: '#dedede',
          startMargin: 44
        })
      }
      .backgroundColor('#fff')
      .borderRadius(24)
      .margin({top: '1.5%'})
      .padding({top: 4, bottom: 4})
      .width('93%')
    }
    .backgroundColor('#dedede')
    .width('100%')
    .height('100%')
  }
}