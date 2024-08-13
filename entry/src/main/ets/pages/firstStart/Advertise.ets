import { router } from '@kit.ArkUI';

@Entry
@Component
struct Advertise{
  @State countDownSec: number = 5;
  private timeId: number = 0;

  onPageShow(): void {
    this.timeId = setInterval(()=>{
      if(this.countDownSec === 0){
        this.goHome();
      }
      else{
        this.countDownSec--;
      }
    }, 1000);
  }

  onPageHide(): void {
    //清空历史页面栈，释放内存空间
    // router.clear();
    clearInterval(this.timeId);
  }

  goHome(){
    router.pushUrl({url: 'pages/firstStart/Home'});
  }

  build() {
    Stack({alignContent: Alignment.Top}){
      Image('pages/firstStart/images/ic_advertise.png')
        .width('100%')
        .height('100%')

      Text(`跳过广告 ${this.countDownSec}s`)
        .fontColor('#fff')
        .fontSize('12fp')
        .letterSpacing('0.05')
        .backgroundColor('#33000000')
        .border({radius: 18, width: 1, color: '#fff'})
        .margin({top: 20, left: 250})
        .padding({left: 12, right: 12, top: 8, bottom: 8})
        .onClick(()=>{
          this.goHome();
        })

      Row(){
        Image('pages/firstStart/images/ic_logo.png')
          .width(54)
          .height(54)
          .margin({bottom: '3%'})

        Column(){
          Text('健康生活')
            .fontWeight(FontWeight.Bolder)
            .letterSpacing(0.1)
            .fontSize('26fp')
            .fontColor('#182431')

          Text('健康总有新玩法')
            .fontWeight(FontWeight.Normal)
            .letterSpacing(3.5)
            .fontSize('16fp')
            .fontColor('#182431')
            .opacity(0.4)
            .margin({top: '0.5%'})
        }
        .alignItems(HorizontalAlign.Start)
        .margin({left: '3%', bottom: '3%'})
      }
      .alignItems(VerticalAlign.Bottom)
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}