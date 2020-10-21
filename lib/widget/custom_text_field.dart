import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///自定义输入框
class CustomTextField extends StatelessWidget {
  final String text;
  final bool password;
  final ValueChanged<String> onChange;
  final BoxBorder border;
  final EdgeInsetsGeometry margin;
  final int maxLength;
  final TextInputType keyboardType;

  const CustomTextField(
      {Key key,
      this.text = "输入内容",
      this.password = false,
      this.onChange,
      this.border,
      this.margin,
      this.maxLength,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 68.h,
        width: double.infinity,
        margin: margin == null
            ? EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h)
            : margin,
        decoration: BoxDecoration(
            border: border == null
                ? Border(bottom: BorderSide(width: 1.w, color: Colors.black12))
                : border),
        child: TextField(
            maxLength: maxLength == null ? kMaxValue : maxLength,
            obscureText: password,
            keyboardType:
                keyboardType == null ? TextInputType.text : keyboardType,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                counterText: "", //此处控制最大字符是否显示
                hintText: text,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30))),
            onChanged: onChange));
  }
}
