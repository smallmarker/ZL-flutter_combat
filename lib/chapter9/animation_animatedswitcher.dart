
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedSwitcherCounterRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return SlideTransitionX(
                child: child,
                direction: AxisDirection.up,
                position: animation,
              );
            },
            child: Text(
              '$_count',
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          RaisedButton(
            child: const Text('+1'),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          )
        ],
      ),
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({Key key, @required Animation<double> position, this.transformHitTests = true, this.child, this.direction = AxisDirection.down})
  : assert(position != null),
  super(key: key, listenable: position){
   switch (direction) {
     case AxisDirection.up:
       _tween = Tween(begin: Offset(0,1), end: Offset(0,0));
       break;
     case AxisDirection.right:
       _tween = Tween(begin: Offset(-1,0), end: Offset(0,0));
       break;
     case AxisDirection.down:
       _tween = Tween(begin: Offset(0,-1),end: Offset(0,0));
       break;
     case AxisDirection.left:
       _tween = Tween(begin: Offset(1,0), end: Offset(0,0));
       break;
   }
  }

  Animation<double> get position => listenable;
  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction;
  Tween<Offset> _tween;
  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}