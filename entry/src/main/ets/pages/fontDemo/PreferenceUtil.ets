import { preferences } from '@kit.ArkData'

class PreferenceUtil{
  prefMap: Map<string, preferences.Preferences> = new Map();

  // 加载preferences，name是preference的名字
  async loadPreference(context: Context, name: string){
    try{
      let prefer = await preferences.getPreferences(context, name);
      this.prefMap.set(name, prefer); // 把preferences存到map中
      console.log(`加载preference ${name}成功`);
    } catch (e) {
      console.log(`加载preference ${name}失败`, JSON.stringify(e))
    }
  }

  // name是preference的名字，key是要存的键值对的key, value是数据
  async setPreference(name: string, key: string, value: preferences.ValueType){
    if(!this.prefMap.has(name)){
      console.log(`preference ${name}尚未初始化`);
      return;
    }

    try{
      let prefer = this.prefMap.get(name);
      if(prefer){
        await prefer.put(key, value); // 存数据
        await prefer.flush(); // 持久化
        console.log(`保存preference ${name}.${key} 成功`)
      }
    } catch (e) {
      console.log(`保存preference ${name}.${key} 失败`, JSON.stringify(e))
    }
  }

  // preferences.get的时候，也需要给定默认值(必须的)
  async getPreference(name: string, key: string, defaultValue: preferences.ValueType): Promise<preferences.ValueType>{
    let result: preferences.ValueType = defaultValue;

    if(!this.prefMap.has(name)){
      console.log(`preference ${name}尚未初始化`);
      return result;
    }

    try{
      let prefer = this.prefMap.get(name);
      if(prefer){
        let value: preferences.ValueType = await prefer.get(key, defaultValue);
        console.log(`读取preference ${name}.${key} = ${value} 成功`);
        result = value;
      }
    } catch (e) {
      console.log(`读取preference ${name}.${key}失败`, JSON.stringify(e));
    }

    return result;
  }
}

export default new PreferenceUtil();