import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_combat/chapter12/camera_example.dart';
import 'package:flutter_combat/chapter14/image.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('《Flutter》实战练习'),
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {

  List<Widget> _generateItem(BuildContext context, List<PageInfo> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: Icon(Icons.keyboard_arrow_right),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          ExpansionTile(
            title: Text('第一章：起步'),
          ),
          ExpansionTile(
            title: Text('第二章：第一个Flutter应用'),
            children: _generateItem(context, [PageInfo('计数器示例')]),
          ),
          ExpansionTile(
            title: Text('第三章：基础组件'),
            children: _generateItem(context, [
              PageInfo('文本、字体样式'),
              PageInfo('按钮'),
              PageInfo('图片和Icon'),
              PageInfo('单选框和复选框'),
              PageInfo('输入框和表单'),
              PageInfo('进度指示器')
            ]),
          ),
          ExpansionTile(
            title: Text('第四章：布局类组件'),
            children: _generateItem(context, [
              PageInfo('线性布局（Row、Column）'),
              PageInfo('弹性布局（Flex）'),
              PageInfo('流式布局（Wrap、Flow）'),
              PageInfo('层叠布局（Stack、Positioned）'),
              PageInfo('对齐与相对定位（Align）')
            ]),
          ),
          ExpansionTile(
            title: Text('第五章：容器类组件'),
            children: _generateItem(context, [
              PageInfo('填充（Padding）'),
              PageInfo('尺寸限制类容器（ConstrainedBox等）'),
              PageInfo('装饰容器（DecoratedBox）'),
              PageInfo('变换（Transform）'),
              PageInfo('Container容器'),
              PageInfo('Scaffold、TabBar、底部导航'),
              PageInfo('剪裁（Clip）')
            ]),
          ),
          ExpansionTile(
            title: Text('第六章：可滚动组件'),
            children: _generateItem(context, [
              PageInfo('SingleChildScrollView'),
              PageInfo('ListView'),
              PageInfo('GridView'),
              PageInfo('CustokmScrollView'),
              PageInfo('滚动监听及控制（ScrollController）')
            ]),
          ),
          ExpansionTile(
            title: Text('第七章：功能型组件'),
            children: _generateItem(context, [
              PageInfo('导航返回拦截（WillPopScope）'),
              PageInfo('数据共享（InheritedWidget）'),
              PageInfo('跨组件状态共享（Provider）'),
              PageInfo('颜色和主题（Theme）'),
              PageInfo('异步UI更新（FutureBuilder、StreamBuilder）'),
              PageInfo('对话框详解')
            ]),
          ),
          ExpansionTile(
            title: Text('第八章：事件处理与通知'),
            children: _generateItem(context, [
              PageInfo('原始指针事件处理'),
              PageInfo('手势识别'),
              PageInfo('通知（Notification）')
            ]),
          ),
          ExpansionTile(
            title: Text('第九章：动画'),
            children: _generateItem(context, [
              PageInfo('动画结构'),
              PageInfo('Hero动画'),
              PageInfo('交织动画'),
              PageInfo('通用"切换动画"组件（AnimatedSwitcher）'),
              PageInfo('动画过渡组件')
            ]),
          ),
          ExpansionTile(
            title: Text('第十章：自定义组件'),
            children: _generateItem(context, [
              PageInfo('组合现有组件'),
              PageInfo('组合实例（TurnBox）'),
              PageInfo('自绘组件（CustomPaint与Canvas）'),
              PageInfo('自绘实例：圆形背景渐变进度条')
            ]),
          ),
          ExpansionTile(
            title: Text('第十一章：文件操作与网络请求'),
            children: _generateItem(context, [
              PageInfo('文件操作'),
              PageInfo('Http请求-HttpClient'),
              PageInfo('Http请求-Dio package'),
              PageInfo('WebSocket')
            ]),
          ),
          ExpansionTile(
            title: Text('第十二章：包与插件'),
            children: _generateItem(context, [
              PageInfo('插件开发：实现Android端API'),
              PageInfo('Texture和PlatformView'),
            ]),
          ),
          ExpansionTile(
            title: Text('第十三章：国际化'),
          ),
          ExpansionTile(
            title: Text('第十四章：Flutter核心原理'),
            children: _generateItem(context, [
              PageInfo('Element和BuildContext'),
              PageInfo('Flutter图片加载与缓存')
            ]),
          )
        ],
      ),
    );
  }
}

class PageInfo{
  String title;
  PageInfo(this.title);
}
