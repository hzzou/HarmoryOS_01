
// @Observed修饰的对象， 初始化的时候使用@ObjectLink修饰，这样会监控到其属性的变化
@Observed
class Article{
  id: string;
  title: string;
  brief: string;
  isLiked: boolean;
  likesCount: number;

  constructor(id: string, title: string, brief: string, isLiked: boolean, likesCount: number) {
    this.id = id;
    this.title = title;
    this.brief = brief;
    this.isLiked = isLiked;
    this.likesCount = likesCount;
  }
}


@Entry
@Component
struct ArticleView{
  @State articleList: Array<Article> = [
    new Article('001', '第0篇文章', '文章简介内容', false, 100),
    new Article('002', '第1篇文章', '文章简介内容', false, 100),
    new Article('003', '第2篇文章', '文章简介内容', false, 100),
    new Article('004', '第4篇文章', '文章简介内容', false, 100),
    new Article('005', '第5篇文章', '文章简介内容', false, 100),
    new Article('006', '第6篇文章', '文章简介内容', false, 100),
  ];

  build() {
    List(){
      ForEach(this.articleList, (item: Article)=>{
        ArticleCard({article: item})
          .margin({top:  20})
      }, (item: Article)=>item.id)
    }
    .padding(20)
    .scrollBar(BarState.Off)
    .backgroundColor(0xf1f3f5)
  }
}


@Component
struct ArticleCard{
  // Article使用@Observed修饰
  @ObjectLink article: Article;

  handleLiked(){
    this.article.isLiked = !this.article.isLiked;
    this.article.likesCount = this.article.isLiked ? this.article.likesCount + 1 : this.article.likesCount - 1;
  }

  build(){
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

        Row(){
          Image(this.article.isLiked ? $r('app.media.ic_add') : $r('app.media.ic_add_pic'))
            .width(24)
            .height(24)
            .margin({right: 8})

          Text(this.article.likesCount.toString())
            .fontSize(16)
        }
        .onClick(()=>{
          this.handleLiked();
        })
        .justifyContent(FlexAlign.Center)
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