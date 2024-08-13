import { promptAction, router } from '@kit.ArkUI';
import File from '@system.file';
import { GlobalContext } from '../../common/utils/GlobalContext';
import { fileSelect, fileUpload } from './FileUtil';
import HttpSpace from './Interface';
import { NewsModel } from './Models';

@Entry
@Component
struct EditPage{
  title: string  = '';
  content: string = '';

  @State imageUri: string = '';
  @State isUploading: boolean = false;

  selectImage(){
    fileSelect().then((uri: string)=>{
      console.log('1:',uri);
      this.imageUri = uri;
    })
  }

  uploadNewsData(){
    if(this.title === ''){
      promptAction.showToast({
        message: '请输入标题',
        duration: 2000
      })
      return;
    }

    if(this.content === ''){
      promptAction.showToast({
        message: '请输入内容',
        duration: 2000
      })
      return;
    }

    if(this.imageUri === ''){
      promptAction.showToast({
        message: '请选择图片',
        duration: 2000
      })
      return;
    }

    this.isUploading = true;
    // getContext(this)获取到Context上下文
    let serverData = fileUpload(getContext(this), this.imageUri);
    serverData.then((data: HttpSpace.ResponseResult)=>{
      let imageUrl = data.data;
      let newsFile = new HttpSpace.NewsFile();

      newsFile.id = 0;
      newsFile.url = imageUrl;
      newsFile.type = 0;
      newsFile.newsId = 0;

      let newsData: HttpSpace.NewsData = new HttpSpace.NewsData();
      newsData.title = this.title;
      newsData.imagesUrl = [newsFile];
      newsData.content = this.content;
      NewsModel.addNews(newsData).then(()=>{
        this.isUploading = false;
        GlobalContext.getContext().setObject('isBackRouter', true);
        router.back();
      }).catch(()=>{
        this.isUploading = false;
        promptAction.showToast({
          message: 'Upload file failed, please try again',
          duration: 2000
        })
      })
    }).catch(()=>{
      this.isUploading = false;
      promptAction.showToast({
        message: 'Upload file failed, please try again',
        duration: 2000
      })
    })
  }

  @Builder
  UploadingLayout(){
    Column(){
      Image($r('app.media.ic_pull_up_load'))
        .width(48)
        .height(48)
      Text('Uploading... Please wait.')
        .margin({top: 12})
        .fontSize('16fp')
        .fontColor('#182431')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Stack(){
      Navigation(){
        Column(){
          Column(){
            TextInput({placeholder: '填写标题'})
              .width('100%')
              .height(44)
              .fontSize('16fp')
              .placeholderFont({size: '16fp'})
              .margin({top: 12})
              .fontColor('#182431')
              .backgroundColor(Color.White)
              .onChange((value: string)=>{
                this.title = value;
              })

            Divider()
              .opacity(0.2)
              .color('#182431')
              .width('90%')

            TextArea({placeholder: '写点什么'})
              .placeholderFont({size: '16fp'})
              .fontColor('#182431')
              .height(140)
              .fontSize(16)
              .margin({top: 8})
              .backgroundColor(Color.White)
              .onChange((value: string)=>{
                this.content = value;
              })

            Scroll(){
              Row(){
                Image(this.imageUri ? this.imageUri : $r('app.media.ic_add_pic'))
                  .width(100)
                  .height(100)
                  .objectFit(ImageFit.Cover)
                  .onClick(()=>{
                    this.selectImage()
                  })
              }
              .padding(12)
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .align(Alignment.Start)
          }
          .borderRadius(20)
          .backgroundColor(Color.White)
          .width('100%')

          Button('发布')
            .fontSize('16fp')
            .height(40)
            .width(200)
            .margin({bottom: 12})
            .onClick(()=>{
              this.uploadNewsData();
            })
        }
        .padding({left: 12, right: 12, bottom: 12})
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .height('100%')
      .title('新闻发布')
      .titleMode(NavigationTitleMode.Mini)
      .backgroundColor('#f1f3f5')

      if(this.isUploading){
        this.UploadingLayout()
      }
    }
  }
}