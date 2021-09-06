import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_ys7/src/entity/Ys7PtzRequestEntity.dart';
import 'package:flutter_ys7/src/entity/EZDeviceRecordFile.dart';

import '../flutter_ys7.dart';
import 'FlutterYs7HttpApi.dart';

class FlutterYs7 {
  static const _channel = const MethodChannel("cspy/flutter_ys7");

  static const _plugin_channel = const MethodChannel("cspy/flutter_ys7/plugin");

  static const BasicMessageChannel<dynamic> _native_ys7 =
      const BasicMessageChannel("nativeToFlutterYs7", StandardMessageCodec());
  static Map<int, Function> _callBackFuncMap = Map();

  static void initMessageHandler() {
    // ignore: missing_return
    _native_ys7.setMessageHandler((dynamic str) {
      Map<String, dynamic> data = json.decode(str);

      if (data['code'] == 'RecordFile') {
        var fileData = json.decode(data['Data']);
        if (fileData != null) {
          var recordFileList = [];
          fileData.forEach((v) {
            recordFileList.add(new EZDeviceRecordFile.fromJson(v));
          });

          // DateTime moonLanding = DateTime.parse(recordFileList[0].begin);
          // var time = moonLanding.millisecondsSinceEpoch;
          print("hello");
          if (_callBackFuncMap.containsKey(data['callBackFuncId'])) {
            try {
              var func = _callBackFuncMap.remove(data['callBackFuncId']);
              func(recordFileList);
            } catch (e) {
              print('Flutter Ys7 error: $e');
            }
          }
        }
      }

      // if (data != null) {
      //   var data1 = new List<EZDeviceRecordFile>();
      //   data.forEach((v) {
      //     data1.add(new EZDeviceRecordFile.fromJson(v));
      //   });
      // }
    });
  }

  //  *  @param token AccessToken
  //  *  @param deviceSerial 设备序列号
  //  *  @param verifyCode   密码
  //  *  @param cameraNO   通道
  static Future<bool> startVideo4(String token, String deviceSerial,
      String verifyCode, int cameraNO) async {
    var result = await _channel.invokeMethod("start", {
      'token': token,
      'deviceSerial': deviceSerial,
      'cameraNo': cameraNO,
      'verifyCode': verifyCode
    });

    return true;
  }

  //  *  @param token AccessToken
  //  *  @param deviceSerial 设备序列号
  //  *  @param verifyCode   密码
  static Future<bool> startVideo3(
      String token, String deviceSerial, String verifyCode) async {
    return await startVideo4(token, deviceSerial, verifyCode, 1);
  }

  //  *  @param token AccessToken
  //  *  @param deviceSerial 设备序列号
  static Future<bool> startVideo2(
    String token,
    String deviceSerial,
  ) async {
    return await startVideo4(token, deviceSerial, '', 1);
  }

  //  *  @param appKey 账号appKey
  static Future<bool> initSdk(String appKey) async {
    FlutterYs7.initMessageHandler();
    var result = await _plugin_channel.invokeMethod("init_sdk", {
      'appKey': appKey,
    });
    return true;
  }

  static Future<bool> destoryLib(String appKey) async {
    var result = await _plugin_channel.invokeMethod("destoryLib");
    return true;
  }



  // 设置 accessToken
  static Future<bool> setAccessToken(String accessToken) async {
    var result = await _plugin_channel.invokeMethod("set_access_token", {
      'accessToken': accessToken,
    });
    return true;
  }

  // 初始化播放器
  static Future<bool> initEZPlayer(String deviceSerial,String verifyCode, int cameraNo) async {
    var result = await _channel.invokeMethod("EZPlayer_init",{
      'deviceSerial': deviceSerial,
      'verifyCode': verifyCode,
      'cameraNo': cameraNo,
    });
    return true;
  }

  // 释放
  static Future<bool> release() async {
    var result = await _channel.invokeMethod("release",);
    return true;
  }

  // 开启声音
  static Future<bool> closeSound() async {
    var result = await _channel.invokeMethod("sound", {
      'Sound': false,
    });
    return true;
  }

  // 关闭声音
  static Future<bool> openSound( ) async {
    var result = await _channel.invokeMethod("sound", {
      'Sound': true,
    });
    return true;
  }

  static Future<bool> startRealPlay() async {
    var result = await _channel.invokeMethod("startRealPlay");
    return true;
  }

  static Future<bool> stopRealPlay() async {
    var result = await _channel.invokeMethod("stopRealPlay");
    return true;
  }

  static Future<int> getOSDTime() async {
    var result = await _channel.invokeMethod("getOSDTime");
    return result;
  }

  // 结束直播
  static Future<bool> endVideo() async {
    var result = await _channel.invokeMethod("end");
    return true;
  }

  // 开始回放
  static Future<bool> startPlayback(Ys7VideoRequestEntity ys7videoRequestEntity) async {

    var result = await _channel.invokeMethod("startPlayback",{
      'startTime':ys7videoRequestEntity.startTime,
      'endTime':ys7videoRequestEntity.endTime,
    });
    return true;
  }

  // 停止回放
  static Future<bool> stopPlayback() async {

    var result = await _channel.invokeMethod("stopPlayback");
    return true;
  }

  // 查询录制视频(只实现了android)
  static Future<bool> queryPlayback(Ys7VideoRequestEntity request,Function func) async {
    int id = new DateTime.now().millisecondsSinceEpoch;
    while (_callBackFuncMap.containsKey(id)) {
      id = new DateTime.now().millisecondsSinceEpoch;
    }
    _callBackFuncMap[id] = func;

    var result = await _channel.invokeMethod("queryPlayback", {
      'callBackFuncId': id,
      'startTime': request.startTime,
      'endTime': request.endTime,
      'deviceSerial': request.deviceSerial,
      'cameraNo': request.cameraNo,
      'verifyCode': request.verifyCode,
    });
    return true;
  }

  // 控制云台
  static Future<YS7ResponseEntity> ptzStart(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_ptz_start(requestEntity);
  }

  // 停止控制
  static Future<YS7ResponseEntity> ptzStop(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_ptz_stop(requestEntity);
  }
  // 添加设备
  static Future<bool> deviceAdd(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_add(requestEntity);
  }

  static Future<bool> deviceDelete(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_delete(requestEntity);
  }

  static Future<bool> deviceIpcAdd(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_ipc_add(requestEntity);
  }

  static Future<bool> deviceIpcDelete(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_ipc_delete(requestEntity);
  }
}
