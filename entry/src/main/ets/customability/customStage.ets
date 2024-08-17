import {AbilityStage, Want} from "@kit.AbilityKit";
import { JSON } from '@kit.ArkTS';
import { window } from '@kit.ArkUI';

// UIAbility会在合适的AbilityStage中进行初始化
// specified指定实例模式下，每返回主屏点击一次app，就会调用一次startAbility()方法创建一次实例
export default class CustomStage extends AbilityStage{
  // 应用的HAP在首次加载时的初始化操作
  onCreate(): void {
    console.log("初始化")
  }

  // 返回主屏后，二次点击app进入触发此事件, 而非触发onCreate和onWindowStageCreate
  // 由于某些原因切换到后台，再次启动该UIAbility实例时会回调执行该方法。即UIAbility实例热启动时进入该生命周期回调
  onNewWant(want: Want): void{
    console.log("模式不确定 newWant")
    console.log(JSON.stringify(want));
  }

  onWindowStageCreate(windowStage: window.WindowStage): void{
    console.log("windowStage:")
    console.log(JSON.stringify(windowStage))
  }

  onAcceptWant(want: Want): string {
    console.log("232")
    // 仅specified模式下触发
    return "CustomAbilityStage";
  }

}