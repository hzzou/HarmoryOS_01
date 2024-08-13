
// 基础组件, 实现IDataSource接口
export class BasicDataSource implements IDataSource{

  private listeners: DataChangeListener[] = []; // 监听事件数组
  private originDataArray: string[] = [];  // 原始数组

  // 数据总数
  totalCount(): number {
    return 0;
  }

  // 获取index索引对应的数据
  getData(index: number): string {
    return this.originDataArray[index];
  }

  // 框架会调用，注册监听器，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if(!this.listeners.includes(listener)){
      console.log('添加新的 listener');
      this.listeners.push(listener);
    }
  }

  // 框架调用, 移除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    if(this.listeners.includes(listener)){
      console.log('移除 listener');
      this.listeners = this.listeners.filter(ele=>ele !== listener);
    }
  }

  // 如下方法都是实现DataChangeListener接口的事件

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void{
    this.listeners.map((ele)=>{
      ele.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void{
    this.listeners.map((ele)=>{
      ele.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处有数据变化，需要重建该子组件
  notifyDataChange(index: number): void{
    this.listeners.map((ele)=>{
      ele.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void{
    this.listeners.map((ele)=>{
      ele.onDataDelete(index);
    })
  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void{
    this.listeners.map((ele)=>{
      ele.onDataMove(from, to);
    })
  }

}

// 扩展，重载
export class MyDataSource extends BasicDataSource{

  dataArray: string[] = [];

  // 重写方法

  public totalCount(): number {
    return  this.dataArray.length;
  }

  public getData(index: number): string {
    return this.dataArray[index];
  }

  // 某个位置添加数据
  public addData(index: number, data: string): void{
    // 删除索引index处0个元素，并在此处插入data
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index); // 继承的方法
  }

  // 末尾添加数据
  public pushData(data: string): void{
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1); // 索引即是数组长度减1
  }

  // 删除数据
  public deleteData(index: number): void{
    this.dataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  // 交换数据
  public exchangeData(from: number, to: number): void {
    // ArkTS不支持解构赋值
    let temp = this.dataArray[from];
    this.dataArray[from] = this.dataArray[to];
    this.dataArray[to] = temp;

    this.notifyDataMove(from, to);
  }

  // 理工学院㲺某个位置的数据
  public changeData(index: number, data: string): void{
    // 删除index上1个数据，并在此处插入data替换
    this.dataArray.splice(index, 1, data);
    this.notifyDataChange(index);
  }
}