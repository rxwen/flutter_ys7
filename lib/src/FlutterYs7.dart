import 'dart:async';

import 'package:flutter/services.dart';

class FlutterYs7 {

  static const _channel = const MethodChannel("cspy/flutter_ys7");

  static const _plugin_channel = const MethodChannel("cspy/flutter_ys7/plugin");

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
