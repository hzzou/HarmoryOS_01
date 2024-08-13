import HttpSpace from './Interface';
import { http } from '@kit.NetworkKit';


export function httpRequestGet(url: string): Promise<HttpSpace.ResponseResult>{
  let httpRequest = http.createHttp();

  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: 20000,
    header: {
      'Content-Type': 'application/json'
    },
    connectTimeout: 20000,
    extraData: {}
  });

  let serverData: HttpSpace.ResponseResult = new HttpSpace.ResponseResult();

  return responseResult.then((value: http.HttpResponse)=>{
    if(value.responseCode === 200){
      let result = `${value.result}`; // 为了给JSON.parse用，所以加了ES6的引号模式
      let resultJson: HttpSpace.ResponseResult = JSON.parse(result);
      if(resultJson.code === 'success'){
        serverData.data = resultJson.data;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    }
    else{
      serverData.msg = `Network request failed, please try later! code: ${value.responseCode}`
    }

    return serverData;
  }).catch(()=>{
    serverData.msg = 'Network request failed, please try later!';
    return serverData;
  })
}

export function httpRequestPost(url: string, newsData: HttpSpace.NewsData): Promise<HttpSpace.ResponseResult>{
  let httpRequest = http.createHttp();

  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.POST,
    readTimeout: 20000,
    header: {
      'Content-Type': 'application/json'
    },
    connectTimeout: 20000,
    extraData: newsData
  });

  let serverData: HttpSpace.ResponseResult = new HttpSpace.ResponseResult();

  return responseResult.then((value: http.HttpResponse)=>{
    if(value.responseCode === 200){
      let result = `${value.result}`; // 为了给JSON.parse用，所以加了ES6的引号模式
      let resultJson: HttpSpace.ResponseResult = JSON.parse(result);
      if(resultJson.code === 'success'){
        serverData.data = resultJson.data;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    }
    else{
      serverData.msg = `Network request failed, please try later! code: ${value.responseCode}`
    }

    return serverData;
  }).catch(()=>{
    serverData.msg = 'Network request failed, please try later!';
    return serverData;
  })
}