import 'dart:async';

import 'package:flutter/services.dart';

class FlutterYs7 {
  static const MethodChannel _channel = const MethodChannel('flutter_ys7');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static const platform1 = const MethodChannel("cspy/flutter_ys7");

  static Future<bool> startVideo4(String token, String deviceSerial,
      String verifyCode, int cameraNO) async {
    //  *  @param deviceSerial 设备序列号
    //  *  @param cameraNo     通道号
    var result = await platform1.invokeMethod("start", {
      'token': token,
      'deviceSerial': deviceSerial,
      'cameraNo': cameraNO,
      'verifyCode': verifyCode
    });

    // var result = await platform1.invokeMethod("start", {
    //   'token': 'at.50exb3bva7qcfn0398ll409t7sa3dlou-6t5ui3a7hx-0u7rtks-xm4axxp9v',
    //   'deviceSerial': 'C24673046',
    //   'cameraNo': 1,
    //   'verifyCode': "ccv123456"
    // });

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
    return await startVideo4(token, deviceSerial, null, 1);
  }
}
