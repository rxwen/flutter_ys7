import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ys7/flutter_ys7.dart';
import 'package:flutter_ys7_example/HousePerson.dart';
import 'package:flutter_ys7_example/SCBScrollBar.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('MyButton was tapped!');
        // sdk只需要初始化一次
        await FlutterYs7.initSdk("appkey");

        print('ys7 sdk init!');

        var result = await FlutterYs7.startVideo3(
            'accesstoken',
            '序列号',
            'password');
        print(result);
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color.fromRGBO(24, 144, 255, 1), Color(0xFFffffff)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: const Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}

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
          accessToken:
              'accessToken',
          deviceSerial: "deviceSerial",
          channelNo: 1,
          direction: this.direction,
          speed: 1,
        );
        FlutterYs7.ptzStart(requestData);
      },
      onTapUp: (tapUp) {
        print('MyButton was onTapUp!');
        var requestData = new YS7PtzRequestEntity(
          accessToken: 'accessToken',
          deviceSerial: "deviceSerial",
          channelNo: 1,
          direction: this.direction,
          speed: 1,
        );
        FlutterYs7.ptzStop(requestData);
      },
      child: contentWidget,
    );
  }
}

class MyButton2 extends StatelessWidget {
  const MyButton2(
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
        children: [
          Text("hello world"),
          MyButton(),
          Container(
            height: 200,
            child: Ys7VideoView(),
          ),
          MyButton1(
            onTapAction: (str) {
              print('----$str----');
            },
            direction: 0,
            contentWidget: Container(
              height: 50.0,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
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
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text('云台向下'),
              ),
            ),
          ),
          MyButton2(
            direction: 1,
            onTapAction: (str) {
              var requestEntity = new YS7PtzRequestEntity();
              requestEntity.accessToken = '';
              requestEntity.deviceSerial = '';
              requestEntity.ipcSerial = '';
              // requestEntity.channelNo = 0;

              FlutterYs7.deviceIpcAdd(requestEntity);
            },
            contentWidget: Container(
              height: 50.0,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text('NVR绑定ipc'),
              ),
            ),
          ),
          MyButton2(
            direction: 1,
            onTapAction: (str) async {
              print('MyButton was tapped!');
              // sdk只需要初始化一次
              await FlutterYs7.initSdk("appkey");

              await FlutterYs7.setAccessToken("accesstoken");

              print('ys7 sdk init!');
              FlutterYs7.queryPlayback((data) {
                print("hello world");
              });
            },
            contentWidget: Container(
              height: 50.0,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text('查询回放'),
              ),
            ),
          ),
          MyButton2(
            direction: 1,
            onTapAction: (str) async {
              print('MyButton was tapped!');

              DatePicker.showDateTimePicker(context,
                  // 是否展示顶部操作按钮
                  showTitleActions: true,
                  // change事件
                  onChanged: (date) {
                    print('change $date');
                  },
                  // 确定事件
                  onConfirm: (DateTime date) async{
                    print('confirm $date');
                    // sdk只需要初始化一次
                    await FlutterYs7.initSdk("appkey");

                    await FlutterYs7.setAccessToken(
                        "setAccessToken");
                    // print('ys7 sdk init!');

                    // DateTime moonLanding = DateTime.parse();
                    var startTime = date.millisecondsSinceEpoch;
                    var endTime = date.millisecondsSinceEpoch + (1000 * 60 * 30);

                    // 'startTime':1630422000000,
                    // 'endTime':1630422010000,
                    // 'deviceSerial':'G19128980',
                    // 'verifyCode': 'VQXOBH',
                    // 'cameraNo': 1,
                    var videoRequest = new Ys7VideoRequestEntity();
                    // videoRequest.startTime = 1630422000000;
                    // videoRequest.endTime = 1630422010000;
                    videoRequest.startTime = startTime;
                    videoRequest.endTime = endTime;
                    videoRequest.deviceSerial = 'deviceSerial';
                    videoRequest.verifyCode = 'verifyCode';
                    videoRequest.cameraNo = 1;
                    FlutterYs7.playback(videoRequest);
                  },
                  // 当前时间
                  currentTime: DateTime.now(),
                  // 语言
                  locale: LocaleType.zh);
            },
            contentWidget: Container(
              height: 50.0,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text('选择回放日期时间'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: MyView()),
    ),
  );
}
