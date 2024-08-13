

class ArticleType{
  id: string = '';
  imgSrc: ResourceStr = '';
  title: string = '';
  brief: string = '';

  constructor(id: string, imgSrc: ResourceStr, title: string, brief: string) {
    this.id = id;
    this.imgSrc = imgSrc;
    this.title = title;
    this.brief = brief;
  }
}

// 要添加entry， preview才会生效
@Entry
@Component
struct Four{
  // 其值改变引起试图更新, private类型的则不会
  @State message: string = '快速入门';
  @State enableList: Array<ArticleType> = [
    new ArticleType('1', $r('app.media.enablement_pic1'), 'HarmonyOS第一课', '基于真实的开发场景，提供向导式学习，多维度融合课程等内容，给开发者提供全新的学习体验。'),
    new ArticleType('2', $r('app.media.enablement_pic2'), '开发指南', '提供系统能力概述、快速入门，用于指导开发者进行场景化的开发。指南涉及到的知识点包括必要的背景知识、符合开发者实际开发场景的操作任务流（开发流程、开发步骤、调测验证）以及常见问题等。'),
    new ArticleType('3', $r('app.media.enablement_pic3'), '最佳实践', '针对新发布特性及热点特性提供详细的技术解析和开发最佳实践。'),
    new ArticleType('4', $r('app.media.enablement_pic4'), 'Codelabs', '以教学为目的的代码样例及详细的开发指导，帮助开发者一步步地完成指定场景的应用开发并掌握相关知识。Codelabs将最新的鸿蒙生态应用开发技术与典型场景结合，让开发者快速地掌握开发高质量应用的方法。同时支持互动式操作，通过文字、代码和效果联动为开发者带来更佳的学习体验。'),
    new ArticleType('5', $r('app.media.enablement_pic5'), 'Sample', '面向不同类型的开发者提供的鸿蒙生态应用开发优秀实践，每个Sample Code都是一个可运行的工程，为开发者提供实例化的代码参考。'),
    new ArticleType('6', $r('app.media.enablement_pic6'), 'API参考', '面向开发者提供鸿蒙系统开放接口的全集，供开发者了解具体接口使用方法。API参考详细地描述了每个接口的功能、使用限制、参数名、参数类型、参数含义、取值范围、权限、注意事项、错误码及返回值等。'),
    new ArticleType('7', $r('app.media.enablement_pic7'), 'FAQ', '开发者常见问题的总结，开发者可以通过FAQ更高效地解决常见问题。FAQ会持续刷新，及时呈现最新的常见问题。'),
    new ArticleType('8', $r('app.media.enablement_pic8'), '开发者论坛', '和其他应用开发者交流技术、共同进步。'),
  ];
  @State tutorialList: Array<ArticleType> = [
    new ArticleType('1', $r('app.media.tutorial_pic1'), 'Step1 环境的搭建', '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。'),
    new ArticleType('2', $r('app.media.tutorial_pic2'), 'Step2 使用Swiper构建运营广告位',
      'Swiper组件提供滑动轮播显示的能力。Swiper本身是一个容器组件，当设置了多个子组件后，可以对这些子组件进行轮播显示。'),
    new ArticleType('3', $r('app.media.tutorial_pic3'), 'Step3 创建和组合视图',
      'Item定义子组件相关特征。相关组件支持使用条件渲染、循环渲染、懒加载等方式生成子组件。'),
    new ArticleType('4', $r('app.media.tutorial_pic4'), 'Step4 网格和列表组建的使用',
      '网格和列表组件中，当Item达到一定数量，内容超过屏幕大小时，可以自动提供滚动功能，适合用于呈现同类数据类型或数据类型集'),
    new ArticleType('5', $r('app.media.tutorial_pic5'), 'Step5 应用架构设计基础',
      'ArkUI采取MVVM = Model + View + ViewModel模式，将数据与视图绑定在一起，更新数据的时候直接更新视图。'),
    new ArticleType('6', $r('app.media.tutorial_pic6'), 'Step6 ArkWeb页面适配',
      'ArkWeb（方舟Web）提供了Web组件，用于在应用程序中显示Web页面内容，为开发者提供页面加载、页面交互、页面调试等能力。'),
    new ArticleType('7', $r('app.media.tutorial_pic7'), 'Step7 数据驱动UI更新', '数据更新的同时会直接驱动UI的改变'),
    new ArticleType('8', $r('app.media.tutorial_pic8'), 'Step8 设置组件导航',
      'Navigation组件适用于模块内页面切换，一次开发，多端部署场景。通过组件级路由能力实现更加自然流畅的转场体验，并提供多种标题栏样式来呈现更好的标题和内容联动效果。'),
    new ArticleType('9', $r('app.media.tutorial_pic9'), 'Step9 原生智能：AI语音朗读',
      '文本转语音服务提供将文本信息转换为语音并进行播报的能力，便于用户与设备进行互动，实现实时语音交互，文本播报。'),
    new ArticleType('10', $r('app.media.tutorial_pic10'), 'Step10 原生互联：分布式流转',
      '流转能力打破设备界限，多设备联动，使用户应用程序可分可合、可流转，实现如邮件跨设备编辑、多设备协同健身、多屏游戏等分布式业务。'),
    new ArticleType('11', $r('app.media.tutorial_pic11'), 'Step11 一次开发，多端部署',
      '一套代码工程，一次开发上架，多端按需部署。支撑开发者快速高效的开发支持多种终端设备形态的应用，实现对不同设备兼容的同时，提供跨设备的流转、迁移和协同的分布式体验。'),

  ]

