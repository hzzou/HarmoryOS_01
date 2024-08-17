import { webview } from '@kit.ArkWeb'
import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct WebComponent{
  webController: WebviewController = new webview.WebviewController();

  build() {
    Column(){
      Button('LoadUrl')
        .onClick(()=>{
          try{
            console.log('121')
            this.webController.loadUrl("www.csdn.net");
            //this.webController.loadUrl($rawfile('ceshi.html'));
          } catch (err) {
            console.log("err:",err)
          }
        })

      // Web组件不能使用Preview预览,需要在模拟器或者真机上
      //Web({src: 'www.baidu.com', controller: this.webController, incognitoMode: true})
      //Web({src: $rawfile('course_learning/index.html'), controller: this.webController, incognitoMode: true})
      //Web({src: "resource://rawfile/course_learning/index.html", controller: this.webController})
      Web({src: $rawfile("index.html"), controller: this.webController})
        .javaScriptAccess(true) // 表示允许执行js脚本
        .onPageEnd((e)=>{
          console.log(JSON.stringify(e));

          try{
            this.webController.runJavaScript("fn_1()")
              .then((res)=>{
                console.log("res: ", res);
              })
          } catch (error) {
          }
        })

    }
  }
}