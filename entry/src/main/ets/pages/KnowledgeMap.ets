import Log from "@ohos.hilog";

// 使用逗号和分号都可以，但是最好统一使用一种符号
interface interList{
  order: string;
  title: string;
}

// @Entry中不能使用@Prop
@Entry
@Component
struct KnowledgeMap{
  private title: string = '通过循序渐进的学习路径，无经验和有经验的开发者都可以轻松掌握ArkTS语言声明式开发范式，体验更简洁、更友好的HarmonyOS应用开发旅程';

  private list: Array<interList> = [
    {order: '01', title: '准备与学习'},
    {order: '02', title: '构建应用'},
    {order: '03', title: '应用测试'},
    {order: '04', title: '上架'},
    {order: '05', title: '运营增长'},
    {order: '06', title: '商业变现'},
    {order: '07', title: '商业变现'},
    {order: '08', title: '商业变现'},
    {order: '09', title: '商业变现'},
    {order: '10', title: '商业变现'},
  ];

  @State isHover: boolean = false;

  // ListItem内子组件
  @Builder
  NavBarItem(order: string, title: string){
    Row(){
      Text(order)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .margin({right: 15})
      Text(title)
        .fontSize(16)
      Blank()
      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }


  build() {
    Column(){
      Column(){
        Text('知识地图')
          .fontSize(24)
          .width('90%')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Start)
          .margin({top: 20})
        Image($r('app.media.knowledge_map_banner'))
          .width('90%')
          .margin(10)
          .borderRadius(5)
        Text(this.title)
          .width('90%')
          .lineHeight(20)
          .fontSize(14)
          .fontColor('#666')
      }
      //  嵌套模式
      Navigation(){
        Scroll(){
          Column(){
            Text('主题')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({left: 30, top: 16})
            List({space: 15}){
              ForEach(this.list, (item: interList)=>{
                ListItem(){
                  // NavRouter在Navigation
                  NavRouter(){
                    this.NavBarItem(item.order, item.title)
                    // 详情页 NavDestination在NavRouter
                    NavDestination(){
                      Column(){
                        Text(item.title)
                      }
                      .border({width: 1})
                      .width('80%')
                      .height('420vp')
                    }
                  }
                }
                .height(40)
                .borderRadius(15)
                .padding({left: 5, right: 5})
                .backgroundColor('#dedede')
                .hoverEffect(HoverEffect.Highlight)
                .width('100%')
              }, (item: interList)=>item.order)
            }
            .height('440vp') // 此处设置List高度是让Scroll组件能出滚动条
            .padding(16)
            .width('100%')
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
      }
      .mode(NavigationMode.Auto)
    }
  }
}

@Preview
@Component
struct KnowDemo{

  build() {
    KnowledgeMap()
  }
}