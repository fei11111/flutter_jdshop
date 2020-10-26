import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImage extends StatefulWidget {
  final String url;
  final double w;
  final double h;
  final String defImagePath;

  CustomImage(
      {@required this.url,
      this.w,
      this.h,
      this.defImagePath = "images/default_pic.png"});

  @override
  State<StatefulWidget> createState() {
    return _CustomImageState();
  }
}

class _CustomImageState extends State<CustomImage> {
  Image _image;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _image = Image.network(
      widget.url,
      width: widget.w,
      height: widget.h,
      fit: BoxFit.cover,
    );
    var resolve = _image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
      //加载成功
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (dynamic exception, StackTrace stackTrace) {
      //加载失败
      setState(() {
        _image = Image.asset(
          widget.defImagePath,
          width: widget.w,
          height: widget.h,
        );
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: 50.h,
            width: 50.w,
            child: CircularProgressIndicator(
              strokeWidth: 1.w,
            ))
        : _image;
  }
}
