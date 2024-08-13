import { multiplicationTable } from '../common/utils/Method';

@CustomDialog
export struct MultiplicationDialog{
  isCustomController?: CustomDialogController;

  build() {
    Column(){
      Column(){
        Text('弹窗')
          .height($r('app.float.button_height'))
          .fontSize('16fp')
          .fontColor('#f00')
          .margin({top: $r('app.float.dialog_text_margin_top')})

        Text('九九乘法表')
          .fontSize('16fp')
          .fontColor('#333')
          .margin({left: $r('app.float.dialog_text_margin_left')})
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height($r('app.float.dialog_text_height'))

      Column(){
        List({space: 10, initialIndex: 0, }){
          ForEach(multiplicationTable(), (item: string[], index: number)=>{
            ListItemGroup(){
              ForEach(item, (data: string, idx: number)=>{
                ListItem(){
                  Text(item[idx])
                    .height('20vp')
                    .fontSize('16vp')
                }
                .backgroundColor("#0ff")
              })
            }
          })
        }
        .scrollBar(BarState.Auto)
      }
      .width('100%')
    }
  }
}