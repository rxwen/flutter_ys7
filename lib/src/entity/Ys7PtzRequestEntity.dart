// entity
class YS7PtzRequestEntity {
  String accessToken;
  String deviceSerial;
  String validateCode;
  String ipcSerial;
  int channelNo;
  int direction;
  int speed;
  int command;
  int index;

  YS7PtzRequestEntity(
      {required this.accessToken,
      required this.deviceSerial,
      required this.validateCode,
      required this.ipcSerial,
      required this.channelNo,
      required this.direction,
      required this.speed,
      required this.command,
      required this.index});

  YS7PtzRequestEntity.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        deviceSerial = json['deviceSerial'],
        validateCode = json['validateCode'],
        ipcSerial = json['ipcSerial'],
        channelNo = json['channelNo'],
        direction = json['direction'],
        speed = json['speed'],
        command = json['command'],
        index = json['index'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['deviceSerial'] = this.deviceSerial;
    data['validateCode'] = this.validateCode;
    data['ipcSerial'] = this.ipcSerial;
    data['channelNo'] = this.channelNo;
    data['direction'] = this.direction;
    data['speed'] = this.speed;
    data['command'] = this.command;
    data['index'] = this.index;
    return data;
  }
}

class YS7ResponseEntity {
  YS7ResponseDataEntity data;
  String code;
  String msg;

  YS7ResponseEntity(
      {required this.data, required this.code, required this.msg});

  YS7ResponseEntity.fromJson(Map<String, dynamic> json)
      : data = new YS7ResponseDataEntity.fromJson(json['data']),
        code = json['code'],
        msg = json['msg'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.toJson();
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}

class YS7ResponseDataEntity {
  String supportCloud;
  String supportIntelligentTrack;
  String supportP2pMode;
  String supportResolution;
  String supportTalk;
  List<VideoQualityCapacity> videoQualityCapacity;
  String supportWifiUserId;
  String supportRemoteAuthRandcode;
  String supportUpgrade;
  String supportSmartWifi;
  String supportSsl;
  String supportWeixin;
  String ptzCloseScene;
  String supportPresetAlarm;
  String supportRelatedDevice;
  String supportMessage;
  String ptzPreset;
  String supportWifi;
  String supportCloudVersion;
  String ptzCenterMirror;
  String supportDefence;
  String ptzTopBottom;
  String supportFullscreenPtz;
  String supportDefenceplan;
  String supportDisk;
  String supportAlarmVoice;
  String ptzLeftRight;
  String supportModifyPwd;
  String supportCapture;
  String supportPrivacy;
  String supportEncrypt;
  String supportAutoOffline;
  int index;

  YS7ResponseDataEntity(
      {required this.supportCloud,
      required this.supportIntelligentTrack,
      required this.supportP2pMode,
      required this.supportResolution,
      required this.supportTalk,
      required this.videoQualityCapacity,
      required this.supportWifiUserId,
      required this.supportRemoteAuthRandcode,
      required this.supportUpgrade,
      required this.supportSmartWifi,
      required this.supportSsl,
      required this.supportWeixin,
      required this.ptzCloseScene,
      required this.supportPresetAlarm,
      required this.supportRelatedDevice,
      required this.supportMessage,
      required this.ptzPreset,
      required this.supportWifi,
      required this.supportCloudVersion,
      required this.ptzCenterMirror,
      required this.supportDefence,
      required this.ptzTopBottom,
      required this.supportFullscreenPtz,
      required this.supportDefenceplan,
      required this.supportDisk,
      required this.supportAlarmVoice,
      required this.ptzLeftRight,
      required this.supportModifyPwd,
      required this.supportCapture,
      required this.supportPrivacy,
      required this.supportEncrypt,
      required this.supportAutoOffline,
      required this.index});