  build() {
    Column(){
      Text(this.message)
        .fontSize(24)
        .fontWeight(700)
        .width('100%')
        .padding({left: 16, top: '16vp'}) // 和16vp一样
        .lineHeight(30)

      Banner()
      EnableView({list: this.enableList})
      TutorialView({list: this.tutorialList})

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1f3f5')
  }
}

@Component
struct Banner{
  @State bannerData: Resource[] = [
    $r('app.media.banner_pic0'),
    $r('app.media.banner_pic1'),
    $r('app.media.banner_pic2'),
    $r('app.media.banner_pic3'),
    $r('app.media.banner_pic4'),
    $r('app.media.banner_pic5')
  ];

  build(){
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
  }
}

@Component
struct EnableView{
  @Prop list: Array<ArticleType> = [];

  build(){
    Column(){
      Text('赋能套件')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .margin({top: 10, bottom: 10})
        .width('100%')
        .textAlign(TextAlign.Start)
      Grid(){
        ForEach(this.list, (item: ArticleType)=>{
          GridItem(){
            Column(){
              Image(item.imgSrc)
                .width('100%')
                .objectFit(ImageFit.Cover)
                .height(96)
                .borderRadius({topLeft: 16, topRight: 16})
              Text(item.title)
                .height(20)
                .width('100%')
                .fontSize(14)
                .textAlign(TextAlign.Start)
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .maxLines(1)
                .fontWeight(400)
                .padding({left: 12, right: 12})
                .margin({top: 8})
              Text(item.brief)
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
        }, (item: ArticleType)=>JSON.stringify(item))
      }
      .columnsGap(12)
      .rowsTemplate('1fr')
      .height(170)
    }
    .padding({left: 16, right: 16})

  }
}

@Component
struct TutorialView{
  @Prop list: Array<ArticleType> = [];

  build(){
    Column(){
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

      List({space: 5}){
        ForEach(this.list, (item: ArticleType)=>{
          ListItem(){
            Row(){

              Column(){
                Text(item.title)
                  .height(20)
                  .width('100%')
                  .fontSize(14)
                  .textAlign(TextAlign.Start)
                  .textOverflow({overflow: TextOverflow.Ellipsis})
                  .maxLines(1)
                  .margin({top: 5})
                Text(item.brief)
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
              // 和column在同一个row
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
        }, (item: ArticleType)=>JSON.stringify(item))
      }
    }
  }
}

// 预览当前组件
@Preview
@Component
struct FourDemo{
  build() {
    Four()
  }
}

