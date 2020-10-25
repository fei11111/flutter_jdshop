import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color bgColor;
  final Function tap;
  final double height;
  final EdgeInsetsGeometry margin;
  final Color buttonColor;

  CustomButton(
      {Key key,
      this.bgColor = Colors.black,
      this.buttonText = "按钮",
      this.tap,
      this.height,
      this.margin,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
            height: height != null ? height : 68.h,
            margin: margin == null ? EdgeInsets.all(10.w) : margin,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: bgColor,
            ),
            child: Text(buttonText,
                style: TextStyle(
                    color: buttonColor == null ? Colors.white : buttonColor))),
        onTap: tap);
  }
}
