
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterPluginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlutterPluginRouteState();
}

class _FlutterPluginRouteState extends State<FlutterPluginRoute> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = 'Unknown battery level';

  Future<Null> _getBatteryLevel() async {
    String  batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get battery level: "${e.message}".';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlutterPluginRoute'),),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text('Get Battery Level'),
                onPressed: _getBatteryLevel,
              ),
              Text(_batteryLevel)
            ],
          ),
        ),
      ),
    );
  }
}