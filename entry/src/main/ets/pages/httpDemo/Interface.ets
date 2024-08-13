
namespace HttpSpace{
  export interface NewsType{
    id: number;
    name: string;
  }

  export class ResponseResult{
    code: string;
    msg: string | Resource;
    data: string | Object | ArrayBuffer;

    constructor() {
      this.code = '';
      this.msg = '';
      this.data = '';
    }
  }

  export class NewsFile{
    id: number = 0;
    url: Object | ArrayBuffer | string = '';
    type: number = 0;
    newsId: number = 0;
  }

  export class NewsData{
    title: string = '';
    content: string = '';
    imagesUrl: Array<NewsFile> = [new NewsFile()];
    source: string = '';
  }
  // 使用const关键字的是常量枚举，没有使用的则是普通枚举
  export const enum PageState{
    Loading = 0,
    Success = 1,
    Fail = 2
  }

  export class NewsList{
    newsData: Array<NewsData> = [];
    currentPage: number = 1;
    pageSize: number = 4;
    pullDownRefreshText: Resource = $r('app.string.pull_down_refresh_text');
    pullDownRefreshImage: Resource = $r('app.media.ic_pull_down_refresh');
    pullDownRefreshHeight: number = 70;
    isVisiblePullDown: boolean = false;
    pullUpLoadText: Resource = $r('app.string.pull_up_load_text');
    pullUpLoadImage: Resource = $r('app.media.ic_pull_up_load');
    pullUpLoadHeight: number = 70;
    isVisiblePullUpLoad: boolean = false;
    offsetY: number = 0;
    pageState: number = PageState.Loading;
    hasMore: boolean = false;
    startIndex: number = 0;
    endIndex: number = 0;
    downY: number = 0;
    lastMoveY: number = 0;
    isRefreshing: boolean = false;
    isCanRefresh: boolean = false;
    isPullRefreshOperation: boolean = false;
    isLoading: boolean = false;
    isCanLoadMore: boolean = false;
  }

  export const enum RefreshState{
    DropDown = 0,
    Release = 1,
    Refreshing = 2,
    Success = 3,
    Fail = 4
  }

  // 被@Observed装饰的类，可以观察到其属性的变化, 嵌套对象双向据同步
  // 子组件中@ObjectLink装饰的状态变量用于接受@Observed装饰的类的实例
  @Observed
  export class CustomRefreshLayout{
    isVisible: boolean;
    imageSrc: Resource;
    textValue: Resource;
    heightValue: number;

    constructor(isVisible: boolean, imageSrc: Resource, textValue: Resource, heightValue: number) {
      this.isVisible = isVisible;
      this.imageSrc = imageSrc;
      this.textValue = textValue;
      this.heightValue = heightValue;
    }
  }
}

export default HttpSpace;