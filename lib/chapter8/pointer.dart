
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointerTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PointerTestRouteState();
}

class _PointerTestRouteState extends State<PointerTestRoute> {
  PointerEvent _event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PointerEvent(触摸事件)')),
      body: Center(
        child: Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 300.0,
            height: 150.0,
            child: Text(_event?.toString()??"", style: TextStyle(color: Colors.white)),
          ),
          onPointerDown: (PointerDownEvent event) => setState(() => _event=event),
          onPointerMove: (PointerMoveEvent event) => setState(() => _event=event),
          onPointerUp: (PointerUpEvent event) => setState(() => _event=event),
        ),
      ),
    );
  }

}