import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.w),
        child: Center(child: Text("没有数据", style: TextStyle(fontSize: 30.sp))));
  }
}
