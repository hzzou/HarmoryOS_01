
## 记录

* 模拟器动不动就loading,更改一下SDK目录下system-image/HarmonyOS-NEXT-DB1/phone_x86/features.ini文件中的bootanimation.feature.key字段，改为true
* Web组件不支持预览，需要在手机模拟器上或者真机上才能看见，且需要在module.json5中开启requestPermissions的ohos.permission.INTERNET权限
* 模拟器或者真机上热重载,先开启Tools下Actions on Save下的Perform hot reload, File -> Project Structure的Project获取签名(Signing Configs)
* @State定义的变量修改时才会引起页面渲染,private定义的不会
* Navigation设置.menus()时，icon图片字符串的相对位置是在etc目录下建立个images文件夹, pages下组件里写相对目录为'images/ic_video.svg'
* 加载本地图片等资源时(非resources目录下)，路径是以etc文件夹为起点
* preference持久化问题，虽然工具方法里面写的是async函数，但是调用createPreference和setPreference方法的时候，不能使用await,否则持久化不生效, 但是getPreference可以使用await
* Profiler性能调优工具不支持模拟器