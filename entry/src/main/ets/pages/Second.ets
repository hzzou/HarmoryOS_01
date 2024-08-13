import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Second {
  @State message: string = "Hi, there is Second";

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button() {
          Text('Back')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0d9ffb')
        .width('40%')
        .height('5%')
        .onClick(() => {
          try {
            router.back();
          } catch (err) {
            const error = err as BusinessError;
            console.error(`Failed to return; code is ${error.code},message is ${error.message}`)
          }
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}

// 单独预览定义的Second组件
// 从侧边栏的previewer直接点开或者View-Tool Window-Previewer
// @Preview不是整体运行项目而是单独预览某个编写的组件，有点测试的感觉
@Preview
@Component
struct PrevSec{
  build() {
    Second()
  }
}