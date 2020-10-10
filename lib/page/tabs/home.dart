import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/focus_model.dart';
import 'package:flutter_jdshop/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<FocusItemModel> list = [];
  List<ProductItemModel> likeProductList = [];
  List<ProductItemModel> hotProductList = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getLikeProductList();
    _getHotProductList();
    debugPrint("home initState");
  }

  ///轮播图
  Widget _getSwipeWidget() {
    return list.length > 0
        ? Container(
            width: double.infinity,
            child: AspectRatio(
                aspectRatio: 2 / 1,
                child: Swiper(
                  itemCount: list.length,
                  autoplay: true,
                  itemBuilder: (context, index) {
                    String url = list[index].pic.replaceAll("\\", "/");
                    return Image.network("${Config.domain}$url",
                        fit: BoxFit.cover);
                  },
                  pagination: SwiperPagination(),
                )))
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
  Widget _getLikeProductListWidget() {
    return likeProductList.length > 0
        ? Container(
            height: 234.h,
            padding: EdgeInsets.all(20.w),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: likeProductList.length,
                itemBuilder: (context, index) {
                  var url = Config.domain +
                      likeProductList[index].pic.replaceAll("\\", "/");
                  ;
                  print(url);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Image.network("$url", fit: BoxFit.cover),
                          height: 140.h,
                          width: 140.w,
                          margin: EdgeInsets.only(right: 21.w, bottom: 10.w)),
                      Text(
                        "¥${likeProductList[index].price}",
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                }))
        : Text("");
  }

  ///热门推荐
  Widget _getHotProductWidget() {
    double halfScreen = ScreenUtil().screenWidth / 2.0;
    double width = halfScreen - 20.w;
    double height = width + 110.w;

    return hotProductList.length > 0
        ? Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: hotProductList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.w,
                    childAspectRatio: width / height),
                itemBuilder: (context, index) {
                  var url = Config.domain +
                      hotProductList[index].pic.replaceAll("\\", "/");
                  print("热门推荐$url");
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
                                  "$url",
                                  fit: BoxFit.fill,
                                ))),
                        Container(
                            height: 60.h,
                            child: Text(
                              "${hotProductList[index].title}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black54),
                            )),
                        SizedBox(height: 10.h),
                        Container(
                            height: 30.h,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "¥${hotProductList[index].price}",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16.0),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "¥${hotProductList[index].oldPrice}",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14.0,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                }))
        : Text("");
  }

  ///热门推荐
  // _recProductItemWidget() {
  //   var itemWidth = (ScreenUtil().screenWidth - 25.w) / 2;

  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     width: itemWidth,
  //     decoration: BoxDecoration(
  //         border:
  //             Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //           width: double.infinity,
  //           child: AspectRatio(
  //             //防止服务器返回的图片大小不一致导致高度不一致问题
  //             aspectRatio: 1 / 1,
  //             child: Image.network(
  //               "https://www.itying.com/images/flutter/list1.jpg",
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 20.h),
  //           child: Text(
  //             "2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码",
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(color: Colors.black54),
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 20.h),
  //           child: Stack(
  //             children: <Widget>[
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "¥188.0",
  //                   style: TextStyle(color: Colors.red, fontSize: 16),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.centerRight,
  //                 child: Text("¥198.0",
  //                     style: TextStyle(
  //                         color: Colors.black54,
  //                         fontSize: 14,
  //                         decoration: TextDecoration.lineThrough)),
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _getSwipeWidget(),
        SizedBox(height: 10.h),
        _getTitleWidget("猜你喜欢"),
        SizedBox(height: 10.h),
        _getLikeProductListWidget(),
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
    var result = await Dio().get("${Config.domain}api/focus");
    var fromJson = FocusModel.fromJson(result.data);
    setState(() {
      list = fromJson.result;
    });
  }

  void _getLikeProductList() async {
    var result = await Dio().get("${Config.domain}api/plist?is_hot=1");
    var fromJson = ProductModel.fromJson(result.data);
    setState(() {
      likeProductList = fromJson.result;
    });
  }

  void _getHotProductList() async {
    var result = await Dio().get("${Config.domain}api/plist?is_best=1");
    var fromJson = ProductModel.fromJson(result.data);
    setState(() {
      hotProductList = fromJson.result;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
