import { webview } from '@kit.ArkWeb'

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
            //this.webController.loadUrl("www.csdn.net");
            this.webController.loadUrl($rawfile('ceshi.html'));
          } catch (err) {
            console.log("err:",err)
          }
        })
      // Web组件不能使用Preview预览
      //Web({src: 'www.baidu.com', controller: this.webController, incognitoMode: true})
      Web({src: $rawfile('course_learning/index.html'), controller: this.webController, incognitoMode: true})
    }
  }
}