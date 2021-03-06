
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButtonRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            child: Text('Submit'),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50.0,
            colors: [Colors.lightGreen, Colors.green[700]],
            child: Text('Submit'),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50,
            colors: [Colors.lightBlue[300], Colors.blueAccent],
            child: Text('Submit'),
            onPressed: onTap,
          )
        ],
      ),
    );
  }
  onTap() {
    print('Button Click');
  }
}

class GradientButton extends StatelessWidget {

  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  // 点击回调
  final GestureTapCallback onPressed;

  const GradientButton({Key key, this.colors, this.width, this.height, this.borderRadius, this.onPressed, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors = colors ?? [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    return DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: _colors),
            borderRadius: borderRadius
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: _colors.last,
            highlightColor: Colors.transparent,
            borderRadius: borderRadius,
            onTap: onPressed,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: height, width: width),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultTextStyle(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}