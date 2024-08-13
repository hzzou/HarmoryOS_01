

@Entry
@Component
struct RefreshDemo{
  @State isRefresh: boolean = false;
  @State arr: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8','9', '10'];

  @Builder
  CustomLoading(){
    Row(){
      LoadingProgress()
        .width(32)

      Text('正在刷新...')
        .fontSize('16fp')
        .margin({left: 20})
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }

  build() {
    Column(){
      //refreshing支持$$双向绑定
      Refresh({refreshing: $$this.isRefresh, builder: this.CustomLoading()}){
        List(){
          ForEach(this.arr, (item: string)=>{
            ListItem(){
              Text(item)
                .width('100%')
                .height(100)
                .fontSize('16fp')
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor('#fff')
            }
          }, (item: string)=>item)
        }
        .onScrollIndex((start: number)=>{
          console.log(start.toString());
        })
        .width('100%')
        .height('100%')
        .divider({strokeWidth: 1, color: '#ff0', startMargin: 10, endMargin:  10})
        .scrollBar(BarState.Off)
      }
      .backgroundColor('#89cff0')
      .refreshOffset(64)
      .pullToRefresh(true)
      .onStateChange((RefreshStatus: RefreshStatus)=>{
        // 刷新状态变更时触发
        console.info('refresh state: ', RefreshStatus);
      })
      .onOffsetChange((value: number)=>{
        // 下拉距离发生变化时触发
        console.info('refresh offset: ', value);
      })
      .onRefreshing(()=>{
        // 进入刷新状态时触发
        console.info('refresh')
        setTimeout(()=>{
          this.isRefresh = false;
        }, 2000)
      })
    }
    .width('100%')
    .height('100%')
  }
}