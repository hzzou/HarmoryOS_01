import { emitter } from '@kit.BasicServicesKit';
import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct ListSort{
  // @State定义的变量应该要关联UI组件，否则性能浪费
  @State arr: Array<string> = [];
  btnMsg = "I am button"; // 仅读取,没有写，直接一般变量即可

  aboutToAppear(): void {
    for(let i = 0; i < 100; i++){
      this.arr.push(i.toString());
    }
  }


  build() {
    Row(){
      List(){
        ListItem(){
          Button("按钮")
            .width('40%')
            .onClick(()=>{
              let event: emitter.InnerEvent = {
                eventId: 1,
                priority: emitter.EventPriority.HIGH
              };

              let eventData: emitter.EventData = {
                data: {
                  name: "hzlzh",
                  age: 76
                }
              };
              // 通知，触发, 发出事件
              emitter.emit(event, eventData);
            })
        }
        .width('100%')
        .margin(10)

        ForEach(this.arr, (item: string, idx: number)=>{
          ListItemCom({item, idx})
        }, (item: string)=>item)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffdcdcdc')
  }
}

@Component
struct ListItemCom{
  @State item: string = '';
  @State idx: number = 0;

  aboutToAppear(): void {
    let event: emitter.InnerEvent = {
      eventId: 1
    }
    // 监听
    emitter.on(event, (data)=>{
      console.log("data:");
      console.log(JSON.stringify(data));
      console.log("当前idx:", this.idx);
    })
  }
  build() {
    ListItem(){
      Text(this.item)
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .height(100)
        .width('100%')
    }
    .margin(10)
    .borderRadius(10)
    .backgroundColor('#fff')
  }
}