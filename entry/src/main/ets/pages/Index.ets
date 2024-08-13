import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { DaffodilsDialog } from '../dialog/DaffodilsDialog';
import { MultiplicationDialog } from '../dialog/MultiplicationDialog';


// control + option + O 去除无用import引用
//  @Entry是作为UI路由页面入口的标志
//  @Component作为一个可复用组件的标志
//  若一个组件只是做可复复用组件而非页面入口，则可以不添加@Entry，只用@Component即可
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State color: Color = Color.Brown;

  dialogController: CustomDialogController = new CustomDialogController({
    builder: DaffodilsDialog(),
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -25 }
  });

  multiController: CustomDialogController = new CustomDialogController({
    builder: MultiplicationDialog(),
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -25 }
  });

  //  自定义渲染组件
  @Builder doSomeRender(){
    Text('自定义组件')
  }

  // 自定义函数
  doSome(event: ClickEvent){
    console.log("ev:");
    console.dir(event);
    console.log(this.message);

    this.color = Color.Blue;
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        //this.doSomeRender();

        /*Button(){
          Text("调用自定义方法测试")
            .fontSize('20fp')
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({top: 20})
        .backgroundColor(this.color)
        .width('50%')
        .height('5%')
        .onClick((event: ClickEvent)=>{
          this.doSome(event);
        })*/

        /*Button() {
          Text('测试弹窗')
            .fontSize('30fp')
        }
        .type(ButtonType.Capsule)
        .margin({ top: 20 })
        .backgroundColor('#ff1abbd7')
        .width('40%')
        .height('5%')
        .onClick(() => {
          //this.dialogController?.open();
          this.multiController?.open();
        })*/

        Button() {
          Text('Next')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#ff126eb5')
        .width('40%')
        .height('5%')
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ToDoList'
          }).then(() => {
            console.info('跳转成功');
            // BusinessError为接口调用失败的公共错误信息类型
          }).catch((err: BusinessError) => {
            console.error(`跳转失败${err}`);
          })
        })

      }
      .width('100%')
    }
    .height('100%')
  }
}