
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollControllerNotificationTextRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScrollControllerNotificationTextRouteState();
}

class _ScrollControllerNotificationTextRouteState extends State<ScrollControllerNotificationTextRoute> {
  String _progress = "0%"; //保存进度百分比
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false; //是否显示"返回到顶部"按钮

  @override
  void initState() {
    //监听滚动事件，打印滚动位置
    _controller.addListener((){
      print(_controller.offset); //打印滚动位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 100 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    //为了避免内存泄漏，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollControllerNotificationTextRoute'),
      ),
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          // ignore: missing_return
          onNotification: (ScrollNotification notification) {
            double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
            //重新构建
            setState(() {
              _progress = "${(progress * 100).toInt()}%";
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            //return true; //放开此行注释后，进度条将失效
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                  itemCount: 100,
                  itemExtent: 50.0,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('$index'));
                  }
              ),
              CircleAvatar( //显示进度百分比
                radius: 30.0,
                child: Text(_progress),
                backgroundColor: Colors.black54,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          //返回到顶部时执行动画
          _controller.animateTo(.0,
              duration: Duration(milliseconds: 200),
              curve: Curves.ease);
        },
      ),
    );
  }

}