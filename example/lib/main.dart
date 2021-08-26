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
          )

        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
          body: MyView()
      ),
    ),
  );
}