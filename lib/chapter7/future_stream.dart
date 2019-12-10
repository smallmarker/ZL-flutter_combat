
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureAndStreamRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FutureAndStreamRouteState();
}

class _FutureAndStreamRouteState extends State<FutureAndStreamRoute> {

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Center(
              child: FutureBuilder<String>(
                future: mockNetworkData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // 请求成功，显示数据
                      return Text('Contents: ${snapshot.data}');
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
        ),
        Expanded(
            child: Center(
              child: StreamBuilder<int>(
                stream: counter(),
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('没有Stream');
                    case ConnectionState.waiting:
                      return Text('等待数据...');
                    case ConnectionState.active:
                      return Text('active: ${snapshot.data}');
                    case ConnectionState.done:
                      return Text('Stream已关闭');
                  }
                  return null;
                },
              ),
            )
        )
      ],
    );
  }

}