import { router } from '@kit.ArkUI';


@CustomDialog
export default struct CustomDialogComponent{
  controller: CustomDialogController;
  confirm: Function = () => {};
  cancel: Function = () => {};

  build() {
    Column(){
      Text('欢迎使用我的应用')
        .width('90%')
        .fontColor('#182431')
        .fontSize('20fp')
        .textAlign(TextAlign.Center)
        .fontWeight(600)
        .margin({top: 24, bottom: 12})

      Text('我们充分尊重用户的隐私权，并按照法律要求和业界成熟的安全标准，为您的个人信息提供相应的安全保护措施。')
        .fontSize('18fp')
        .width('90%')

      Text('隐私协议保护声明')
        .width('90%')
        .fontColor('#007dff')
        .fontSize('18fp')
        .onClick(()=>{
          this.controller.close();
          router.pushUrl({url: 'pages/firstStart/Privacy'})
        })

      Text('（以下简称为“本声明”）以便您了解我们如何搜集、使用、披露、保护、存储及传输您的个人数据。请您仔细阅读本声明。如您有任何疑问，请告知我们。')
        .width('90%')
        .fontColor('18fp')
        .fontColor('#182431')
        .opacity(0.6)
        .margin({bottom: 24})

      Row(){
        Text('不同意')
          .fontColor('#007dff')
          .fontSize('16fp')
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .onClick(()=>{
            this.controller.close();
            this.cancel();
          })

        Blank()
          .backgroundColor('#f5f5f5')
          .width(1)
          .height(32)

        Text('同意')
          .fontColor('#007dff')
          .fontSize('16fp')
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .onClick(()=>{
            this.controller.close();
            this.confirm();
          })
      }
      .margin({bottom: '3%'})
    }
    .width('93%')
    .borderRadius(24)
    .backgroundColor('#fff')
  }
}