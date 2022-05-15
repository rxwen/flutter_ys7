class Ys7VideoRequestEntity {
  int startTime;
  int endTime;
  String deviceSerial;
  String verifyCode;
  int cameraNo;

  Ys7VideoRequestEntity(
      {required this.startTime,
      required this.endTime,
      required this.deviceSerial,
      required this.verifyCode,
      required this.cameraNo});

  Ys7VideoRequestEntity.fromJson(Map<String, dynamic> json)
      : startTime = json['startTime'],
        endTime = json['endTime'],
        deviceSerial = json['deviceSerial'],
        verifyCode = json['verifyCode'],
        cameraNo = json['cameraNo'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['deviceSerial'] = this.deviceSerial;
    data['verifyCode'] = this.verifyCode;
    data['cameraNo'] = this.cameraNo;
    return data;
  }
}
