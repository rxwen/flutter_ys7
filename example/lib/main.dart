import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ys7/flutter_ys7.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// 萤石云参数
String appKey = 'fe83f39646a04fb5ba3688379742fda5';
String accessToken = 'at.0mos6obv9ynnkniz4swy9ds76blj6ibj-5mmjrl3hju-1iv94zx-payznovek';
String deviceSerial = 'G19128980';
String verifyCode = 'VQXOBH';
int cameraNo = 1;

class MyButton1 extends StatelessWidget {
  const MyButton1(
      {this.contentWidget, this.onTapAction, this.direction, Key key})
      : super(key: key);

  final Widget contentWidget;
  final Function onTapAction;
  final int direction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // print('MyButton was tapped!');
        if (onTapAction != null) {
          onTapAction('myButton was hello world');
        }
      },
      onTapDown: (tapDown) {
        print('MyButton was onTapDown!');
        var requestData = new YS7PtzRequestEntity(
          accessToken: accessToken,
          deviceSerial: deviceSerial,
          channelNo: cameraNo,
          direction: this.direction,
          speed: 1,
        );
        FlutterYs7.ptzStart(requestData).then((res){
          print("onTapDown $res");
        });
      },
      onTapUp: (tapUp) {
        print('MyButton was onTapUp!');
        var requestData = new YS7PtzRequestEntity(
          accessToken: accessToken,
          deviceSerial: deviceSerial,
          channelNo: cameraNo,
          direction: this.direction,
          speed: 1,
        );
        FlutterYs7.ptzStop(requestData).then((res){
          print("onTapUp $res");
        });
      },
      child: contentWidget,
    );
  }
}

class MyButton2 extends StatelessWidget {
  const MyButton2({this.contentWidget,
    this.onTapAction,
    Key key,
    this.onTapDown,
    this.onTapUp})
      : super(key: key);

  final Widget contentWidget;
  final Function onTapAction;
  final Function onTapDown;
  final Function onTapUp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // print('MyButton was tapped!');
        if (onTapAction != null) {
          onTapAction('myButton was hello world');
        }
      },
      onTapDown: (tapDown) {
        if (onTapDown != null) {
          onTapDown(tapDown);
        }
      },
      onTapUp: (tapUp) {
        if (onTapUp != null) {
          onTapUp(tapUp);
        }
      },
      child: contentWidget,
    );
  }
}

class MyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyViewState();
  }

  void rowTap(int index) {}

  const MyView();
}

class _MyViewState extends State<MyView> {


