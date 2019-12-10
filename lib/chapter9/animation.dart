
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute> with SingleTickerProviderStateMixin{
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animation);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GrowTransition(animation: _animation, child: Image.asset("images/avatar.jpg"),)
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {

  final Widget child;
  final Animation<double> animation;

  const GrowTransition({Key key, this.animation, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          width: animation.value,
          height: animation.value,
          child: child,
        );
      },
      child: child,
    );
  }
}