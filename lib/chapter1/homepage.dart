

import 'package:flutter/material.dart';

class HomePageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('images/book.jpg', width: 200, height: 300,),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('    本书由浅入深的介绍了Flutter技术和开发流程。本书包含不仅包含大量示例、图片，还有配套的示例源码，可帮助读者循序渐进的掌握Flutter开发技术。本书分为入门、进阶、实例三大篇，其中入门篇（第1章~第7章）主要介绍了Flutter技术产生的背景、常用的组件以及布局方式，通过入门篇的学习，读者可以掌握如何使用Flutter来构建UI界面。进阶篇（第8章~第14章），包括Flutter中的事件机制、动画、自定义组件、文件和网络、插件、国际化以及Flutter核心原理等。通过本章内容，读者可以对Flutter整体构建及原理有一个深入的认识。实例篇（第15章），本章主要通过一个简版的Github APP来将前面介绍的内容串起来，让开发者对一个完整的Flutter APP开发流有个了解。'),
        )
      ],
    );
  }
}