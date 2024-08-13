import { PullToRefresh} from "@ohos/pulltorefresh";
import HttpSpace from './Interface';
import { NewsModel } from './Models';
import NewsItem from './NewsItem';
import { promptAction } from '@kit.ArkUI';

@Component
export struct ListComponent{
  //
  private scroller: Scroller = new Scroller();

  @State newsData: HttpSpace.NewsData[] = [];

  // @Link双向 则在父级使用它时必须以$变量名的方式传递
  @Watch('changeCategory') @Link currentIndex: number;

  changeCategory() {
    console.log('refresh')
    NewsModel.getNewsList(1, 4, 'news/getNewsList')
      .then((data: HttpSpace.NewsData[])=>{
        console.log(JSON.stringify(data))
        this.newsData = data;
      })
      .catch((err: string | Resource)=>{
        promptAction.showToast({
          message: err,
          duration: 2000
        })
      })
  }

  aboutToAppear(): void {
    this.changeCategory()
  }

  @Builder
  ListView(){
    List({space: 3, scroller: this.scroller}){
      ForEach(this.newsData, (item: HttpSpace.NewsData)=>{
        ListItem(){
          NewsItem({newsData: item})
        }
      }, (item: HttpSpace.NewsData)=>JSON.stringify(item))
    }
    .height('100%')
    .edgeEffect(EdgeEffect.None) // 必须要设为None才能触发上拉下拉的刷新方法
  }

  build() {
    Column(){
      PullToRefresh({
        data: $newsData, // this.newsData
        scroller: this.scroller,
        customList: ()=>{
          this.ListView()
        },
        onRefresh: ()=>{
          console.log('123')
          // 下拉刷新
          return new Promise((resolve)=>{
            setTimeout(()=>{
              // 更新数据
              NewsModel.getNewsList(2, 4, 'news/getNewsList')
                .then((data: HttpSpace.NewsData[])=>{
                  console.log(JSON.stringify(data))
                  this.newsData = data;
                })
                .catch((err: string | Resource)=>{
                  promptAction.showToast({
                    message: err,
                    duration: 2000
                  })
                })
              resolve('已经刷新了哦')
            }, 2000)
          })
        },
        onLoadMore: ()=>{
          console.log('456')
          return new Promise((resolve)=>{
            setTimeout(()=>{
              NewsModel.getNewsList(2, 4, 'news/getNewsList')
                .then((data: HttpSpace.NewsData[])=>{
                  console.log(JSON.stringify(data))
                  this.newsData = this.newsData.concat(data);
                })
                .catch((err: string | Resource)=>{
                  promptAction.showToast({
                    message: err,
                    duration: 2000
                  })
                })
              resolve('加载更多');
            }, 1000)
          })
        }
      })
    }
    .height('100%')
  }
}