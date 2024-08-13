import { MyDataSource } from './DataSource';

@Entry
@Component
struct LazyDemo{
  private data: MyDataSource = new MyDataSource();
  private moveData: number[] = [];

  aboutToAppear(): void {
    for(let i = 0; i <= 20; i++){
      this.data.pushData(`Hello ${i}`)
    }
  }

  build() {
    Scroll(){
      // Scroll 包含List组件时，使用LazyForEach时，若List没设置高，List会加载所有子组件，若设置高度，则只加载可视区元素
      // 使用ForEach时，无论是否设置高度，都会加载所有元素
      List({space: 20}){
        LazyForEach(this.data, (item: string)=>{
          ListItem(){
            Row(){
              Text(item)
                .fontSize(50)
                .onAppear(()=>{
                  console.log("appear: ", item);
                })
            }
            .margin({left: 10, right: 10})
          }
          .onClick(()=>{
            // 追加数据
            //this.data.pushData(`Hello ${this.data.totalCount()}`);

            // 删除数据
            // this.data.deleteData(this.data.dataArray.findIndex(ele=>ele==item));

            // 交换数据
            // let index = this.data.dataArray.findIndex(ele=>ele === item);
            // this.moveData.push(index);
            // if(this.moveData.length === 2){
            //   this.data.exchangeData(this.moveData[0], this.moveData[1]);
            //   this.moveData = []; // 清空，便于下次使用
            // }

            // 改变单个数据
            let index = this.data.dataArray.findIndex(ele=>ele===item);
            this.data.changeData(index, 'Hello 00');
          })
        }, (item: string)=>JSON.stringify(item))
      }
      .height('100%')
      .cachedCount(3) // 预渲染组件数量(不会体现在布局上)
    }
  }
}