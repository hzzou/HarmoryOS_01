
@Entry
@Component
struct NavigationExam{
  @State ItemList: ToolbarItem = {
    value: "Nav",
    icon: $r('app.media.ic_medals'),
    action: ()=>{}
  };

  private arr: number[] = [1, 2, 3];


  build() {

    Column(){
      Navigation(){
        TextInput({placeholder: 'search...'})
          .width('90%')
          .height(40)
          .backgroundColor('#fff')

        List({space: 12}){
          ForEach(this.arr, (item: number)=>{
            ListItem(){
              NavRouter(){
                Text('NavRouter_'+item)
                  .width('100%')
                  .height(72)
                  .backgroundColor('#fff')
                  .borderRadius(24)
                  .fontSize(16)
                  .fontWeight(500)
                  .textAlign(TextAlign.Center)

                NavDestination(){
                  Text('Destination_'+item)
                }
                .title('title_'+item)
              }
            }
          }, (item:number)=>JSON.stringify(item))
        }
        .width('90%')
        .margin({top: 12})
      }
      .title('主标题')
      .mode(NavigationMode.Split)
      .menus([
        {value: '', icon: "images/ic_video.svg", action: ()=>{}},
        {value: '', icon: "images/ic_arrow.svg", action: ()=>{}},
        {value: '', icon: "images/ic_prepare.svg", action: ()=>{}},
        {value: '', icon: "images/ic_ok.png", action: ()=>{}},
        {value: '', icon: "images/ic_guide.svg", action: ()=>{}},
      ])
      .toolbarConfiguration([this.ItemList, this.ItemList, this.ItemList])
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f1f3f5')
  }
}

@Preview
@Component
struct NavDemo{

  build() {
    NavigationExam()
  }
}