import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Five {
  @State message: string = "Hi, there is Five";

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