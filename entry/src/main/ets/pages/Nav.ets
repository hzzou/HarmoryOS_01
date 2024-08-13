import { webview } from '@kit.ArkWeb';

@Preview
@Entry
@Component
struct Nav{
  // pageStack自己用之外，@Provide('NavPathStack')定义给NavDestination子组件的
  // @Consume('NavPathStack')用
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack();

  @Builder
  PageMap(name: string){
    if(name === "Dialog"){
      Dialog()
    }
    else{
      Custom()
    }
  }

  // NavDestination创建之前
  aboutToAppear(): void {
    console.log("aboutToAppear")
  }

  build() {
    Navigation(this.pageStack){
      Column(){
        Button('去第一个弹窗')
          .margin(20)
          .width('80%')
          .onClick(()=>{
            //router.pushUrl({ url: "pages/Second" });
            this.pageStack.pushPathByName("Dialog", '');
          })
      }

      Button('去第二个页面')
        .width('80%')
        .onClick(()=>{
          //router.pushUrl({ url: "pages/Five" })
          this.pageStack.pushPathByName("Custom", '');
        })
    }
    .title("Main")
    .mode(NavigationMode.Stack)
    .navDestination(this.PageMap)
  }
}

@Component
struct Dialog{
  // 来自父组件的@Provide('NavPathStack')
  @Consume('NavPathStack') pageStack: NavPathStack; // 用于类router那样关闭页面


  build() {
    NavDestination(){
      Stack({alignContent: Alignment.Center}){
        Column(){
          Text('NavDes Dialog')
            .fontSize(20)

          Blank()
          Button('关闭')
            .width('30%')
            .onClick(()=>{
              // 关闭弹窗
              this.pageStack.pop();
            })
        }
        .padding({top: 20, bottom: 20})
        .width('80%')
        .height('30%')
        .borderRadius(10)
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.Center)
      }
      .height('100%')
      .width('100%')
    }
    .mode(NavDestinationMode.DIALOG)
    .hideTitleBar(true)
    .backgroundColor('rgba(0, 0, 0, 0.5)')
  }
}

@Component
struct Custom{
  @Consume('NavPathStack') pageStack: NavPathStack;

  webController: WebviewController = new webview.WebviewController();

  build() {
    NavDestination(){
      Column(){
        Text('NavDes Custom')
          .fontSize(20)

        Blank() // 自适应中间的空白空间
        Button('关闭')
          .width('30%')
          .margin({bottom: 20})
          .onClick(()=>{
            // 关闭弹窗ß
            this.pageStack.pop();
          })
      }
      .padding({top: 20, bottom: 20})
      .width('100%')
      .height('100%')
    }
    .mode(NavDestinationMode.STANDARD)
  }
}