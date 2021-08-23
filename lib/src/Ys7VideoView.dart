

import 'dart:io';

import 'package:flutter/cupertino.dart';

class Ys7VideoView extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(Platform.isIOS) {
      return UiKitView(viewType: "cspy/flutter_ys7/videoView");
    } else if (Platform.isAndroid) {
      return Text('android text');
    } else {
      throw UnimplementedError();
    }

  }

}