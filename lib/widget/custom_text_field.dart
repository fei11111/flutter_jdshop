import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///自定义输入框
class CustomTextField extends StatelessWidget {
  final String text;
  final bool password;
  final ValueChanged<String> onChange;

  const CustomTextField(
      {Key key, this.text = "输入内容", this.password = false, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 68.h,
        width: double.infinity,
        margin: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.w, color: Colors.black12))),
        child: TextField(
            obscureText: password,
            decoration: InputDecoration(
                hintText: text,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30))),
            onChanged: onChange));
  }
}