  //
  String backTime = 'xx';
  int backTimeTmp = 0;
  Timer startPlayTime;
  Timer timeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
        children: [
          Container(
            height: 200,
            child: Ys7VideoView(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyButton2(
                onTapAction: (str) {
                  FlutterYs7.initSdk(appKey);
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('INIT SDK'),
                  ),
                ),
              ),
              MyButton2(
                onTapAction: (str) {
                  FlutterYs7.setAccessToken(accessToken);
                  FlutterYs7.initEZPlayer(deviceSerial, verifyCode, cameraNo);
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('初始化播放器'),
                  ),
                ),
              ),
              MyButton2(
                onTapAction: (str) {
                  FlutterYs7.startRealPlay();
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('开始直播'),
                  ),
                ),
              ),
              MyButton2(
                onTapAction: (str) {
                  FlutterYs7.stopRealPlay();
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('停止直播'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              MyButton1(
                direction: 0,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('云台向上'),
                  ),
                ),
              ),
              MyButton1(
                direction: 1,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('云台向下'),
                  ),
                ),
              ),
              MyButton1(
                direction: 2,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('云台向左'),
                  ),
                ),
              ),
              MyButton1(
                direction: 3,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('云台向右'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              MyButton1(
                direction: 8,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('放大'),
                  ),
                ),
              ),
              MyButton1(
                direction: 9,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('缩小'),
                  ),
                ),
              ),
              MyButton1(
                direction: 10,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('近焦距'),
                  ),
                ),
              ),
              MyButton1(
                direction: 11,
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('远焦距'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              MyButton2(
                onTapAction: (str) async {
                  var request = new Ys7VideoRequestEntity();
                  request.cameraNo = 1;
                  request.deviceSerial = deviceSerial;
                  request.verifyCode = verifyCode;
                  request.startTime = 1630368000000;
                  request.endTime = 1630425600000;

                  FlutterYs7.queryPlayback(request,(data) {
                    print("hello world");
                  });
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('查询回放'),
                  ),
                ),
              ),
              MyButton2(
                onTapAction: (str) async {
                  print('MyButton was tapped!');

                  DatePicker.showDateTimePicker(context,
                      // 是否展示顶部操作按钮
                      showTitleActions: true,
                      onChanged: (date) {
                        // change事件
                        print('change $date');
                      },
                      onConfirm: (DateTime date) async {
                        // 确定事件
                        print('confirm $date');
                        setState(() {
                          backTime = date.toString().substring(0, 19);
                        });
                      },
                      // 当前时间
                      currentTime: DateTime.now(),
                      // 语言
                      locale: LocaleType.zh);
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('选择回放日期时间'),
                  ),
                ),
              ),
              Text(backTime)
            ],
          ),
          Row(
            children: [
              MyButton2(
                onTapAction: (str) async {
                  DateTime date = DateTime.parse(backTime);
                  var startTime = date.millisecondsSinceEpoch;
                  var endTime =
                      date.millisecondsSinceEpoch + (1000 * 60 * 30);

                  var videoRequest = new Ys7VideoRequestEntity();
                  // videoRequest.startTime = 1630422000000;
                  // videoRequest.endTime = 1630422010000;
                  videoRequest.startTime = startTime;
                  videoRequest.endTime = endTime;
                  FlutterYs7.startPlayback(videoRequest);
                  getplayBackTime();
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('开始回放'),
                  ),
                ),
              ),
              MyButton2(
                onTapAction: (str) async {
                  await FlutterYs7.stopPlayback();
                  if (startPlayTime != null) {
                    startPlayTime.cancel();
                  }
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('停止回放'),
                  ),
                ),
              ),
              MyButton2(
                onTapDown: (tapDown)async{
                  startPlayTime.cancel();
                  backTimeTmp = DateTime.parse(backTime).millisecondsSinceEpoch;
                  print('当前时间 = $backTimeTmp');

                  if (timeId != null) timeId.cancel();
                  timeId = Timer.periodic(const Duration(milliseconds: 100),
                          (timer) {
                        backTimeTmp -= 15000;
                        setState(() {
                          backTime =
                              DateTime.fromMillisecondsSinceEpoch(backTimeTmp)
                                  .toString()
                                  .substring(0, 19);
                        });
                      });
                },
                onTapUp: (tapUp)async{
                  if (timeId != null) {
                    timeId.cancel();
                  }
                  print('当前时间 = $backTimeTmp');

                  await FlutterYs7.stopPlayback();

                  var request = new Ys7VideoRequestEntity();
                  request.startTime = backTimeTmp;
                  request.endTime = request.startTime + (1000 * 60 * 30);
                  FlutterYs7.startPlayback(request);
                  getplayBackTime();
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('快退'),
                  ),
                ),
              ),
              MyButton2(
                onTapDown: (tapDown) {
                  startPlayTime.cancel();
                  backTimeTmp = DateTime
                      .parse(backTime)
                      .millisecondsSinceEpoch;
                  print('当前时间 = $backTimeTmp');

                  if (timeId != null) timeId.cancel();
                  timeId = Timer.periodic(const Duration(milliseconds: 100),
                          (timer) {
                        backTimeTmp += 15000;
                        setState(() {
                          backTime =
                              DateTime.fromMillisecondsSinceEpoch(backTimeTmp)
                                  .toString()
                                  .substring(0, 19);
                        });
                      });
                },
                onTapUp: (tapUp) async {
                  if (timeId != null) {
                    timeId.cancel();
                  }
                  print('当前时间 = $backTimeTmp');

                  await FlutterYs7.stopPlayback();

                  var request = new Ys7VideoRequestEntity();
                  request.startTime = backTimeTmp;
                  request.endTime = request.startTime + (1000 * 60 * 30);
                  FlutterYs7.startPlayback(request);
                  getplayBackTime();
                },
                contentWidget: Container(
                  height: 50.0,
                  padding: const EdgeInsets.all(8.0),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: const Center(
                    child: Text('快进'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void getplayBackTime() {
    if(Platform.isIOS){
      return;
    }
    if (startPlayTime != null) {
      startPlayTime.cancel();
    }
    startPlayTime = Timer.periodic(const Duration(seconds: 1), (timer) async {
      int playTime = await FlutterYs7.getOSDTime();
      var date = DateTime.fromMillisecondsSinceEpoch(playTime);
      setState(() {
        backTime = date.toString().substring(0, 19);
      });
    });
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: MyView()),
    ),
  );
}
