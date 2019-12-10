
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HttpTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('获取百度首页'),
              onPressed: _loading ? null : () async {
                setState(() {
                  _loading = true;
                  _text = "正在请求...";
                });
                try {
                  // 创建一个HttpClient
                  HttpClient httpClient = new HttpClient();
                  // 打开http连接
                  HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
                  // 使用iphone的UA
                  request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                  // 等待连接服务器
                  HttpClientResponse response = await request.close();
                  // 读取响应数据
                  _text = await response.transform(utf8.decoder).join();
                  // 关闭client后，所有通过client发起的请求都将会关闭
                  httpClient.close();
                } catch (e) {
                  _text = "请求失败：$e";
                } finally {
                  setState(() {
                    _loading = false;
                  });
                }
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(RegExp(r"\s"), "")),
            )
          ],
        ),
      ),
    );
  }
}