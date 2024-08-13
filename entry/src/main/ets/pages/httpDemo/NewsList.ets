import HttpSpace from './Interface'
import { NewsModel } from './Models';
import { promptAction } from '@kit.ArkUI';
import Logger from './Logger';
import { JSON } from '@kit.ArkTS';
import NewsItem from './NewsItem';
import { CustomRefreshLayout, DropRefreshLayout, LoadMoreLayout, NoMoreLayout } from './RefreshLayout';
import { listTouchEvent } from './PullRefresh';

@Component
export default struct NewsList{
  @State newsListModel: HttpSpace.NewsList = new HttpSpace.NewsList();
  @Watch('changeCategory') @Prop currentIndex: number;  // 若此处使用@Link装饰，变量不允许本地初始化，由父组件传递，且必须以$变量名的方式传递

  changeCategory() {
    console.log('refresh')
    // 每次切换时重置
    this.newsListModel.currentPage = 1;
    NewsModel.getNewsList(this.newsListModel.currentPage, this.newsListModel.pageSize, 'news/getNewsList')
      .then((data: HttpSpace.NewsData[])=>{
        if(data.length > 0){
          this.newsListModel.pageState = HttpSpace.PageState.Success;
        }

        // 满了
        if(data.length === this.newsListModel.pageSize){
          this.newsListModel.currentPage++;
          this.newsListModel.hasMore = true;
        }
        else{
          this.newsListModel.hasMore = false;
        }
        this.newsListModel.newsData = data;

      })
      .catch((err: string | Resource)=>{
        promptAction.showToast({
          message: err,
          duration: 2000
        })
        this.newsListModel.pageState = HttpSpace.PageState.Fail;
      })
  }

  aboutToAppear() {
    this.changeCategory();
  }
  // 列表
  @Builder
  ListLayout(){
    List(){
      // 上拉刷新Item
      ListItem(){
        DropRefreshLayout({refreshLayout: new HttpSpace.CustomRefreshLayout(this.newsListModel.isVisiblePullDown, this.newsListModel.pullDownRefreshImage, this.newsListModel.pullDownRefreshText, this.newsListModel.pullDownRefreshHeight)})
      }
      // 内容部分Item
      ForEach(this.newsListModel.newsData, (item: HttpSpace.NewsData)=>{
        ListItem(){
          NewsItem({newsData: item})
        }
      }, (item: HttpSpace.NewsData)=>JSON.stringify(item))

      // 加载更多Item
      ListItem(){
        if(this.newsListModel.hasMore){
          LoadMoreLayout({loadMoreLayout: new HttpSpace.CustomRefreshLayout(this.newsListModel.isVisiblePullUpLoad, this.newsListModel.pullDownRefreshImage, this.newsListModel.pullDownRefreshText, this.newsListModel.pullDownRefreshHeight)})
        }
        else{
          NoMoreLayout()
        }
      }
    }
    .width('95%')
    .height('100%')
    .backgroundColor('#f1f2f3')
    .divider({
      color: '#000',
      strokeWidth: 1,
      endMargin: 0
    })
    .edgeEffect(EdgeEffect.None) // 滚动到边缘的效果，默认是回弹 Spring
    .offset({x: 0, y: `${this.newsListModel.offsetY}`})
    .onScrollIndex((start: number, end: number)=>{
      this.newsListModel.startIndex = start;
      this.newsListModel.endIndex = end;
    })
  }
  // 加载中
  @Builder
  LoadingLayout(){
    CustomRefreshLayout({ refreshLayout: new HttpSpace.CustomRefreshLayout(true, $r('app.media.ic_pull_up_load'), $r('app.string.pull_up_load_text'), this.newsListModel.pullDownRefreshHeight)})
  }
  // 加载失败
  @Builder
  FailLayout(){
    Image($r('app.media.none'))
      .height(120)
      .width(120)

    Text($r('app.string.page_none_msg'))
      .opacity(0.6)
      .fontSize(16)
      .fontColor('#182431')
      .margin({top: 12})
  }

  build() {
    Column(){
      // (渲染测试)此处有可能newsData还没获取到，所以要确保拿到了数据
      // Text(this.newsListModel.newsData[0]?.content)

      if(this.newsListModel.pageState === HttpSpace.PageState.Success){
        this.ListLayout()
      }
      else if(this.newsListModel.pageSize === HttpSpace.PageState.Loading){
        this.LoadingLayout()
      }
      else{
        this.FailLayout()
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onTouch((event: TouchEvent)=>{
      if(event && this.newsListModel.pageState === HttpSpace.PageState.Success){
        listTouchEvent(this.newsListModel, event);
      }
    })
  }


}