
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_combat/chapter12/camera_example.dart';
import 'package:flutter_combat/chapter6/gridview.dart';
import 'package:flutter_combat/chapter6/listview.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

Widget child = Container();

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('《Flutter》实战练习'),
      ),
      body: child,
      drawer: rightDrawer(context),
    );
  }
}

Widget rightDrawer(BuildContext context) {
  void _openPage(PageInfo pageInfo) {
    if (pageInfo.isJumpPage) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(pageInfo.title)),
          body: pageInfo.child,
        );
      }));
    } else {
      child = pageInfo.child;
      (context as Element).markNeedsBuild();
      Navigator.of(context).pop();
    }
  }

  List<Widget> _generateItem(List<PageInfo> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        onTap: () => _openPage(page),
      );
    }).toList();
  }

  return Drawer(
    child: ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        ExpansionTile(
          title: Text('第一章：起步'),
        ),
        ExpansionTile(
          title: Text('第二章：第一个Flutter应用'),
          children: _generateItem([PageInfo('计数器示例', null)]),
        ),
        ExpansionTile(
          title: Text('第三章：基础组件'),
          children: _generateItem([
            PageInfo('文本、字体样式', null),
            PageInfo('按钮', null),
            PageInfo('图片和Icon', null),
            PageInfo('单选框和复选框', null),
            PageInfo('输入框和表单', null),
            PageInfo('进度指示器', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第四章：布局类组件'),
          children: _generateItem([
            PageInfo('线性布局（Row、Column）', null),
            PageInfo('弹性布局（Flex）', null),
            PageInfo('流式布局（Wrap、Flow）', null),
            PageInfo('层叠布局（Stack、Positioned）', null),
            PageInfo('对齐与相对定位（Align）', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第五章：容器类组件'),
          children: _generateItem([
            PageInfo('填充（Padding）', null),
            PageInfo('尺寸限制类容器（ConstrainedBox等）', null),
            PageInfo('装饰容器（DecoratedBox）', null),
            PageInfo('变换（Transform）', null),
            PageInfo('Container容器', null),
            PageInfo('Scaffold、TabBar、底部导航', null),
            PageInfo('剪裁（Clip）', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第六章：可滚动组件'),
          children: _generateItem([
            PageInfo('SingleChildScrollView', null),
            PageInfo('ListView', InfiniteListView()),
            PageInfo('GridView', InfiniteGridView()),
            PageInfo('CustomScrollView', null),
            PageInfo('滚动监听及控制（ScrollController）', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第七章：功能型组件'),
          children: _generateItem([
            PageInfo('导航返回拦截（WillPopScope）', null),
            PageInfo('数据共享（InheritedWidget）', null),
            PageInfo('跨组件状态共享（Provider）', null),
            PageInfo('颜色和主题（Theme）', null),
            PageInfo('异步UI更新（FutureBuilder、StreamBuilder）', null),
            PageInfo('对话框详解', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第八章：事件处理与通知'),
          children: _generateItem([
            PageInfo('原始指针事件处理', null),
            PageInfo('手势识别', null),
            PageInfo('通知（Notification）', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第九章：动画'),
          children: _generateItem([
            PageInfo('动画结构', null),
            PageInfo('Hero动画', null),
            PageInfo('交织动画', null),
            PageInfo('通用"切换动画"组件（AnimatedSwitcher）', null),
            PageInfo('动画过渡组件', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第十章：自定义组件'),
          children: _generateItem([
            PageInfo('组合现有组件', null),
            PageInfo('组合实例（TurnBox）', null),
            PageInfo('自绘组件（CustomPaint与Canvas）', null),
            PageInfo('自绘实例：圆形背景渐变进度条', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第十一章：文件操作与网络请求'),
          children: _generateItem([
            PageInfo('文件操作', null),
            PageInfo('Http请求-HttpClient', null),
            PageInfo('Http请求-Dio package', null),
            PageInfo('WebSocket', null)
          ]),
        ),
        ExpansionTile(
          title: Text('第十二章：包与插件'),
          children: _generateItem([
            PageInfo('插件开发：实现Android端API', null),
            PageInfo('Texture和PlatformView', null),
          ]),
        ),
        ExpansionTile(
          title: Text('第十三章：国际化'),
        ),
        ExpansionTile(
          title: Text('第十四章：Flutter核心原理'),
          children: _generateItem([
            PageInfo('Element和BuildContext', null),
            PageInfo('Flutter图片加载与缓存', null)
          ]),
        )
      ],
    ),
  );
}

class PageInfo{
  String title;
  Widget child;
  bool isJumpPage;
  PageInfo(this.title, this.child, {this.isJumpPage = false});
}
