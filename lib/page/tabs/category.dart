import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/cate_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  List<CateItemModel> leftList = [];
  List<CateItemModel> rightList = [];

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
    debugPrint("category initState");
  }

  Widget _getLeftCateWidget(double leftWidth) {
    return leftList.length > 0
        ? Container(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                        child: Text("${leftList[index].title}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: _currentIndex == index
                                    ? Colors.white
                                    : Colors.black54)),
                        color: _currentIndex == index
                            ? Colors.blueAccent
                            : Colors.white,
                      ),
                      onTap: () {
                        if (_currentIndex != index) {
                          _currentIndex = index;
                          _getRightCateData(_currentIndex);
                        }
                      },
                    ),
                    Divider(height: 5.h)
                  ],
                );
              },
              itemCount: leftList.length,
            ),
            width: leftWidth,
            height: double.infinity,
          )
        : Container(width: leftWidth, height: double.infinity);
  }

  Widget _getRightCateWidget(double itemWidth, double itemheight) {
    return rightList.length > 0
        ? Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: rightList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.w,
                      childAspectRatio: itemWidth / itemheight,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    CateItemModel model = rightList[index];
                    String url =
                        Config.domain + model.pic.replaceAll("\\", "/");
                    debugPrint("分类商品url:$url");
                    return Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(url, fit: BoxFit.cover),
                          ),
                          Container(
                            height: 30.h,
                            child: Text(model.title),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          )
        : Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              child: Text("加载中....", textAlign: TextAlign.center),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;
    double leftWidth = screenWidth / 4;
    double itemWidth = (screenWidth - leftWidth - 20.w - 20.w) / 3;
    double itemheight = itemWidth + 30.h;
    return Row(
      children: [
        _getLeftCateWidget(leftWidth),
        _getRightCateWidget(itemWidth, itemheight)
      ],
    );
  }

  ///获取左侧列表数据
  void _getLeftCateData() async {
    var result = await Dio().get("${Config.domain}api/pcate");
    var fromJson = CateModel.fromJson(result.data);
    setState(() {
      leftList = fromJson.result;
    });
    if (leftList.length > 0) {
      _getRightCateData(0);
    }
  }

  void _getRightCateData(int currentIndex) async {
    var result = await Dio()
        .get("${Config.domain}api/pcate?pid=${leftList[currentIndex].id}");
    var fromJson = CateModel.fromJson(result.data);
    setState(() {
      rightList = fromJson.result;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
