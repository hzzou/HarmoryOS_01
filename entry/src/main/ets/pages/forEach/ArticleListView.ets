
// 数据源数组项发生变化

class Article{

  id: string;
  title: string;
  brief: string;

  constructor(id: string, title: string, brief: string) {
    this.id = id;
    this.title = title;
    this.brief = brief;
  }
}

@Entry
@Component
struct ArticleListView{
  @State isListReachEnd: boolean = false;
  @State articleList: Array<Article> = [
    new Article('001', '第1篇文章', '文章内容简介'),
    new Article('002', '第2篇文章', '文章内容简介'),
    new Article('003', '第3篇文章', '文章内容简介'),
    new Article('004', '第4篇文章', '文章内容简介'),
    new Article('005', '第5篇文章', '文章内容简介'),
    new Article('006', '第6篇文章', '文章内容简介'),
  ];

  loadMoreArticles(){
    this.articleList.push(new Article('007', '第7篇文章', '文章内容简介'));
  }


  build() {
    // 一列多行
    Column({space: 5}){
      List(){
        ForEach(this.articleList, (item: Article)=>{
          ListItem(){
            ArticleCard({article: item})
              .margin({top: 20})
          }
        }, (item: Article)=>item.id)
      }
      .padding(20)
      .scrollBar(BarState.Off)
      .onReachEnd(()=>{
        this.isListReachEnd = true;
      })
      .parallelGesture(
        // 拖动手势事件
        PanGesture({direction: PanDirection.Up, distance: 80})
          .onActionStart(()=>{
            if(this.isListReachEnd){
              this.loadMoreArticles();
              this.isListReachEnd = false;
            }
          })
      ) // 绑定可与子组件手势同时触发的手势
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f3f5')
  }
}


@Component
struct ArticleCard{
  @Prop article: Article;

  build() {
    Row(){
      Image($r('app.media.app_icon'))
        .width(80)
        .height(80)
        .margin({right: 20})

      Column(){
        Text(this.article.title)
        .fontSize(20)
        .margin({bottom: 8})

        Text(this.article.brief)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({bottom: 8})
      }
      .alignItems(HorizontalAlign.Start)
      .width('80%')
      .height('100%')
    }
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#ffececec')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}