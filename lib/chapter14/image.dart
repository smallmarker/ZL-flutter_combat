
import 'package:flutter/material.dart';

class ImageInternalTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyImage(
          imageProvider: NetworkImage("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
        )
      ],
    );
  }
}

class MyImage extends StatefulWidget {
  
  final ImageProvider imageProvider;

  const MyImage({Key key, @required this.imageProvider}) : assert(imageProvider != null), super(key: key);
  @override
  State<StatefulWidget> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  ImageStream _imageStream;
  ImageInfo _imageInfo;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getImage();
  }

  @override
  void didUpdateWidget(MyImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != oldWidget.imageProvider)
      _getImage();
  }
  
  @override
  Widget build(BuildContext context) {
    return RawImage(
      image: _imageInfo?.image,
      scale: _imageInfo?.scale ?? 1.0,
    );
  }

  void _getImage() {
    final ImageStream oldImageStream = _imageStream;
    // 调用imageProvider.resolve方法，获得ImageStream。
    _imageStream = 
        widget.imageProvider.resolve(createLocalImageConfiguration(context));
    // 判断新旧ImageStream是否相同，如果不同，则需要调整流的监听器
    if (_imageStream.key != oldImageStream?.key) {
      final ImageStreamListener listener = ImageStreamListener(_updateImage);
      oldImageStream?.removeListener(listener);
      _imageStream.addListener(listener);
    }
  }

  void _updateImage(ImageInfo image, bool synchronousCall) {
    setState(() {
      _imageInfo = image;
    });
  }
  
  @override
  void dispose() {
    _imageStream.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }
}
