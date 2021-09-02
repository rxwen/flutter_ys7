# flutter_ys7
flutter 萤石云直播插件


| 功能  | android | ios    |
| -------- | ------- | ------ |
| 直播功能 | ✔️     | ✔️      |
| 云台控制 | ✔️  | ✔️ |
| sd卡/NVR回放 | ✔️ | 开发中 |



### 安装

添加依赖 `flutter_ys7` 到 pubspec.yaml 文件

#### IOS

关闭目标target的bitcode功能 Build Settings->Enable Bitcode设置为NO



将以下内容添加到你的 info.plist 文件

1. 相册权限： 如果需要使用开放平台播放器录像和截图并保存的功能，就需要配置相册权限。

   ```
   <key>NSPhotoLibraryUsageDescription</key>
   <string>需要使用手机相册</string>
   <key>NSPhotoLibraryAddUsageDescription</key>
   <string>需要使用手机相册</string>
   ```

2. 麦克风权限： 如果需要使用设备对讲功能，就需要配置麦克风权限。务必在发起对讲前向iOS系统申请麦克风权限，否则将导致第一次对讲异常。

   ```
   <key>NSMicrophoneUsageDescription</key>
   <string>需要使用手机麦克风</string>
   ```

3. 摄像头权限： 如果需要仿照demo实现扫码添加设备功能，就需要配置摄像头权限。

   ```
   <key>NSCameraUsageDescription</key>
   <string>需要使用手机照相机</string>
   ```



#### android

在 AndroidMainfest.xml 文件中添加权限：

```
  <!--基础功能所需权限-->
    <!--用于访问网络-->
    <uses-permission android:name="android.permission.INTERNET" />
    <!--用于保存抓取图片，码流等行为-->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <!--配网所需权限,由于会涉及到网络连接等行为，同时还有安全方面的机制，因为也会使用到FINE_LOCATION-->
    <uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE" />
    <!--对讲所需权限-->
    <!--可修改对讲方式，如使用听筒或者耳机播放等-->
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <!--对讲时，采集麦克风的音频输入-->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <!--视频通话权限所需-->
    <!--视频通话时，采集摄像头视频-->
    <uses-permission android:name="android.permission.CAMERA" />
    <!--视频通话时，采集麦克风的音频输入-->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
```


使用 kotlin 在 MainActivity 添加
```kotlin
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController.registry.registerViewFactory("cspy/flutter_ys7/videoView",
                FlutterYs7ViewFactory(flutterEngine.dartExecutor.binaryMessenger,application))
    }
}
```

使用 java 在 MainActivity 添加
```java
public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        flutterEngine.getPlatformViewsController().getRegistry().registerViewFactory("cspy/flutter_ys7/videoView",
                new FlutterYs7ViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger(),getApplication()));
    }
}
```

#### 代码混淆

目前sdk在打包时不能混淆,请添加以下内容

```
#========SDK对外接口=======#
-keep class com.ezviz.opensdk.** { *;}

#========以下是hik二方库=======#
-dontwarn com.ezviz.**
-keep class com.ezviz.** { *;}

-dontwarn com.ez.**
-keep class com.ez.** { *;}

-dontwarn com.hc.CASClient.**
-keep class com.hc.CASClient.** { *;}

-dontwarn com.videogo.**
-keep class com.videogo.** { *;}

-dontwarn com.hik.TTSClient.**
-keep class com.hik.TTSClient.** { *;}

-dontwarn com.hik.stunclient.**
-keep class com.hik.stunclient.** { *;}

-dontwarn com.hik.streamclient.**
-keep class com.hik.streamclient.** { *;}

-dontwarn com.hikvision.sadp.**
-keep class com.hikvision.sadp.** { *;}

-dontwarn com.hikvision.netsdk.**
-keep class com.hikvision.netsdk.** { *;}

-dontwarn com.neutral.netsdk.**
-keep class com.neutral.netsdk.** { *;}

-dontwarn com.hikvision.audio.**
-keep class com.hikvision.audio.** { *;}

-dontwarn com.mediaplayer.audio.**
-keep class com.mediaplayer.audio.** { *;}

-dontwarn com.hikvision.wifi.**
-keep class com.hikvision.wifi.** { *;}

-dontwarn com.hikvision.keyprotect.**
-keep class com.hikvision.keyprotect.** { *;}

-dontwarn com.hikvision.audio.**
-keep class com.hikvision.audio.** { *;}

-dontwarn org.MediaPlayer.PlayM4.**
-keep class org.MediaPlayer.PlayM4.** { *;}
#========以上是hik二方库=======#

#========以下是第三方开源库=======#
# JNA
-dontwarn com.sun.jna.**
-keep class com.sun.jna.** { *;}

# Gson
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.idea.fifaalarmclock.entity.***
-keep class com.google.gson.stream.** { *; }

# OkHttp
# JSR 305 annotations are for embedding nullability information.
-dontwarn javax.annotation.**
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*
# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.ConscryptPlatform
# 必须额外加的，否则编译无法通过
-dontwarn okio.**
#========以上是第三方开源库=======#
```


### 使用方式

```dart
// 详情见example/lib/main.dart

onTap: () async {

// sdk只需要初始化一次
await FlutterYs7.initSdk("appkey");

//   'deviceSerial': '设备序列号',
//   'cameraNo': 1,
//   'verifyCode': "passworld"

var result = await FlutterYs7.startVideo3(
'AccessToken',
'设备序列号',
'passworld'
);
print(result);

}

```

