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
  static Map<int, Function> callBackFuncMap = Map();

  static void initMessageHandler() {
    // ignore: missing_return
    _native_ys7.setMessageHandler((dynamic str) {
      Map<String, dynamic> data =
          json.decode(str); // m2 = {name: AllenSu, area: 郑州, sex: 男, age: 18}

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
          if (callBackFuncMap.containsKey(data['callBackFuncId'])) {
            try {
              var func = callBackFuncMap.remove(data['callBackFuncId']);
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

  static Future<bool> setAccessToken(String accessToken) async {
    var result = await _plugin_channel.invokeMethod("set_access_token", {
      'accessToken': accessToken,
    });
    return true;
  }

  static Future<bool> endVideo() async {
    var result = await _channel.invokeMethod("end");
    return true;
  }

  static Future<bool> queryPlayback(Function func) async {
    int id = new DateTime.now().millisecondsSinceEpoch;
    while (callBackFuncMap.containsKey(id)) {
      id = new DateTime.now().millisecondsSinceEpoch;
    }
    callBackFuncMap[id] = func;

    var result = await _channel.invokeMethod("queryPlayback", {
      'callBackFuncId': id,
    });
    return true;
  }

  static Future<bool> playback(Ys7VideoRequestEntity ys7videoRequestEntity) async {

    var result = await _channel.invokeMethod("playback",{
      'startTime':ys7videoRequestEntity.startTime,
      'endTime':ys7videoRequestEntity.endTime,
      'deviceSerial':ys7videoRequestEntity.deviceSerial,
      'verifyCode':ys7videoRequestEntity.verifyCode,
      'cameraNo': ys7videoRequestEntity.cameraNo,
    });
    return true;
  }

  static Future<bool> ptzStart(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_ptz_start(requestEntity);
  }

  static Future<bool> ptzStop(YS7PtzRequestEntity requestEntity) async {
    return await FlutterYs7HttpApi.device_ptz_stop(requestEntity);
  }

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
