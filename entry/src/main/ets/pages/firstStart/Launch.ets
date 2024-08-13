import CustomDialogComponent from './CustomDialog'
import { common } from '@kit.AbilityKit';
import FirstPreferenceUtil from './FirstPreferenceUtil';
import { router } from '@kit.ArkUI';
import { preferences } from '@kit.ArkData';


@Entry
@Component
struct Launch{
  private context?: common.UIAbilityContext; // 明确变量类型
  @State isPrivacy: preferences.ValueType = false;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogComponent({
      cancel: ()=>{
        this.handleCancel()
      },
      confirm: ()=>{
        // 放在函数里面执行，如果写成 confirm: this.handleConfirm会导致保存不成功
        this.handleConfirm()
      }
    }),
    alignment: DialogAlignment.Bottom,
    offset: {dx: 0, dy: -24},
    customStyle: true,
    autoCancel: false
  })

  handleConfirm(){
    // 同意隐私
    // 异步方式
    FirstPreferenceUtil.setPreference('firstStart', 'isPrivacy', true).then(()=>{
      this.isPrivacy = true;
      console.log('con:', this.isPrivacy)
      router.pushUrl({url: 'pages/firstStart/Advertise'});
    });

    // 同步方式
    // FirstPreferenceUtil.setPreference('firstStart', 'isPrivacy', true);
    // this.isPrivacy = true;
    // console.log('con:', this.isPrivacy)
    // router.pushUrl({url: 'pages/firstStart/Advertise'});
  }

  handleCancel(){
    // 退出
    this.context?.terminateSelf();
  }

  async onPageShow(): Promise<void> {
    this.context = getContext(this) as common.UIAbilityContext;
    // 异步
    let privacy = await FirstPreferenceUtil.getPreference('firstStart', 'isPrivacy', this.isPrivacy);
    // 同步
    // let privacy = FirstPreferenceUtil.getPreference('firstStart', 'isPrivacy', this.isPrivacy);
    console.log("lunch:", privacy)
    if(!privacy){
      // 显示弹窗
      this.dialogController.open();
    }
    else{
      this.isPrivacy = privacy
      router.pushUrl({url: 'pages/firstStart/Advertise'});
    }
  }

  onPageHide(): void {
    console.log('hide '+this.isPrivacy);
  }

  build() {
    Stack(){
      Image('pages/firstStart/images/ic_launcher.png')
        .width('100%')
        .height('100%')

      Column(){
        Image('pages/firstStart/images/ic_logo.png')
          .width(120)
          .height(120)
          .margin({top: '16%'})

        Text('健康生活')
          .width(105)
          .height(35)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(0.1)
          .fontSize('26fp')
          .fontColor('#182431')
          .margin({top: '0.5%'})

        Text('健康总有新玩法')
          .height('3%')
          .fontWeight(FontWeight.Normal)
          .letterSpacing(3.5)
          .fontSize('16fp')
          .fontColor('#182431')
          .opacity(0.6)
          .margin({top: '1.5%'})
      }
      .width('100%')
      .height('100%')
    }
  }
}