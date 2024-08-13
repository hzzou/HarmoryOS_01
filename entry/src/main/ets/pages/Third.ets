// 要添加entry， preview才会生效
@Entry
@Component
struct Third{
  // 其值改变引起试图更新, private类型的则不会
  @State message: string = '快速入门';
  @State bannerData: Resource[] = [
    $r('app.media.banner_pic0'),
    $r('app.media.banner_pic1'),
    $r('app.media.banner_pic2'),
    $r('app.media.banner_pic3'),
    $r('app.media.banner_pic4'),
    $r('app.media.banner_pic5')
  ];

  private title: string = "HarmonyOS第一课";
  private brief: string = "基于真实的开发场景，提供向导式学习，多维度融合课程等内容，给开发者提供全新的学习体验。";


  build() {
    Column(){
      Text(this.message)
        .fontSize(24)
        .fontWeight(700)
        .width('100%')
        .padding({left: 16, top: '16vp'}) // 和16vp一样
        .lineHeight(30)

      Swiper(){
        ForEach(this.bannerData, (item: Resource)=>{
          Image(item)
            .objectFit(ImageFit.Contain)
            .width('100%')
            .borderRadius(16)
            .padding({top: 10, left: 16, right: 16})
        }, (item: Resource)=>JSON.stringify(item))
      }
      .autoPlay(true)
      .loop(true)
      .indicator(
        new DotIndicator()
          .color('#1a000000')
          .selectedColor('#0a59f7')
      )

      Column(){
        Text('赋能套件')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .margin({top: 10, bottom: 10})
          .width('100%')
          .textAlign(TextAlign.Start)
        Grid(){
          GridItem(){
            Column(){
              Image($r('app.media.enablement_pic1'))
                .width('100%')
                .objectFit(ImageFit.Cover)
                .height(96)
                .borderRadius({topLeft: 16, topRight: 16})
              Text(this.title)
                .height(20)
                .width('100%')
                .fontSize(14)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(1)
                .fontWeight(400)
                .padding({left: 12, right: 12})
                .margin({top: 8})
              Text(this.brief)
                .height(32)
                .width('100%')
                .fontSize(12)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(2)
                .fontWeight(400)
                .fontColor('rgba(0, 0, 0, 0.6)')
                .padding({left: 12, right: 12})
                .margin({top: 2})
            }
            .width(160)
            .height(170)
            .borderRadius(16)
            .backgroundColor(Color.White)
          }
          .margin({right: 20})

          GridItem(){
            Column(){
              Image($r('app.media.enablement_pic1'))
                .width('100%')
                .objectFit(ImageFit.Cover)
                .height(96)
                .borderRadius({topLeft: 16, topRight: 16})
              Text(this.title)
                .height(20)
                .width('100%')
                .fontSize(14)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(1)
                .fontWeight(400)
                .padding({left: 12, right: 12})
                .margin({top: 8})
              Text(this.brief)
                .height(32)
                .width('100%')
                .fontSize(12)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(2)
                .fontWeight(400)
                .fontColor('rgba(0, 0, 0, 0.6)')
                .padding({left: 12, right: 12})
                .margin({top: 2})
            }
            .width(160)
            .height(170)
            .borderRadius(16)
            .backgroundColor(Color.White)
          }
          .margin({right: 20})
          GridItem(){
            Column(){
              Image($r('app.media.enablement_pic1'))
                .width('100%')
                .objectFit(ImageFit.Cover)
                .height(96)
                .borderRadius({topLeft: 16, topRight: 16})
              Text(this.title)
                .height(20)
                .width('100%')
                .fontSize(14)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(1)
                .fontWeight(400)
                .padding({left: 12, right: 12})
                .margin({top: 8})
              Text(this.brief)
                .height(32)
                .width('100%')
                .fontSize(12)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(2)
                .fontWeight(400)
                .fontColor('rgba(0, 0, 0, 0.6)')
                .padding({left: 12, right: 12})
                .margin({top: 2})
            }
            .width(160)
            .height(170)
            .borderRadius(16)
            .backgroundColor(Color.White)
          }
          .margin({right: 20})

          GridItem(){
            Column(){
              Image($r('app.media.enablement_pic1'))
                .width('100%')
                .objectFit(ImageFit.Cover)
                .height(96)
                .borderRadius({topLeft: 16, topRight: 16})
              Text(this.title)
                .height(20)
                .width('100%')
                .fontSize(14)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(1)
                .fontWeight(400)
                .padding({left: 12, right: 12})
                .margin({top: 8})
              Text(this.brief)
                .height(32)
                .width('100%')
                .fontSize(12)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(2)
                .fontWeight(400)
                .fontColor('rgba(0, 0, 0, 0.6)')
                .padding({left: 12, right: 12})
                .margin({top: 2})
            }
            .width(160)
            .height(170)
            .borderRadius(16)
            .backgroundColor(Color.White)
          }
        }
        .rowsTemplate('1fr')
        .height(170)
      }
      .padding({left: 16, right: 16})

      Column(){
        Text('入门教程')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .margin({top: 10, bottom: 10})
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding({left: 16, right: 16})
      .margin({top: 5})

      Row(){
        Column(){
          Text(this.title)
            .height(20)
            .width('100%')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(1)
            .margin({top: 5})
          Text(this.brief)
            .height(32)
            .width('100%')
            .fontSize(12)
            .fontColor('rgba(0, 0, 0, 0.6)')
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(2)
            .margin({top: 5})
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 图片以固定尺寸显示后，它以1占据剩下所有
        // 若还有 另外一个的layoutWeight为2,则它和别个以1:2来分

        Image($r('app.media.enablement_pic1'))
          .objectFit(ImageFit.Cover)
          .height(64)
          .width(108)
          .borderRadius(16)
      }
      .alignItems(VerticalAlign.Top)
      .backgroundColor('#fff')
      .margin(10)
      .padding(10)
      .borderRadius(15)

      Row(){
        Column(){
          Text(this.title)
            .height(20)
            .width('100%')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(1)
            .margin({top: 5})
          Text(this.brief)
            .height(32)
            .width('100%')
            .fontSize(12)
            .fontColor('rgba(0, 0, 0, 0.6)')
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(2)
            .margin({top: 5})
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 图片以固定尺寸显示后，它以1占据剩下所有
        // 若还有 另外一个的layoutWeight为2,则它和别个以1:2来分

        Image($r('app.media.enablement_pic1'))
          .objectFit(ImageFit.Cover)
          .height(64)
          .width(108)
          .borderRadius(16)
      }
      .alignItems(VerticalAlign.Top)
      .backgroundColor('#fff')
      .margin(10)
      .padding(10)
      .borderRadius(15)

      Row(){
        Column(){
          Text(this.title)
            .height(20)
            .width('100%')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(1)
            .margin({top: 5})
          Text(this.brief)
            .height(32)
            .width('100%')
            .fontSize(12)
            .fontColor('rgba(0, 0, 0, 0.6)')
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(2)
            .margin({top: 5})
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 图片以固定尺寸显示后，它以1占据剩下所有
        // 若还有 另外一个的layoutWeight为2,则它和别个以1:2来分

        Image($r('app.media.enablement_pic1'))
          .objectFit(ImageFit.Cover)
          .height(64)
          .width(108)
          .borderRadius(16)
      }
      .alignItems(VerticalAlign.Top)
      .backgroundColor('#fff')
      .margin(10)
      .padding(10)
      .borderRadius(15)

      Row(){
        Column(){
          Text(this.title)
            .height(20)
            .width('100%')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(1)
            .margin({top: 5})
          Text(this.brief)
            .height(32)
            .width('100%')
            .fontSize(12)
            .fontColor('rgba(0, 0, 0, 0.6)')
            .textAlign(TextAlign.Start)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(2)
            .margin({top: 5})
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 图片以固定尺寸显示后，它以1占据剩下所有
        // 若还有 另外一个的layoutWeight为2,则它和别个以1:2来分

        Image($r('app.media.enablement_pic1'))
          .objectFit(ImageFit.Cover)
          .height(64)
          .width(108)
          .borderRadius(16)
      }
      .alignItems(VerticalAlign.Top)
      .backgroundColor('#fff')
      .margin(10)
      .padding(10)
      .borderRadius(15)


    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1f3f5')
  }
}

// 预览当前组件
@Preview
@Component
struct ThirdDemo{
  build() {
    Third()
  }
}

