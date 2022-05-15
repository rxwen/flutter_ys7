import 'package:dio/dio.dart';

import 'package:flutter_ys7/src/entity/Ys7PtzRequestEntity.dart';

// api文档： http://open.ys7.com/doc/zh/book/index/device_ptz.html#device_ptz-api1

class FlutterYs7HttpApi {
  // 开始云台控制
  static const String POST_DEVICE_PTZ_START =
      "https://open.ys7.com/api/lapp/device/ptz/start";

  // 关闭云台控制
  static const String POST_DEVICE_PTZ_STOP =
      "https://open.ys7.com/api/lapp/device/ptz/stop";

  // 镜像翻转
  static const String POST_DEVICE_PTZ_MIRROR =
      "https://open.ys7.com/api/lapp/device/ptz/mirror";

  // 添加预置点
  static const String POST_DEVICE_PRESET_ADD =
      "https://open.ys7.com/api/lapp/device/preset/add";

  // 调用预置点
  static const String POST_DEVICE_PRESET_MOVE =
      "https://open.ys7.com/api/lapp/device/preset/move";

  // 调用预置点
  static const String POST_DEVICE_PRESET_CLEAR =
      "https://open.ys7.com/api/lapp/device/preset/clear";

  // 查询设备能力
  static const String POST_DEVICE_CAPACITY =
      "https://open.ys7.com/api/lapp/device/capacity";

  static Future<YS7ResponseEntity> device_ptz_start(
      YS7PtzRequestEntity requestEntity) async {
    FormData formData = new FormData.fromMap({
      "accessToken": requestEntity.accessToken,
      "deviceSerial": requestEntity.deviceSerial,
      "channelNo": requestEntity.channelNo,
      "direction": requestEntity.direction,
      "speed": requestEntity.speed,
    });

    try {
      Response response =
          await Dio().post(POST_DEVICE_PTZ_START, data: formData);
      if (response.statusCode == 200) {
        YS7ResponseEntity responseData =
            YS7ResponseEntity.fromJson(response.data);
        print(response);

        return responseData;

        // if (Comparable.compare(responseData.code, "200") == 0) {
        //   // == 1 大于 "200"  == -1 小于 "200"
        //   return true;
        // }
      } else {
        // 失败
        return YS7ResponseEntity.fromJson({
          "code": response.statusCode,
          "msg": response.statusMessage,
        });
      }
    } catch (e) {
      return YS7ResponseEntity.fromJson({
        "code": 500,
        "msg": e.toString(),
      });
    }
  }

  static Future<YS7ResponseEntity> device_ptz_stop(
      YS7PtzRequestEntity requestEntity) async {
    FormData formData = new FormData.fromMap({
      "accessToken": requestEntity.accessToken,
      "deviceSerial": requestEntity.deviceSerial,
      "channelNo": requestEntity.channelNo,
      "direction": requestEntity.direction,
    });

    try {
      Response response =
          await Dio().post(POST_DEVICE_PTZ_STOP, data: formData);
      if (response.statusCode == 200) {
        YS7ResponseEntity responseData =
            YS7ResponseEntity.fromJson(response.data);
        print(response);
        return responseData;
      } else {
        // 失败
        return YS7ResponseEntity.fromJson({
          "code": response.statusCode,
          "msg": response.statusMessage,
        });
      }
    } catch (e) {
      print(e);
      return YS7ResponseEntity.fromJson({
        "code": 500,
        "msg": e.toString(),
      });
    }
  }

  static Future<bool> device_capacity(YS7PtzRequestEntity requestEntity) async {
    FormData formData = new FormData.fromMap({
      "accessToken": requestEntity.accessToken,
      "deviceSerial": requestEntity.deviceSerial,
    });

    try {
      Response response =
          await Dio().post(POST_DEVICE_CAPACITY, data: formData);
      if (response.statusCode == 200) {
        YS7ResponseEntity responseData =
            YS7ResponseEntity.fromJson(response.data);
        print(response);
        if (Comparable.compare(responseData.code, "200") == 0) {
          // == 1 大于 "200"  == -1 小于 "200"
          return true;
        }
      }
      // 失败
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> device_add(YS7PtzRequestEntity requestEntity) async {
    FormData formData = new FormData.fromMap({
      "accessToken": requestEntity.accessToken,
      "deviceSerial": requestEntity.deviceSerial,
      "validateCode": requestEntity.validateCode,
    });

    try {
      Response response = await Dio()
          .post("https://open.ys7.com/api/lapp/device/add", data: formData);
      if (response.statusCode == 200) {
        YS7ResponseEntity responseData =
            YS7ResponseEntity.fromJson(response.data);
        print(response);
        if (Comparable.compare(responseData.code, "200") == 0) {
          // == 1 大于 "200"  == -1 小于 "200"
          return true;
        }
      }
      // 失败
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> device_delete(YS7PtzRequestEntity requestEntity) async {
    FormData formData = new FormData.fromMap({
      "accessToken": requestEntity.accessToken,
      "deviceSerial": requestEntity.deviceSerial,
    });

    try {
      Response response = await Dio()
          .post("https://open.ys7.com/api/lapp/device/delete", data: formData);
      if (response.statusCode == 200) {
        YS7ResponseEntity responseData =
            YS7ResponseEntity.fromJson(response.data);
        print(response);
        if (Comparable.compare(responseData.code, "200") == 0) {
          // == 1 大于 "200"  == -1 小于 "200"
          return true;
        }
      }
      // 失败
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> device_ipc_add(YS7PtzRequestEntity requestEntity) async {
    FormData formData = new FormData.fromMap({
      "accessToken": requestEntity.accessToken,
      "deviceSerial": requestEntity.deviceSerial,
      "ipcserial": requestEntity.deviceSerial,
      "channelNo": requestEntity.channelNo,
      "validateCode": requestEntity.validateCode,
    });

    try {
      Response response = await Dio()
          .post("https://open.ys7.com/api/lapp/device/ipc/add", data: formData);
      if (response.statusCode == 200) {
        YS7ResponseEntity responseData =
            YS7ResponseEntity.fromJson(response.data);
        print(response);
        if (Comparable.compare(responseData.code, "200") == 0) {
          // == 1 大于 "200"  == -1 小于 "200"
          return true;
        }
      }
      // 失败
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> device_ipc_delete(
      YS7PtzRequestEntity requestEntity) async {
    FormData formData = new FormData.fromMap({
      "accessToken": requestEntity.accessToken,
      "deviceSerial": requestEntity.deviceSerial,
      "ipcserial": requestEntity.deviceSerial,
      "channelNo": requestEntity.channelNo,
      "validateCode": requestEntity.validateCode,
    });

    try {
      Response response = await Dio().post(
          "https://open.ys7.com/api/lapp/device/ipc/delete",
          data: formData);
      if (response.statusCode == 200) {
        YS7ResponseEntity responseData =
            YS7ResponseEntity.fromJson(response.data);
        print(response);
        if (Comparable.compare(responseData.code, "200") == 0) {
          // == 1 大于 "200"  == -1 小于 "200"
          return true;
        }
      }
      // 失败
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
