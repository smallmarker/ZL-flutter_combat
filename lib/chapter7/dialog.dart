
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('对话框详解示例')),
        body: DialogTestRoute(),
      ),
    );
  }

}

class DialogTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogTestRouteState();
}

class _DialogTestRouteState extends State<DialogTestRoute> {

  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('您确定要删除当前文件吗？'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () => Navigator.of(context).pop(), //关闭对话框
              ),
              FlatButton(
                child: Text('删除'),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          );
        }
    );
  }

  Future<bool> showDeleteConfirmDialog2() {
    return showCustomDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('您确定要删除当前文件吗？'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () => Navigator.of(context).pop(), //关闭对话框
              ),
              FlatButton(
                child: Text('删除'),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          );
        }
    );
  }

  bool withTree = false; //复选框选中状态
  Future<bool> showDeleteConfirmDialog3() {
    withTree = false; //默认复选框不选中
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('您确定要删除当前文件吗？'),
              Row(
                children: <Widget>[
                  Text('同时删除子目录？'),
                  Builder(
                    builder: (BuildContext context) {
                      return Checkbox(
                        value: withTree,
                        onChanged: (bool value) {
                          (context as Element).markNeedsBuild();
                          withTree = !withTree;
                        },
                      );
                    },
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('删除'),
              onPressed: () => Navigator.of(context).pop(withTree),
            )
          ],
        );
      }
    );
  }

  Future<void> changeLanguage() async {
    int i = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text('中文简体'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 2),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text('美国英语'),
              ),
            )
          ],
        );
      }
    );

    if (i != null) {
      print('选择了: ${i == 1 ? '中文简体' : '美国英语'}');
    }
  }

  Future<void> showListDialog() async {
    int index = await showDialog(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text('请选择')),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('$index'),
                    onTap: () => Navigator.of(context).pop(index),
                  );
                },
              ),
            )
          ],
        );
        return Dialog(child: child);
      }
    );
    
    if (index != null) {
      print('点击了 $index');
    }
  }

  Future<T> showCustomDialog<T>({@required BuildContext context, bool barrierDismissible = true, WidgetBuilder builder,}) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context){
            return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut
      ),
      child: child,
    );
  }

  // 弹出底部菜单列表模态对话框
  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('$index'),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      }
    );
  }

  PersistentBottomSheetController<int> _showBottomSheet() {
    return showBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('$index'),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
          );
        }
    );
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Text('正在加载，请稍后...'),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(context: context, initialDate: date, firstDate: date, lastDate: date.add(Duration(days: 30)));
  }

  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              maximumDate: date.add(Duration(days: 30)),
              maximumYear: date.year + 1,
              onDateTimeChanged: (DateTime value) {
                print(value);
              },
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('AlertDialog'),
                onPressed: () async {
                  //弹出对话框并等待其关闭
                  bool delete = await showDeleteConfirmDialog1();
                  if (delete == null) {
                    print('取消删除');
                  } else {
                    print('已确认删除');
                  }
                },
              ),
              RaisedButton(
                child: Text('SimpleDialog'),
                onPressed: () async {
                  changeLanguage();
                },
              ),
              RaisedButton(
                child: Text('Dialog(ListView)'),
                onPressed: () async {
                  showListDialog();
                },
              ),
              RaisedButton(
                child: Text('CustomDialog'),
                onPressed: () async {
                  bool delete = await showDeleteConfirmDialog2();
                  if (delete == null) {
                    print('取消删除');
                  } else {
                    print('已确认删除');
                  }
                },
              ),
              RaisedButton(
                child: Text('AlertDialog(复选框可点击)'),
                onPressed: () async {
                  bool delete = await showDeleteConfirmDialog3();
                  if (delete == null) {
                    print('取消删除');
                  } else {
                    print('同时删除子目录: $delete');
                  }
                },
              ),
              RaisedButton(
                child: Text('ModalBottomSheet(底部菜单)'),
                onPressed: () async {
                  int type = await _showModalBottomSheet();
                  print(type);
                },
              ),
              RaisedButton(
                child: Text('BottomSheet(全屏的底部菜单)'),
                onPressed: () async {
                  _showBottomSheet();
                },
              ),
              RaisedButton(
                child: Text('Loading(加载框)'),
                onPressed: () => showLoadingDialog(),
              ),
              RaisedButton(
                child: Text('DatePicker(Material风格)'),
                onPressed: () => _showDatePicker1(),
              ),
              RaisedButton(
                child: Text('DatePicker(IOS风格)'),
                onPressed: () => _showDatePicker2(),
              )
            ],
          ),
        )
    );
  }
}