import HttpSpace from './Interface';
import { NewsModel } from './Models';
import { promptAction } from '@kit.ArkUI';

export function listTouchEvent(model: HttpSpace.NewsList, event: TouchEvent){
  switch (event.type){
    case TouchType.Down:
      model.downY = event.touches[0].y;
      model.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      if(model.isRefreshing || model.isLoading){
        return;
      }

      let isDownPull = event.touches[0].y - model.lastMoveY ; //arkTS中不能使用!!进行类型强制转换
      if((isDownPull > 0 || model.isPullRefreshOperation) && !model.isCanLoadMore){
        touchMovePullRefresh(model, event);
      }
      else{
        console.log('345')
        touchMoveLoadMore(model, event);
      }
      model.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      if(model.isRefreshing || model.isLoading){
        return;
      }

      if(model.isPullRefreshOperation){
        touchUpPullRefresh(model);
      }
      else{
        console.log('567');
        touchUpLoadMore(model);
      }
      break;
    default:
      break;
  }
}

export function touchMovePullRefresh(model: HttpSpace.NewsList, event: TouchEvent){
  if(model.startIndex === 0){
    model.isPullRefreshOperation = true;
    let height = vp2px(model.pullDownRefreshHeight); //vp转px
    model.offsetY = event.touches[0].y - model.downY;

    if(model.offsetY >= height){
      pullRefreshState(model, HttpSpace.RefreshState.Release);
      model.offsetY = height + model.offsetY*0.1;
    }
    else{
      pullRefreshState(model, HttpSpace.RefreshState.DropDown);
    }

    if(model.offsetY < 0){
      model.offsetY = 0;
      model.isPullRefreshOperation = false;
    }
  }
}

export function touchUpPullRefresh(model: HttpSpace.NewsList){
  if(model.isCanRefresh){
    model.offsetY = vp2px(model.pullDownRefreshHeight);
    pullRefreshState(model, HttpSpace.RefreshState.Refreshing);
    model.currentPage = 1;
    setTimeout(()=>{
      NewsModel.getNewsList(model.currentPage, model.pageSize, 'news/getNewsList')
        .then((data: HttpSpace.NewsData[])=>{
          console.log('up:',JSON.stringify(data))
          if(data.length === model.pageSize){
            model.hasMore = true;
            model.currentPage++;
          }
          else{
            model.hasMore = false;
          }

          model.newsData = data;
          closeRefresh(model, true);
        })
        .catch((err: string | Resource)=>{
          promptAction.showToast({message: err});
          closeRefresh(model, false);
        })
    }, 1000)
  }
  else{
    closeRefresh(model, false);
  }
}

export function closeRefresh(model: HttpSpace.NewsList, isRefreshSuccess: boolean){
  setTimeout(()=>{
    let delay = 50;
    if(model.isCanRefresh){
      pullRefreshState(model, isRefreshSuccess ? HttpSpace.RefreshState.Success : HttpSpace.RefreshState.Fail);
      delay = 500;
    }
    animateTo({
      duration: 150,
      delay: delay,
      onFinish: ()=>{
        pullRefreshState(model, HttpSpace.RefreshState.DropDown);
        model.isVisiblePullDown = false;
        model.isPullRefreshOperation = false;
      }
    }, ()=>{
      model.offsetY = 0;
    })
  }, model.isCanRefresh ? 300 : 0)
}

export function pullRefreshState(model: HttpSpace.NewsList, state: number){
  switch (state){
    case HttpSpace.RefreshState.DropDown:
      model.pullDownRefreshText = $r('app.string.pull_down_refresh_text');
      model.pullDownRefreshImage = $r('app.media.ic_pull_down_refresh');
      model.isCanRefresh = false;
      model.isRefreshing = false;
      model.isVisiblePullDown = true;
      break;
    case HttpSpace.RefreshState.Release:
      model.pullDownRefreshText = $r('app.string.release_refresh_text');
      model.pullDownRefreshImage = $r('app.media.ic_pull_up_refresh');
      model.isCanRefresh = true;
      model.isRefreshing = false;
      break;
    case HttpSpace.RefreshState.Refreshing:
      model.offsetY = vp2px(model.pullDownRefreshHeight);
      model.pullDownRefreshText = $r('app.string.refreshing_text');
      model.pullDownRefreshImage = $r('app.media.ic_pull_up_load');
      model.isCanRefresh = true;
      model.isRefreshing = true;
      break;
    case HttpSpace.RefreshState.Success:
      model.pullDownRefreshText = $r('app.string.refresh_success_text');
      model.pullDownRefreshImage = $r('app.media.ic_succeed_refresh');
      model.isCanRefresh = true;
      model.isRefreshing = true;
      break;
    default:
      break;
  }
}

export function touchMoveLoadMore(model: HttpSpace.NewsList, event: TouchEvent){
  if(model.endIndex === model.newsData.length - 1 || model.endIndex === model.newsData.length){
    model.offsetY = event.touches[0].y - model.downY;
    if(Math.abs(model.offsetY) > vp2px(model.pullUpLoadHeight / 2)){
      model.isCanLoadMore = true;
      model.isVisiblePullUpLoad = true;
      model.offsetY = -vp2px(model.pullUpLoadHeight) + model.offsetY*0.1;
    }
  }
}

export function touchUpLoadMore(model: HttpSpace.NewsList){
  animateTo({
    duration: 2000
  }, ()=>{
    model.offsetY = 0;
  })

  if(model.isCanLoadMore && model.hasMore){
    model.isLoading = true;
    setTimeout(()=>{
      closeLoadMore(model);
      NewsModel.getNewsList(model.currentPage, model.pageSize, 'news/getNewsList')
        .then((data: HttpSpace.NewsData[])=>{
          console.log("down:",JSON.stringify(data))
          if(data.length === model.pageSize){
            model.currentPage++;
            model.hasMore = true;
          }
          else{
            model.hasMore = false;
          }
          model.newsData = model.newsData.concat(data);
        })
        .catch((err: string | Resource)=>{
          promptAction.showToast({message: err});
        })
    }, 1000)
  }
  else{
    closeLoadMore(model);
  }
}

export function closeLoadMore(model: HttpSpace.NewsList){
  model.isCanLoadMore = false;
  model.isLoading = false;
  model.isVisiblePullUpLoad = false;
}