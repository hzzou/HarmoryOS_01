


@Entry
@Component
struct TabNav{
  // @State定义的变量才会引起页面渲染,private定义的不会
  @State currentIndex: number = 3;

  @Builder
  CustomBar(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource){
    Column(){
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({width: 25, height: 25})
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698ce' : '#6b6b6b')
        .fontWeight(this.currentIndex === targetIndex ? FontWeight.Bold : FontWeight.Normal)
        .fontSize(16)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    /*Tabs({barPosition: BarPosition.Start}){
      TabContent(){
        Text('首页内容')
          .fontSize(30)
      }
      .tabBar('首页')

      TabContent(){
        Text('推荐的内容')
          .fontSize(30)
      }
      .tabBar('推荐')

      TabContent(){
        Text('发现的内容')
          .fontSize(30)
      }
      .tabBar('发现')

      TabContent(){
        Text('我的内容')
          .fontSize(30)
      }
      .tabBar('我的')
    }
    .vertical(true)
    .barWidth(100)
    .barHeight(300)*/
   /* Tabs({barPosition: BarPosition.End}){
      TabContent(){
        Column(){
          Tabs(){
            TabContent(){
              Text('关注内容')
                .fontSize(30)
            }
            .backgroundColor('#f00')
            .tabBar('关注')

            TabContent(){
              Text('视频内容')
                .fontSize(30)
            }
            .backgroundColor('#ff0')
            .tabBar('视频')

            TabContent(){
              Text('游戏内容')
                .fontSize(30)
            }
            .backgroundColor('#fff')
            .tabBar('游戏')

            TabContent(){
              Text('数码内容')
                .fontSize(30)
            }
            .backgroundColor('#0ff')
            .tabBar('数码')

            TabContent(){
              Text('科技内容')
                .fontSize(30)
            }
            .backgroundColor('#00f')
            .tabBar('科技')

            TabContent(){
              Text('体育内容')
                .fontSize(30)
            }
            .backgroundColor('#000')
            .tabBar('体育')

            TabContent(){
              Text('影视内容')
                .fontSize(30)
            }
            .backgroundColor('#00f')
            .tabBar('影视')

            TabContent(){
              Text('人文内容')
                .fontSize(30)
            }
            .backgroundColor('#0ff')
            .tabBar('人文')

            TabContent(){
              Text('艺术内容')
                .fontSize(30)
            }
            .backgroundColor('#ff0')
            .tabBar('艺术')

            TabContent(){
              Text('自然内容')
                .fontSize(30)
            }
            .backgroundColor('#ff0')
            .tabBar('自然')

            TabContent(){
              Text('军事内容')
                .fontSize(30)
            }
            .backgroundColor('#ff0')
            .tabBar('军事')
          }
          .barMode(BarMode.Scrollable)
        }

      }
      .tabBar('首页')

      TabContent(){
        Text('推荐的内容')
          .fontSize(30)
      }
      .tabBar('推荐')

      TabContent(){
        Text('发现的内容')
          .fontSize(30)
      }
      .tabBar('发现')

      TabContent(){
        Text('我的内容')
          .fontSize(30)
      }
      .tabBar('我的')
    }
    .scrollable(false)*/

    // index设置激活第几个TabContent
    Tabs({barPosition: BarPosition.End, index: 3}){
      TabContent(){
        Column(){
          // 以ets文件夹为起点
          Image('images/ic_ok.png')
            .width(200)
            .height(200)
          Text('首页')
        }
      }
      .tabBar(this.CustomBar('首页', 0, $r('app.media.tutorial_pic1'), $r('app.media.tutorial_pic2')))

      TabContent(){
        Text('信息')
      }
      .tabBar(this.CustomBar('信息', 1, $r('app.media.tutorial_pic3'), $r('app.media.tutorial_pic4')))

      TabContent(){
        Text('相册')
      }
      .tabBar(this.CustomBar('相册', 2, $r('app.media.tutorial_pic5'), $r('app.media.tutorial_pic6')))

      TabContent(){
        Text('我的')
      }
      .tabBar(this.CustomBar('我的', 3, $r('app.media.tutorial_pic7'), $r('app.media.tutorial_pic8')))
    }
    .onChange((index: number)=>{
      console.log('idx:', index);
      this.currentIndex = index;
    })

  }
}

@Preview
@Component
struct NavPrev{
  build(){
    TabNav()
  }
}