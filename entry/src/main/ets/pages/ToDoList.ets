import ToDoItem from '../components/ToDoItem';
import ListDataModel from '../viewModel/ListDataModel';

@Entry
@Component
struct ToDoList{
  private totalTasks: Array<string> = [];

  aboutToAppear(): void {
    this.totalTasks = ListDataModel.getData();
  }

  @Builder
  customChild(item: number){
    Text(item+'')
  }

  build() {
    Column(){
      Text('待办')
        .fontSize('28fp')
        .fontWeight(FontWeight.Bold)
        .lineHeight('33vp')
        .width('100%')
        .margin({top: '24vp', bottom: '12vp'})
        .textAlign(TextAlign.Center)

      // 第二个函数是key生成函数
      ForEach(this.totalTasks, (item: string, idx: number)=>{
        // 传递@Builder编译的UI组件给子组件的@BuilderParam
        ToDoItem({content: item, child: (): void => this.customChild(idx)})
          .margin({bottom: '20vp'})
      }, (item: string) => JSON.stringify(item))
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f3f5')
  }
}