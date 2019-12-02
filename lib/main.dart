import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_combat/chapter11/file_operation.dart';
import 'package:flutter_combat/chapter11/websocket.dart';
import 'package:flutter_combat/chapter12/camera_example.dart';
import 'package:flutter_combat/chapter12/flutter_plugin.dart';
import 'package:flutter_combat/chapter14/element.dart';

List<CameraDescription> cameras;

void main() async {
  // 获取可用摄像头列表， cameras为全局变量
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CustomHome(),
    );
  }
}
