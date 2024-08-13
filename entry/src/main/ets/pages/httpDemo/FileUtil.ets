import { fileIo, picker } from '@kit.CoreFileKit'
import Logger from './Logger';
import { promptAction } from '@kit.ArkUI';
import HttpSpace from './Interface';
import { request } from '@kit.BasicServicesKit';
import { http } from '@kit.NetworkKit';
import { JSON } from '@kit.ArkTS';


export async function fileSelect(): Promise<string>{
  // 创建photo文档的类型等基础配置
  let photoSelectOptions = new picker.PhotoSelectOptions();
  photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
  photoSelectOptions.maxSelectNumber = 1;
  // 创建文件选择
  let photoPicker = new picker.PhotoViewPicker();
  try{
    let photoSelectResult = await photoPicker.select(photoSelectOptions);
    if(photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0){
      let imgUri = photoSelectResult.photoUris[0];
      if(!imgUri.includes('media/Photo')){
        promptAction.showToast({
          message: '请选择图片上传',
          duration: 2000
        })
        return '';
      }
      return photoSelectResult.photoUris[0];
    }
    else{
      return '';
    }
  } catch (err) {
    Logger.error("Selected Image failed", JSON.stringify(err));
    return '';
  }
}

export function fileUpload(context: Context, fileUri: string): Promise<HttpSpace.ResponseResult>{
  let cacheDir = context.cacheDir; // 缓存目录
  let imgName: string = fileUri.split('/').pop()+''; // 取数组最后一个
  let dstPath = cacheDir+'/'+imgName;
  let url: string = 'http://192.168.0.103:9588/files/upload';

  let uploadOptions: request.UploadConfig = {
    url: url,
    header: {
      'Content-Type': 'multipart/form-data'
    },
    method: http.RequestMethod.POST,
    files: [
      {
        filename: imgName,
        name: 'file',
        uri: 'internal://cache/'+imgName,
        type: 'jpg'
      }
    ],
    data: []
  }

  let serverData = new HttpSpace.ResponseResult();
  return new Promise((resolve: Function, reject: Function)=>{
    try{
      // 本地目录下的文件复制到缓存目录下
      let srcFile = fileIo.openSync(fileUri); // 打开本地目录下的
      let dstFile = fileIo.openSync(dstPath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE)
      fileIo.copyFileSync(srcFile.fd, dstFile.fd);  // 复制

      fileIo.closeSync(srcFile); // 关闭
      fileIo.closeSync(dstFile);

      // 上传文件, 在基础服务数据文件处理上传下载，而非network
      request.uploadFile(context, uploadOptions).then((data: request.UploadTask)=>{
        data.on('complete', (result: Array<request.TaskState>)=>{
          Logger.info('uploadFile success', JSON.stringify(result));
          if(result && result.length >= 1){
            serverData.code = 'success';
            serverData.msg = result[0].message;
            serverData.data = '/images/'+result[0].path.split('/').pop();
            resolve(serverData);
          }
        })

        data.on('fail', (result: Array<request.TaskState>)=>{
          Logger.info('uploadFile failed', JSON.stringify(result));
          if(result && result.length >= 1){
            serverData.msg = 'Upload file failed, please  try again!';
            reject(serverData);
          }
        })
      })
    } catch (err) {
      Logger.error("upload failed", JSON.stringify(err));
      serverData.msg = "upload failed";
      reject(serverData)
    }
  })
}