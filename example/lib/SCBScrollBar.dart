import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef Widget ScrollBuilder();

class SCBScrollBar extends StatefulWidget {
  //  scrollview 如： listview 构造器
  final ScrollBuilder scrollBuilder;
  // 滑动条顶部距离
  final scrollBarTop;
  // 滑动条底部距离
  final scrollBarBottom;
  // 滑动条右边距离
  final scrollBarRight;
  // thumb高度
  final thumbHeight;
  // thumb宽度
  final thumbWidht;
  // 滑动条宽度
  final scrollBarWidth;
  //滑动停止是否隐藏
  final bool isHiddenWhenStoped;

  SCBScrollBar({
    Key key,
    @required this.scrollBuilder,
    this.scrollBarTop = 0.0,
    this.scrollBarBottom = 0.0,
    this.scrollBarRight = 0.0,
    this.thumbHeight = 50.0,
    this.scrollBarWidth = 4.0,
    this.thumbWidht = 6.0,
    this.isHiddenWhenStoped = true,
  }) : super(key: key);

  @override
  _SCBScrollBarState createState() => _SCBScrollBarState();
}

class _SCBScrollBarState extends State<SCBScrollBar> {
  double progress = 0;
  double apaph = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.isHiddenWhenStoped) {
      apaph = 0.0;
    } else {
      apaph = 1.0;
    }
  }

  double thumbTop(double maxHeight) {
    double thumbTopValue = widget.scrollBarTop +
        (maxHeight -
            widget.scrollBarTop -
            widget.scrollBarBottom -
            widget.thumbHeight) *
            progress;
    if (thumbTopValue + widget.thumbHeight >
        (maxHeight - widget.scrollBarBottom)) {
      thumbTopValue = maxHeight - widget.scrollBarBottom - widget.thumbHeight;
    }
    return thumbTopValue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            switch (notification.runtimeType) {
              case ScrollStartNotification:
                {
                  print("开始滚动");
                  setState(() {
                    apaph = 1.0;
                  });
                }
                break;
              case ScrollUpdateNotification:
                {
                  print("正在滚动");

                  double max = notification.metrics.maxScrollExtent;
                  double extentBefore = notification.metrics.extentBefore;
                  // double pixels = notification.metrics.pixels;
                  // print('pixels=$pixels  max=$max');
                  setState(() {
                    progress = extentBefore / max;
                  });
                }
                break;
              case ScrollEndNotification:
                {
                  print("滚动停止");
                  setState(() {
                    if (widget.isHiddenWhenStoped) {
                      apaph = 0.0;
                    } else {
                      apaph = 1.0;
                    }
                  });
                }
                break;
            }
            return true;
          },
          child: Stack(
            children: <Widget>[
              widget.scrollBuilder(),
              Positioned(
                right: widget.scrollBarRight,
                top: widget.scrollBarTop,
                bottom: widget.scrollBarBottom,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(widget.scrollBarWidth)),
                  child: AnimatedOpacity(
                    opacity: apaph,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: widget.scrollBarWidth,
                      color: Color(0xFFffffff),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: thumbTop(height),
                right: widget.scrollBarRight +
                    (widget.scrollBarWidth - widget.thumbWidht) / 2,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(widget.thumbHeight)),
                  child: AnimatedOpacity(
                    opacity: apaph,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: widget.thumbWidht,
                      height: widget.thumbHeight,
                      color: Color(0xFF1dc9ff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}