
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationRouteState();
}

class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}

class _NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + " ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                return RaisedButton(
                  child: Text('Send Notification'),
                  onPressed: () => MyNotification('Hi').dispatch(context),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}