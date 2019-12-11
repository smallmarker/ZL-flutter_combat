import 'package:flutter/material.dart';

class RowColumnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          //测试Row对齐方式，排除Column默认居中对齐的干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(" hello world "),
                Text(" I am Jack "),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text(
                  " hello world ",
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(" I am Jack "),
              ],
            ),
          ],
        ),
        Expanded(
         child: Container(
           margin: EdgeInsets.only(top: 12.0),
           color: Colors.green,
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               mainAxisSize: MainAxisSize.max, //有效，外层Column高度为整个屏幕
               children: <Widget>[
                 Expanded(
                   child: Container(
                     color: Colors.red,
                     child: Column(
                       mainAxisSize: MainAxisSize.max, //无效，内层Column高度为实际高度
                       children: <Widget>[
                         Text("hello world "),
                         Text("I am Jack "),
                       ],
                     ),
                   ),
                 )
               ],
             ),
           ),
         ),
        )
      ],
    );
  }
}
