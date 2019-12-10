import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GestureDetectorTestRouteState();
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('点击、双击、长按'),
          onPressed: () => _showGestureDetector(),
        ),
        RaisedButton(
          child: Text('拖动、滑动'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return _Drag();
              }
            ));
          },
        ),
        RaisedButton(
          child: Text('单一方向拖动'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return _DragVertical();
                }
              )
            );
          },
        ),
        RaisedButton(
          child: Text('缩放'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return _ScaleTestRoute();
              }
            ));
          },
        ),
        RaisedButton(
          child: Text('富文本点击变色'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return _GestureRecognizerRoute();
              }
            ));
          },
        )
      ],
    ));
  }

  PersistentBottomSheetController<int> _showGestureDetector() {
    String _operation = 'No Gesture detector'; // 保存事件名
    return showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 200.0,
                height: 100.0,
                child: Text(_operation, style: TextStyle(color: Colors.white)),
              ),
              onTap: () {
                (context as Element).markNeedsBuild();
                _operation = 'Tap';
              }, // 单击
              onDoubleTap: () {
                (context as Element).markNeedsBuild();
                _operation = 'DoubleTap';
              }, // 双击
              onLongPress: () {
                (context as Element).markNeedsBuild();
                _operation = 'LongPress';
              }, // 长按
            ),
          );
        });
  }
}

class _Drag extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DragState();
}

class _DragState extends State<_Drag> {
  double _top = 0.0;
  double _left = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('拖动（任意方向）'),),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text('A'),),
              onPanDown: (DragDownDetails e) {
                print("手指按下: ${e.globalPosition}");
              },
              onPanUpdate: (DragUpdateDetails e) {
                setState(() {
                  _top += e.delta.dy;
                  _left += e.delta.dx;
                });
              },
              onPanEnd: (DragEndDetails e) {
                print(e.velocity);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ScaleTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaleTestRouteState();
}

class _ScaleTestRouteState extends State<_ScaleTestRoute> {
  double _width = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('缩放'),),
      body: Center(
        child: GestureDetector(
          child: Image.asset("./images/avatar.jpg", width: _width,),
          onScaleUpdate: (ScaleUpdateDetails e) {
            setState(() {
              _width = 200 * e.scale.clamp(.8, 10.0);
            });
          },
        ),
      ),
    );
  }
}

class _GestureRecognizerRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GestureRecognizerRouteState();
}

class _GestureRecognizerRouteState extends State<_GestureRecognizerRoute> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('富文本点击变色'),),
      body: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "你好，世界"),
              TextSpan(text: "点我变色", style: TextStyle(fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
              recognizer: _tapGestureRecognizer..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              }),
              TextSpan(text: "你好，世界")
            ]
          )
        ),
      ),
    );
  }
}

class _DragVertical extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('单一方向拖动'),),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(child: Text('A'),),
              onVerticalDragUpdate: (DragUpdateDetails e) {
                setState(() {
                  _top += e.delta.dy;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
