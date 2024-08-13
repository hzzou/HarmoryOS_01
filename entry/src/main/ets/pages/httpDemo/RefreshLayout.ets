import HttpSpace from './Interface'

// 公共刷新组件
@Component
export struct CustomRefreshLayout{
  // 不能在@Entry中使用
  @ObjectLink refreshLayout: HttpSpace.CustomRefreshLayout;

  build() {
    Row(){
      Image(this.refreshLayout.imageSrc)
        .width(18)
        .height(18)

      Text(this.refreshLayout.textValue)
        .margin({ left: 8, bottom: 2 })
        .fontSize(18)
        .textAlign(TextAlign.Center)

    }
    .clip(true) // 让Row容器内超出的内容按边界裁剪
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(this.refreshLayout.heightValue)
  }
}

// 下拉刷新(顶部)
@Component
export struct DropRefreshLayout{
  @ObjectLink refreshLayout: HttpSpace.CustomRefreshLayout;

  build() {
    Column(){
      if(this.refreshLayout.isVisible){
        CustomRefreshLayout({refreshLayout: new HttpSpace.CustomRefreshLayout(this.refreshLayout.isVisible, this.refreshLayout.imageSrc, this.refreshLayout.textValue, this.refreshLayout.heightValue)})
      }
    }
  }
}

// 上拉加载更多(底部)
@Component
export struct LoadMoreLayout{
  @ObjectLink loadMoreLayout: HttpSpace.CustomRefreshLayout;

  build() {
    Column(){
      // 可见
      if(this.loadMoreLayout.isVisible){
        CustomRefreshLayout({refreshLayout: new HttpSpace.CustomRefreshLayout(this.loadMoreLayout.isVisible, this.loadMoreLayout.imageSrc, this.loadMoreLayout.textValue, this.loadMoreLayout.heightValue)})
      }
      else{
        CustomRefreshLayout({refreshLayout: new HttpSpace.CustomRefreshLayout(this.loadMoreLayout.isVisible, this.loadMoreLayout.imageSrc, this.loadMoreLayout.textValue, 0)})
      }
    }
  }
}

// 没有数据
@Component
export struct NoMoreLayout{

  build() {
    Row(){
      Text($r('app.string.prompt_message'))
        .margin({left: 8})
        .fontSize('16fp')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(70)
  }
}

