import { httpRequestGet, httpRequestPost } from './HttpUtil';
import HttpSpace from './Interface';
import Logger from './Logger';
import { JSON } from '@kit.ArkTS';

class NewsModel{
  url: string = "http://192.168.0.103:9588";

  //获取本地默认的
  getDefaultTypeList(): HttpSpace.NewsType[]{
    return [
      { id: 0, name: '全部' },
      { id: 1, name: '国内' },
      { id: 2, name: '国际' },
      { id: 3, name: '娱乐' },
      // { id: 4, name: '军事' },
      // { id: 5, name: '体育' },
      // { id: 6, name: '科技' },
      // { id: 7, name: '财经' }
    ]
  }

  //获取后台动态的
  getNewsTypeList(): Promise<HttpSpace.NewsType[]>{
    return new Promise((resolve: Function, reject: Function)=>{
      httpRequestGet(`${this.url+'/news/getNewsType'}`)
        .then((data: HttpSpace.ResponseResult)=>{
          if(data.code === 'success'){
            resolve(data.data)
          }
          else{
            Logger.error('failed: ', JSON.stringify(data));
            reject('Network loading failure');
          }
        })
        .catch((err: Error)=>{
          Logger.error('failed: ', JSON.stringify(err));
          reject('Network loading failed, please try later!');
        })
    })
  }

  //获取新闻列表
  getNewsList(currentPage: number, pageSize: number, path: string): Promise<HttpSpace.NewsData[]>{
    return new Promise((resolve: Function, reject: Function)=>{
      httpRequestGet(this.url+`/${path}?currentPage=${currentPage}&pageSize=${pageSize}`)
        .then((data: HttpSpace.ResponseResult)=>{
          if(data.code === 'success'){
            resolve(data.data);
          }
          else{
            Logger.error('getNewsList failed', JSON.stringify(data));
            reject($r('app.string.page_none_msg'));
          }
        })
        .catch((err: Error)=>{
          Logger.error('getNewsList failed', JSON.stringify(err));
          reject($r('app.string.http_error_message'))
        })
    })
  }

  //添加新闻
  addNews(newsData: HttpSpace.NewsData): Promise<HttpSpace.NewsData[]>{
    return new Promise((resolve: Function, reject: Function)=>{
      httpRequestPost(this.url+'/news/addNews', newsData).then((result: HttpSpace.ResponseResult)=>{
        if(result && result.code === 'success'){
          resolve(result.data);
        }
        else{
          reject('Upload file failed, please try again!')
        }
      }).catch((err: Error)=>{
        Logger.error('upload News failed', JSON.stringify(err));
        reject('Upload file failed, please try again!');
      })
    })
  }
}
const newsModel = new NewsModel();

//使用export会自动发现, export default不会
export {newsModel as NewsModel};