import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ys7/flutter_ys7.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('MyButton was tapped!');
        // sdk只需要初始化一次
        await FlutterYs7.initSdk("AppKey");

        print('ys7 sdk init!');

        var result = await FlutterYs7.startVideo3(
            'at.a3wss7177mzw525va8454ztt9le43evi-8abzp1oham-1m38tuc-nna3csok0',
            'C24673046',
            'password'
        );
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
  const MyButton1({this.contentWidget, this.onTapAction, this.direction, Key key})
      : super(key: key);

  final Widget contentWidget;
  final Function onTapAction;
  final int direction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // print('MyButton was tapped!');
        if(onTapAction != null) {
          onTapAction('myButton was hello world');
        }

      },
      onTapDown: (tapDown) {
        print('MyButton was onTapDown!');
        var requestData = new YS7PtzRequestEntity(
          accessToken:
          'at.a3wss7177mzw525va8454ztt9le43evi-8abzp1oham-1m38tuc-nna3csok0',
          deviceSerial: "C24673046",
          channelNo: 1,
          direction: this.direction,
          speed: 1,
        );
        FlutterYs7.ptzStart(requestData);
      },
      onTapUp: (tapUp) {
        print('MyButton was onTapUp!');
        var requestData = new YS7PtzRequestEntity(
          accessToken:
          'at.a3wss7177mzw525va8454ztt9le43evi-8abzp1oham-1m38tuc-nna3csok0',
          deviceSerial: "C24673046",
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

class MyView extends StatelessWidget {
  const MyView({Key key}) : super(key: key);

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
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text('云台向下'),
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
