import { preferences } from '@kit.ArkData'

// 异步模式
class FirstPreferenceUtil{
  preMap: Map<string, preferences.Preferences> = new Map();

  async createPreference(context: Context, name: string){
    try{
      let prefer = await preferences.getPreferences(context, {name: name});
      this.preMap.set(name, prefer);
      console.log(`初始化preference ${name} 成功`)
    } catch (e) {
      console.log(`初始化preference ${name} 失败`, JSON.stringify(e));
    }
  }

  async setPreference(name: string, key: string, value: preferences.ValueType){
    if(!this.preMap.has(name)){
      console.log(`preference ${name}尚未初始化`);
      return;
    }
    else{
      let prefer = this.preMap.get(name);
      await prefer!.put(key, value); // 同步方法
      await prefer!.flush(); //持久化本地
      console.log(`保存preference ${name}.${key} = ${value} 成功`)
    }
  }

  async getPreference(name: string, key: string, defaultValue: preferences.ValueType){
    let result: preferences.ValueType = defaultValue;
    if(!this.preMap.has(name)){
      console.log(`preference ${name}尚未初始化`);
      return result;
    }
    else{
      let prefer = this.preMap.get(name);
      result = await prefer!.get(key, defaultValue); //需要给默认值
      console.log(`读取preference ${name}.${key} = ${result} 成功`);
      return result;
    }
  }
}

// 同步模式 目前似乎不生效
/*class FirstPreferenceUtil{
  preMap: Map<string, preferences.Preferences> = new Map();

  createPreference(context: Context, name: string){
    try{
      let prefer = preferences.getPreferencesSync(context, {name: name}); // 同步方法
      this.preMap.set(name, prefer);
      console.log(`初始化preference ${name} 成功`)
    } catch (e) {
      console.log(`初始化preference ${name} 失败`, JSON.stringify(e));
    }
  }

  async setPreference(name: string, key: string, value: preferences.ValueType){
    if(this.preMap.has(name)){
      let prefer = this.preMap.get(name);
      prefer!.putSync(key, value); // 同步方法
      await prefer!.flush(); //持久化本地
      console.log(`保存preference ${name}.${key} = ${value} 成功`)
    }
  }

  getPreference(name: string, key: string, defaultValue: preferences.ValueType){
    let result: preferences.ValueType = defaultValue;
    if(this.preMap.has(name)){
      let prefer = this.preMap.get(name);
      result = prefer!.getSync(key, defaultValue); //需要给默认值
      console.log(`读取preference ${name}.${key} = ${result} 成功`);
    }
    return result;
  }
}*/

export default new FirstPreferenceUtil();