

// 单例子模式
export class GlobalContext{
  constructor() {
  }

  private static instance: GlobalContext;
  private map = new Map<string, Object>();

  // 单实例
  public static getContext(): GlobalContext{
    if(!GlobalContext.instance){
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  getObject(value: string): Object | undefined{
    return this.map.get(value);
  }

  setObject(key: string, obj: Object): void{
    this.map.set(key, obj);
  }
}