import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/focus_model_entity.dart';
import 'package:flutter_jdshop/generated/json/base/json_convert_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FocusModelResult> list = [];

  Widget _getSwipeWidget() {
    return list.length > 0
        ? AspectRatio(
            aspectRatio: 2 / 1,
            child: Swiper(
              itemCount: list.length,
              autoplay: true,
              itemBuilder: (context, index) {
                String url = list[index].pic.replaceAll("\\", "/");
                return Image.network("http://jd.itying.com/$url",
                    fit: BoxFit.cover);
              },
              pagination: SwiperPagination(),
            ))
        : Text("加载中");
  }

  ///标题
  Widget _getTitleWidget(String title) {
    return Container(
      height: 32.h,
      margin: EdgeInsets.only(left: 20.w),
      padding: EdgeInsets.only(left: 20.w),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.red, width: 10.w))),
      child: Text(title, style: TextStyle(color: Colors.black54)),
    );
  }

  ///猜你喜欢
  Widget _getHotProductListWidget() {
    return Container(
        height: 234.h,
        padding: EdgeInsets.all(20.w),
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Image.network(
                          "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                          fit: BoxFit.cover),
                      height: 140.h,
                      width: 140.w,
                      margin: EdgeInsets.only(right: 21.w)),
                  Text("第${index}条")
                ],
              );
            }));
  }

  ///热门推荐
  Widget _getHotProductWidget() {
    return Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.w,
                childAspectRatio: 0.75),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        width: 1.0.w)),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              "https://www.itying.com/images/flutter/list1.jpg",
                              fit: BoxFit.cover,
                            ))),
                    Text(
                      "2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 10.w),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "¥198.0",
                            style: TextStyle(color: Colors.red, fontSize: 16.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "¥299.0",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                                decoration: TextDecoration.lineThrough),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }));
  }

  ///热门推荐
  _recProductItemWidget() {
    var itemWidth = (ScreenUtil().screenWidth - 25.w) / 2;

    return Container(
      padding: EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: AspectRatio(
              //防止服务器返回的图片大小不一致导致高度不一致问题
              aspectRatio: 1 / 1,
              child: Image.network(
                "https://www.itying.com/images/flutter/list1.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              "2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "¥188.0",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("¥198.0",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getFocusData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _getSwipeWidget(),
        SizedBox(height: 10.h),
        _getTitleWidget("猜你喜欢"),
        SizedBox(height: 10.h),
        _getHotProductListWidget(),
        SizedBox(height: 10.h),
        _getTitleWidget("热门推荐"),
        SizedBox(height: 10.h),
//        Wrap(
//          runSpacing: 10,
//          spacing: 10,
//          children: [
//            _recProductItemWidget(),
//            _recProductItemWidget(),
//            _recProductItemWidget(),
//            _recProductItemWidget(),
//            _recProductItemWidget(),
//            _recProductItemWidget()
//          ],
//        ),
        _getHotProductWidget()
      ],
    );
  }

  void _getFocusData() async {
    var result = await Dio().get("http://jd.itying.com/api/focus");
    var fromJson = FocusModelEntity().fromJson(result.data);
    print("xxxx");
    setState(() {
      list = fromJson.result;
    });
  }
}
