import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.zero,
          children: [
            Center(child: CircularProgressIndicator()),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15.h),
                child: Text("加载中..."))
          ],
        );
      });
}

void closeDialog(BuildContext context) {
  Navigator.pop(context);
}
