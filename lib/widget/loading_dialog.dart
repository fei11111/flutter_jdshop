import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

LoadingDialog loadingDialog = LoadingDialog();

class LoadingDialog {
  void show(BuildContext context) {
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

  void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}
