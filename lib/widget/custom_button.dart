import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String _buttonText;
  final Color _buttonColor;
  final Function _tap;

  const CustomButton(this._buttonText, this._buttonColor, this._tap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
            height: 68.h,
            margin: EdgeInsets.all(10.w),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: 30.w, right: 30.w, top: 10.h, bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: _buttonColor,
            ),
            child: Text(_buttonText, style: TextStyle(color: Colors.white))),
        onTap: _tap);
  }
}