  YS7ResponseDataEntity.fromJson(Map<String, dynamic> json)
      : supportCloud = json['support_cloud'],
        supportIntelligentTrack = json['support_intelligent_track'],
        supportP2pMode = json['support_p2p_mode'],
        supportResolution = json['support_resolution'],
        supportTalk = json['support_talk'],
        supportWifiUserId = json['support_wifi_userId'],
        supportRemoteAuthRandcode = json['support_remote_auth_randcode'],
        supportUpgrade = json['support_upgrade'],
        supportSmartWifi = json['support_smart_wifi'],
        supportSsl = json['support_ssl'],
        supportWeixin = json['support_weixin'],
        ptzCloseScene = json['ptz_close_scene'],
        supportPresetAlarm = json['support_preset_alarm'],
        supportRelatedDevice = json['support_related_device'],
        supportMessage = json['support_message'],
        ptzPreset = json['ptz_preset'],
        supportWifi = json['support_wifi'],
        supportCloudVersion = json['support_cloud_version'],
        ptzCenterMirror = json['ptz_center_mirror'],
        supportDefence = json['support_defence'],
        ptzTopBottom = json['ptz_top_bottom'],
        supportFullscreenPtz = json['support_fullscreen_ptz'],
        supportDefenceplan = json['support_defenceplan'],
        supportDisk = json['support_disk'],
        supportAlarmVoice = json['support_alarm_voice'],
        ptzLeftRight = json['ptz_left_right'],
        supportModifyPwd = json['support_modify_pwd'],
        supportCapture = json['support_capture'],
        supportPrivacy = json['support_privacy'],
        supportEncrypt = json['support_encrypt'],
        supportAutoOffline = json['support_auto_offline'],
        index = json['index'],
        videoQualityCapacity = [] {
    if (json['video_quality_capacity'] != null) {
      // videoQualityCapacity = new List<VideoQualityCapacity>();
      json['video_quality_capacity'].forEach((v) {
        videoQualityCapacity.add(new VideoQualityCapacity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['support_cloud'] = this.supportCloud;
    data['support_intelligent_track'] = this.supportIntelligentTrack;
    data['support_p2p_mode'] = this.supportP2pMode;
    data['support_resolution'] = this.supportResolution;
    data['support_talk'] = this.supportTalk;
    data['video_quality_capacity'] =
        this.videoQualityCapacity.map((v) => v.toJson()).toList();
    data['support_wifi_userId'] = this.supportWifiUserId;
    data['support_remote_auth_randcode'] = this.supportRemoteAuthRandcode;
    data['support_upgrade'] = this.supportUpgrade;
    data['support_smart_wifi'] = this.supportSmartWifi;
    data['support_ssl'] = this.supportSsl;
    data['support_weixin'] = this.supportWeixin;
    data['ptz_close_scene'] = this.ptzCloseScene;
    data['support_preset_alarm'] = this.supportPresetAlarm;
    data['support_related_device'] = this.supportRelatedDevice;
    data['support_message'] = this.supportMessage;
    data['ptz_preset'] = this.ptzPreset;
    data['support_wifi'] = this.supportWifi;
    data['support_cloud_version'] = this.supportCloudVersion;
    data['ptz_center_mirror'] = this.ptzCenterMirror;
    data['support_defence'] = this.supportDefence;
    data['ptz_top_bottom'] = this.ptzTopBottom;
    data['support_fullscreen_ptz'] = this.supportFullscreenPtz;
    data['support_defenceplan'] = this.supportDefenceplan;
    data['support_disk'] = this.supportDisk;
    data['support_alarm_voice'] = this.supportAlarmVoice;
    data['ptz_left_right'] = this.ptzLeftRight;
    data['support_modify_pwd'] = this.supportModifyPwd;
    data['support_capture'] = this.supportCapture;
    data['support_privacy'] = this.supportPrivacy;
    data['support_encrypt'] = this.supportEncrypt;
    data['support_auto_offline'] = this.supportAutoOffline;
    data['index'] = this.index;
    return data;
  }
}

class VideoQualityCapacity {
  String streamType;
  String videoLevel;
  String resolution;
  String videoBitRate;
  String maxBitRate;

  VideoQualityCapacity(
      {required this.streamType,
      required this.videoLevel,
      required this.resolution,
      required this.videoBitRate,
      required this.maxBitRate});

  VideoQualityCapacity.fromJson(Map<String, dynamic> json)
      : streamType = json['streamType'],
        videoLevel = json['videoLevel'],
        resolution = json['resolution'],
        videoBitRate = json['videoBitRate'],
        maxBitRate = json['maxBitRate'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streamType'] = this.streamType;
    data['videoLevel'] = this.videoLevel;
    data['resolution'] = this.resolution;
    data['videoBitRate'] = this.videoBitRate;
    data['maxBitRate'] = this.maxBitRate;
    return data;
  }
}



/*
{
    "support_cloud": "1",
    "support_intelligent_track": "1",
    "support_p2p_mode": "1",
    "support_resolution": "16-9",
    "support_talk": "1",
    "video_quality_capacity": [
        {
            "streamType": "1",
            "videoLevel": "0",
            "resolution": "1",
            "videoBitRate": "5",
            "maxBitRate": "0"
        },
        {
            "streamType": "1",
            "videoLevel": "1",
            "resolution": "3",
            "videoBitRate": "9",
            "maxBitRate": "0"
        }
    ],
    "support_wifi_userId": "1",
    "support_remote_auth_randcode": "1",
    "support_upgrade": "1",
    "support_smart_wifi": "1",
    "support_ssl": "1",
    "support_weixin": "1",
    "ptz_close_scene": "1",
    "support_preset_alarm": "1",
    "support_related_device": "0",
    "support_message": "0",
    "ptz_preset": "1",
    "support_wifi": "3",
    "support_cloud_version": "1",
    "ptz_center_mirror": "1",
    "support_defence": "1",
    "ptz_top_bottom": "1",
    "support_fullscreen_ptz": "1",
    "support_defenceplan": "1",
    "support_disk": "1",
    "support_alarm_voice": "1",
    "ptz_left_right": "1",
    "support_modify_pwd": "1",
    "support_capture": "1",
    "support_privacy": "1",
    "support_encrypt": "1",
    "support_auto_offline": "1",

    "index": 1 // 设备预置点
}
 */