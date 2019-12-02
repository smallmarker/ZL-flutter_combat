
import 'package:flutter/material.dart';

class HeroAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeroAnimationRouteState();

}

class _HeroAnimationRouteState extends State<HeroAnimationRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero动画'),),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        alignment: Alignment.topCenter,
        child: InkWell(
          child: Hero(
            tag: "avatar",
            child: ClipOval(
              child: Image.asset("images/avatar.jpg", width: 50),
            ),
          ),
          onTap: () {
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Scaffold(
                  appBar: AppBar(title: Text('原图'),),
                  body: HeroAnimationRouteB(),
                );
              }
            ));
          },
        ),
      )
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar",
        child: Image.asset("images/avatar.jpg"),
      ),
    );
  }

}