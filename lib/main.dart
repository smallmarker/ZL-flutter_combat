import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_combat/chapter1/homepage.dart';
import 'package:flutter_combat/chapter10/custompaint.dart';
import 'package:flutter_combat/chapter10/gradient_circular_progress.dart';
import 'package:flutter_combat/chapter10/gradientbutton.dart';
import 'package:flutter_combat/chapter10/turnbox.dart';
import 'package:flutter_combat/chapter11/dio.dart';
import 'package:flutter_combat/chapter11/file_operation.dart';
import 'package:flutter_combat/chapter11/httpclient.dart';
import 'package:flutter_combat/chapter11/websocket.dart';
import 'package:flutter_combat/chapter12/camera_example.dart';
import 'package:flutter_combat/chapter12/flutter_plugin.dart';
import 'package:flutter_combat/chapter14/element.dart';
import 'package:flutter_combat/chapter14/image.dart';
import 'package:flutter_combat/chapter2/progress.dart';
import 'package:flutter_combat/chapter2/timer.dart';
import 'package:flutter_combat/chapter3/login_test.dart';
import 'package:flutter_combat/chapter4/align.dart';
import 'package:flutter_combat/chapter4/flex.dart';
import 'package:flutter_combat/chapter4/row_column.dart';
import 'package:flutter_combat/chapter4/stack_positioned.dart';
import 'package:flutter_combat/chapter4/wrap.dart';
import 'package:flutter_combat/chapter5/box.dart';
import 'package:flutter_combat/chapter5/clip.dart';
import 'package:flutter_combat/chapter5/container.dart';
import 'package:flutter_combat/chapter5/decoratebox.dart';
import 'package:flutter_combat/chapter5/padding.dart';
import 'package:flutter_combat/chapter5/scaffold.dart';
import 'package:flutter_combat/chapter5/transform.dart';
import 'package:flutter_combat/chapter6/customscrollview.dart';
import 'package:flutter_combat/chapter6/gridview.dart';
import 'package:flutter_combat/chapter6/listview.dart';
import 'package:flutter_combat/chapter6/scrollcontroller.dart';
import 'package:flutter_combat/chapter6/singlechildscrollview.dart';
import 'package:flutter_combat/chapter7/Inheritedwidget.dart';
import 'package:flutter_combat/chapter7/dialog.dart';
import 'package:flutter_combat/chapter7/future_stream.dart';
import 'package:flutter_combat/chapter7/provider.dart';
import 'package:flutter_combat/chapter7/theme.dart';
import 'package:flutter_combat/chapter7/willpopscope.dart';
import 'package:flutter_combat/chapter8/gesture.dart';
import 'package:flutter_combat/chapter8/notification.dart';
import 'package:flutter_combat/chapter8/pointer.dart';
import 'package:flutter_combat/chapter9/animation.dart';
import 'package:flutter_combat/chapter9/animation_animatedswitcher.dart';
import 'package:flutter_combat/chapter9/animation_hero.dart';
import 'package:flutter_combat/chapter9/animation_stagger.dart';
import 'package:flutter_combat/chapter9/animation_transition.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  PageInfo _pageInfo = PageInfo("《Flutter实战》练习", HomePageRoute());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pageInfo.title),
      ),
      body: _pageInfo.child,
      drawer: _drawer,
    );
  }

  void _openPage(PageInfo pageInfo) {
    if (pageInfo.isJumpPage) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return pageInfo.child;
      }));
    } else {
      _pageInfo = pageInfo;
      (context as Element).markNeedsBuild();
      Navigator.of(context).pop();
    }
  }

  List<Widget> _generateItem(List<PageInfo> children) =>
      children.map<Widget>((page) {
        return ListTile(
          title: Text(page.title),
          onTap: () => _openPage(page),
        );
      }).toList();

  get _drawer => Drawer(
        child: ListView(
          children: <Widget>[
            ExpansionTile(
              title: Text('第一章：起步'),
              children: _generateItem([PageInfo("简介", HomePageRoute())]),
            ),
            ExpansionTile(
              title: Text('第二章：第一个Flutter应用'),
              children: _generateItem([PageInfo('计数器示例', TimerRoute())]),
            ),
            ExpansionTile(
              title: Text('第三章：基础组件'),
              children: _generateItem([
                PageInfo('输入框和表单', LoginTestRoute()),
                PageInfo('进度指示器', ProgressRoute())
              ]),
            ),
            ExpansionTile(
              title: Text('第四章：布局类组件'),
              children: _generateItem([
                PageInfo('线性布局（Row、Column）', RowColumnRoute()),
                PageInfo('弹性布局（Flex）', FlexLayoutTestRoute()),
                PageInfo('流式布局（Wrap、Flow）', WrapTestRoute()),
                PageInfo('层叠布局（Stack、Positioned）', StackPositioned()),
                PageInfo('对齐与相对定位（Align）', AlignTestRoute())
              ]),
            ),
            ExpansionTile(
              title: Text('第五章：容器类组件'),
              children: _generateItem([
                PageInfo('填充（Padding）', PaddingTestRoute()),
                PageInfo('尺寸限制类容器（ConstrainedBox等）', BoxTestRoute()),
                PageInfo('装饰容器（DecoratedBox）', DecorateRoute()),
                PageInfo('变换（Transform）', TransformRoute()),
                PageInfo('Container容器', ContainerRoute()),
                PageInfo('Scaffold、TabBar、底部导航', ScaffoldRoute(),
                    isJumpPage: true),
                PageInfo('剪裁（Clip）', ClipTestRoute())
              ]),
            ),
            ExpansionTile(
              title: Text('第六章：可滚动组件'),
              children: _generateItem([
                PageInfo(
                    'SingleChildScrollView', SingleChildScrollViewTestRoute()),
                PageInfo('ListView', InfiniteListView()),
                PageInfo('GridView', InfiniteGridView()),
                PageInfo('CustomScrollView', CustomScrollViewTestRoute(),
                    isJumpPage: true),
                PageInfo('滚动监听及控制（ScrollController）',
                    ScrollControllerNotificationTextRoute(),
                    isJumpPage: true)
              ]),
            ),
            ExpansionTile(
              title: Text('第七章：功能型组件'),
              children: _generateItem([
                PageInfo('导航返回拦截（WillPopScope）', WillPopScopeTestRoute()),
                PageInfo('数据共享（InheritedWidget）', InheritedWidgetTestRoute()),
                PageInfo('跨组件状态共享（Provider）', ProviderRoute()),
                PageInfo('颜色和主题（Theme）', ThemeTestRoute(), isJumpPage: true),
                PageInfo('异步UI更新（FutureBuilder、StreamBuilder）',
                    FutureAndStreamRoute()),
                PageInfo('对话框详解', DialogTestRoute())
              ]),
            ),
            ExpansionTile(
              title: Text('第八章：事件处理与通知'),
              children: _generateItem([
                PageInfo('原始指针事件处理', PointerTestRoute()),
                PageInfo('手势识别', GestureDetectorTestRoute()),
                PageInfo('通知（Notification）', NotificationRoute())
              ]),
            ),
            ExpansionTile(
              title: Text('第九章：动画'),
              children: _generateItem([
                PageInfo('动画结构', ScaleAnimationRoute()),
                PageInfo('Hero动画', HeroAnimationRoute()),
                PageInfo('交织动画', StaggerRoute()),
                PageInfo('通用"切换动画"组件（AnimatedSwitcher）',
                    AnimatedSwitcherCounterRoute()),
                PageInfo('动画过渡组件', AnimatedWidgetsTest())
              ]),
            ),
            ExpansionTile(
              title: Text('第十章：自定义组件'),
              children: _generateItem([
                PageInfo('组合现有组件', GradientButtonRoute()),
                PageInfo('组合实例（TurnBox）', TurnBoxRoute()),
                PageInfo('自绘组件（CustomPaint与Canvas）', CustomPaintRoute()),
                PageInfo('自绘实例：圆形背景渐变进度条', GradientCircularProgressRoute())
              ]),
            ),
            ExpansionTile(
              title: Text('第十一章：文件操作与网络请求'),
              children: _generateItem([
                PageInfo('文件操作', FileOperationRoute()),
                PageInfo('Http请求-HttpClient', HttpTestRoute()),
                PageInfo('Http请求-Dio package', FutureBuilderRoute()),
                PageInfo('WebSocket', WebSocketRoute())
              ]),
            ),
            ExpansionTile(
              title: Text('第十二章：包与插件'),
              children: _generateItem([
                PageInfo('插件开发：实现Android端API', FlutterPluginRoute()),
                PageInfo('Texture和PlatformView', CameraExampleRoute()),
              ]),
            ),
            ExpansionTile(
              title: Text('第十三章：国际化'),
            ),
            ExpansionTile(
              title: Text('第十四章：Flutter核心原理'),
              children: _generateItem([
                PageInfo('Element和BuildContext', CustomHome()),
                PageInfo('Flutter图片加载与缓存', ImageInternalTestRoute())
              ]),
            )
          ],
        ),
      );
}

class PageInfo {
  String title;
  Widget child;
  bool isJumpPage;

  PageInfo(this.title, this.child, {this.isJumpPage = false});
}
