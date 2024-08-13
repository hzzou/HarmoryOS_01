import HttpSpace from './Interface'
import { ListComponent } from './ListComponent';
import Logger from './Logger';
import { NewsModel } from './Models'
import NewsList from './NewsList';
import { router } from '@kit.ArkUI';
import { JSON } from '@kit.ArkTS';
import { GlobalContext } from '../../common/utils/GlobalContext';


@Entry
@Component
struct HttpTab{
  @State tabBarList: HttpSpace.NewsType[] = NewsModel.getDefaultTypeList();
  @State currentIndex: number = 0; // 第几个tab
  @State currentPage: number = 1; // 下拉刷新翻页,默认在第一页

  // 组件的生命周期，仅在@Component组件创建时执行一次
  async aboutToAppear() {
    // 可以从后端请求list
    let data = await NewsModel.getNewsTypeList();
    if(Array.isArray(data) && data.length > 0){
      this.tabBarList = data;
    }
  }

  // 页面的生命周期，在@Entry的页面中，每次show的时候触发
  onPageShow(): void {
    if(GlobalContext.getContext().getObject('isBackRouter') === true){
      GlobalContext.getContext().setObject('isBackRouter', false);
      console.log('show')
      let temp = this.currentIndex; // 先把currentIndex存temp上
      this.currentIndex = -1; // 改变一下currentIndex
      this.currentIndex = temp; // 又把它还原回去
      // 此处改变currentIndex的目的是使子组件的@Watch监控生效
    }

  }

  @Builder
  TabBarBuild(name: string, index: number){
    Column(){
      Text(name)
        .height('100%')
        .padding({left: 20, right: 20})
        .fontSize(this.currentIndex === index ? 24 : 18)
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentIndex === index ?  '#ff197eec' : '#182431')
    }
  }

  build() {
    // stack布局是堆叠显示，后一个组件在前一个组件的顶部
    Stack(){
      Tabs(){
        //TabContent不支持设置宽高，直接撑满父组件Tabs
        ForEach(this.tabBarList, (item: HttpSpace.NewsType) => {
          TabContent(){
            Column(){
              //NewsList({currentIndex: this.currentIndex})
              // 子级变量@Link修饰必须以$变量名的方式传递
              ListComponent({currentIndex: $currentIndex})
            }
          }
          .tabBar(this.TabBarBuild(item.name, item.id))
        }, (item: HttpSpace.NewsType) => JSON.stringify(item))
      }
      .barWidth('100%') // 此处是整体的tabBar区域占的宽度，横着的时候，数着的时候则是barHeight
      .barHeight(50)
      .barMode(BarMode.Scrollable) // 滚动模式
      .width('100%')
      .height('100%')
      .onChange((index: number)=>{
        this.currentIndex = index;
        this.currentPage = 1; // 每次切换tab的时候就会吧页面置为当前tab的第一页
      })

      Image($r('app.media.ic_add'))
        .width(48)
        .height(48)
        .margin({bottom: 24, right: 24})
        .onClick(()=>{
          router.pushUrl({url: 'pages/httpDemo/EditPage'})
        })
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.BottomEnd)
    .backgroundColor('#f1f3f5')
  }
}

@Preview
@Component
struct HttpDemo{

  build() {
    HttpTab()
  }
}

