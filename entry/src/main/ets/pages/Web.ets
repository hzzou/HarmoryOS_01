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
                console.log("res_1: ", res);
              })

            this.webController.runJavaScript("fn_2()")
              .then((res)=>{
                console.log("res_2: ", res);
              })

            this.webController.runJavaScript("fn_3()");
          } catch (error) {
          }
        })
        .onConfirm((e)=>{
          console.log("e", JSON.stringify(e));
          AlertDialog.show({
            title: "确认",
            message: e?.message,
            primaryButton: {
              value: '取消',
              action: ()=>{
                // 执行之后返回给h5的是false
                e?.result.handleCancel();
              }
            },
            secondaryButton: {
              value: '确认',
              action: ()=>{
                // 执行之后返回给h5的是true
                e?.result.handleConfirm();
              }
            },
            cancel: ()=>{
              e?.result.handleCancel();
            }
          });

          // true 自定义弹窗可用/ false 不可用
          return true;
        })
        .onConsole((event)=>{
          // 接收调用h5页面中的方法中使用的console.log()方法产生的打印信息
          console.log("con: ", event?.message.getMessage());

          // 控制是否再打印到控制台 false可以/true不可以
          return false;
        })
        .onAlert((event)=>{
          console.log("ev:", JSON.stringify(event));

          AlertDialog.show({
            title: "alert弹窗",
            message: event?.message,
            primaryButton: {
              value: "取消",
              action: ()=>{
                event?.result.handleCancel();
              }
            },
            secondaryButton: {
              value: "确定",
              action: ()=>{
                event?.result.handleConfirm();
              }
            },
            cancel: ()=>{
              // 遮罩层的取消
              event?.result.handleCancel();
            }
          })
          // onAlert内部的自定义Alert是否有效 true 生效/ false 不生效
          return true;
        })

    }
  }
}