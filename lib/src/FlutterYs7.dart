import 'dart:async';

import 'package:flutter/services.dart';

class FlutterYs7 {

  static const _channel = const MethodChannel("cspy/flutter_ys7");

  static const _plugin_channel = const MethodChannel("cspy/flutter_ys7/plugin");

  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }

  static Future<bool> startVideo4(String token, String deviceSerial,
      String verifyCode, int cameraNO) async {
    //  *  @param deviceSerial 设备序列号
    //  *  @param cameraNo     通道号
    var result = await _channel.invokeMethod("start", {
      'token': token,
      'deviceSerial': deviceSerial,
      'cameraNo': cameraNO,
      'verifyCode': verifyCode
    });

    return true;
  }

  //  *  @param token token
  //  *  @param deviceSerial 设备序列号
  //  *  @param verifyCode   密码
  static Future<bool> startVideo3(
      String token, String deviceSerial, String verifyCode) async {
    return await startVideo4(token, deviceSerial, verifyCode, 1);
  }

  static Future<bool> startVideo2(
      String token,
      String deviceSerial,
      ) async {
    return await startVideo4(token, deviceSerial, '', 1);
  }

  static Future<bool> initSdk(String appKey) async {
    var result = await _plugin_channel.invokeMethod("init_sdk", {
      'appKey': appKey,
    });
    return true;
  }

  static Future<bool> endVideo( ) async {
    var result = await _channel.invokeMethod("end");
    return true;
  }

}
