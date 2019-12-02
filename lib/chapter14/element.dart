
import 'package:flutter/material.dart';

class CustomHome extends Widget {
  @override
  Element createElement() {
    return HomeView(this);
  }
}

class HomeView extends ComponentElement {
  HomeView(Widget widget) : super(widget);
  String text = "123456789";

  @override
  Widget build() {
    Color primary = Theme.of(this).primaryColor;
    return Scaffold(
      appBar: AppBar(title: Text('Element'),),
      body: GestureDetector(
        child: Center(
          child: FlatButton(
            child: Text(text, style: TextStyle(color: primary),),
            onPressed: () {
              var t = text.split("")..shuffle();
              text = t.join();
              markNeedsBuild();
            },
          ),
        ),
      ),
    );
  }

}