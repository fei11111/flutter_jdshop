import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Container(
          height: 65.h,
          padding: EdgeInsets.only(left: 15.w),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30.w)),
          child: TextField(
            autofocus: false,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                hintText: "输入搜索关键字",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
          ),
        ),
        actions: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: InkWell(child: Text("搜索"), onTap: () {}))
        ],
      ),
      body: Text("搜索"),
    );
  }
}
