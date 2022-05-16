import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ys7VideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (Platform.isIOS) {
      return Container(
        decoration: new BoxDecoration(
          color: Colors.black,
        ),
        child: UiKitView(viewType: "cspy/flutter_ys7/videoView"),
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'cspy/flutter_ys7/videoView',
        creationParamsCodec: StandardMessageCodec(),
      );
    } else {
      throw UnimplementedError();
    }
  }
}
