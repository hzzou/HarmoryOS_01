import { BuilderNode } from '@kit.ArkUI';

@Component
export default struct ToDoItem{
  private content?: string;
  @State isComplete: boolean = false;

  // 自定义组件
  @Builder labelIcon(icon: Resource){
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width('28vp')
      .height('28vp')
      .margin('20vp')
  }

  // 由父组件的@Builder传递过来
  @BuilderParam child: ()=>void;

  build() {
    Row(){
      if(this.isComplete){
        this.labelIcon($r('app.media.ic_ok'));
      }
      else{
        this.labelIcon($r('app.media.ic_default'));
      }

      Text(this.content)
        .fontSize('20fp')
        .fontWeight('500')
        .opacity(this.isComplete ? 0.4 : 1)
        .decoration({type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None})

      this.child() // 组件编写的时候作占位，类似vue的slot
    }
    .borderRadius('24vp')
    .backgroundColor('#fff')
    .width('90%')
    .height('64vp')
    .onClick(()=>{
      this.isComplete = !this.isComplete;
    })
  }
}