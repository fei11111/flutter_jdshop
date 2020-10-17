import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomTipDialog(
    BuildContext context,
    String title,
    String content,
    String cancelButtonStr,
    String confirmButtonStr,
    Function cancelFuction,
    Function confirmFunction) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Container(
              padding: EdgeInsets.all(10.w),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.red),
              child: Text(title, style: TextStyle(color: Colors.white))),
          content: Text(content),
          actions: [
            Container(
              width: 150.w,
              height: 60.h,
              decoration: BoxDecoration(color: Colors.red),
              child: FlatButton(
                  child: Text(cancelButtonStr,
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    cancelFuction();
                    Navigator.pop(context);
                  }),
            ),
            Container(
              width: 150.w,
              height: 60.h,
              decoration: BoxDecoration(color: Colors.white),
              child: OutlineButton(
                  child: Text(confirmButtonStr,
                      style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    confirmFunction();
                    Navigator.pop(context);
                  }),
            )
          ],
        );
      });
}
