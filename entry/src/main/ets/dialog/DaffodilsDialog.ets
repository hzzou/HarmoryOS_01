import { daffodilsNumber } from '../common/utils/Method';


@CustomDialog
export struct DaffodilsDialog{
  isCustomController?: CustomDialogController;

  // vp 表示virtual pixel 虚拟像素
  // fp 表示fontSize pixel 字体像素
  build(){
    Column(){
      Column(){
        Text("弹窗")
          .height($r('app.float.button_height'))
          .fontSize('16fp')
          .fontColor('#333')
          .margin({top: $r('app.float.dialog_text_margin_top')})
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height($r('app.float.dialog_text_height'))

      Text(daffodilsNumber().toString())
        .font({size: '20fp'})
        .fontColor('#333')
        .margin({top: $r('app.float.dialog_padding')})
    }
    .alignItems(HorizontalAlign.Center)
    .padding({
      left: $r('app.float.dialog_padding'),
      right: $r('app.float.dialog_padding'),
      bottom: $r('app.float.dialog_padding')
    })
  }
}