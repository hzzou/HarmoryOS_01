import HttpSpace from './Interface'
import Logger from './Logger';

@Component
export default struct NewsItem{
  private newsData: HttpSpace.NewsData = new HttpSpace.NewsData();
  private server: string = 'http://192.168.0.103:9588'; //本地的，二次调试时可能变动

  aboutToAppear(): void {
    //Logger.debug("data:", JSON.stringify(this.newsData));
  }

  build() {
    Column(){
      // Column内部的子元素成一列排列
      Row(){
        // Row内部的子元素成一行排列
        Image($r('app.media.news'))
          .width(40)
          .height(24)
          .margin({ top: 10, left: 10})
          .objectFit(ImageFit.Fill)

        Text(this.newsData.title)
          .fontSize(20)
          .maxLines(1)
          .margin({top: 10, left: 10})
          .textOverflow({overflow: TextOverflow.Ellipsis})
      }

      Text(this.newsData.content)
        .fontSize(16)
        .maxLines(2)
        .lineHeight(25)
        .margin({left: 10, top: 10})
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .textIndent(32)
      
      Grid(){
        ForEach(this.newsData.imagesUrl, (itemImg: HttpSpace.NewsFile)=>{
          GridItem(){
            Image(this.server+itemImg.url)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
          }
        }, (itemImg: HttpSpace.NewsFile)=>JSON.stringify(itemImg))
      }
      .columnsTemplate('1fr '.repeat(this.newsData.imagesUrl.length))
      .columnsGap(8)
      .rowsTemplate('1fr')
      .height(100)
      .margin(10)

      Text(this.newsData.source)
        .fontSize(12)
        .fontColor('#ff989898')
        .width('100%')
        .maxLines(1)
        .margin({left: 10, bottom: 10})
        .textOverflow({overflow: TextOverflow.None})
    }
    .alignItems(HorizontalAlign.Start)
  }
}