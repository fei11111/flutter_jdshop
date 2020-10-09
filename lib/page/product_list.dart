import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(title: Text('商品列表')),
      body: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              Container(
                width: 180.w,
                height: 180.h,
                child: Image.network(
                    "https://www.itying.com/images/flutter/list2.jpg",
                    fit: BoxFit.cover),
              )
            ],
          )),
    );
  }
}
