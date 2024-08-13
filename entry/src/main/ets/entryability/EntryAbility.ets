import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { GlobalContext } from '../common/utils/GlobalContext';
import PreferenceUtil from '../pages/fontDemo/PreferenceUtil';
import FirstPreferenceUtil from '../pages/firstStart/FirstPreferenceUtil';

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void>{
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // 初始化一个preference，name为MyPreference
    // PreferenceUtil.loadPreference(this.context, 'MyPreference');
    // //设置MyPreference下的一个key为FontSize的值为1
    // PreferenceUtil.setPreference('MyPreference', 'FontSize', 18);

    // 初始化Preference
    // 有个小bug, 在工具方法中虽然是async,但是不能使用await, 否者持久化不生效
    FirstPreferenceUtil.createPreference(this.context, 'firstStart');
    FirstPreferenceUtil.setPreference('firstStart', 'isPrivacy', false);
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // app加载的第一个页面
    windowStage.loadContent('pages/firstStart/Launch', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    try{
      windowStage.on('windowStageEvent', (data)=>{
        let stateEventType: window.WindowStageEventType = data;

        switch(stateEventType){
          case window.WindowStageEventType.SHOWN: // 切换到前台
            console.log("前台 foreground");
            break;
          case window.WindowStageEventType.ACTIVE: // 获焦状态
            console.log("激活 active");
            break;
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            console.log("失焦 inactive");
            break;
          case window.WindowStageEventType.HIDDEN: // 切到后台
            console.log("后台 hidden");
            break;
          default:
            break;
        }
      });
    } catch (exception) {
      console.error("Failed:"+JSON.stringify(exception));
    }
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    GlobalContext.getContext().setObject('isBackRouter', false);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
