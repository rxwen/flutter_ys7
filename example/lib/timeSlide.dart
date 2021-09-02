

import 'package:flutter/material.dart';

class TimeSlide extends StatefulWidget {
  final int selectIndex;// 外部传入默认选择第几个
  final Function slideAction; // 滚动停止的回调方法，给外部传选中的索引值
  bool clearData; // 支持清楚数据功能，true代表恢复默认样式
  TimeSlide({this.slideAction, this.selectIndex, this.clearData});
  @override
  _TimeSlideState createState() => _TimeSlideState();
}

class _TimeSlideState extends State<TimeSlide> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}