import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(children: [
              CircularProgressIndicator(
                strokeWidth: 1.w,
              ),
              SizedBox(height: 20.h),
              Text("加载中....", style: TextStyle(fontSize: 20.sp))
            ])));
  }
}
