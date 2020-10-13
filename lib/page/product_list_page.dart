import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/product_model.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';
import 'package:flutter_jdshop/widget/no_data_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListPage extends StatefulWidget {
  final Map arguments;

  const ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;
  List _tabs = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
  ];
  List<ProductItemModel> _productList;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  ScrollController _scrollController;

  ///分页
  int _page = 1;

  ///每页有多少条数据
  int _pageSize = 8;
  /*
  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  */
  String _sort = "";

  ///是否有数据
  bool _hasMore = true;

  ///搜索关键字
  String _keyWords;

  ///防止重复请求
  bool _flag = true;

  @override
  void initState() {
    super.initState();
    _keyWords = widget.arguments["keyWords"];
    _tabController = TabController(length: 3, vsync: this);
    _requestProductData();
    _initListener();
  }

  ///初始化监听
  void _initListener() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (_hasMore && _flag) {
          _requestProductData();
        }
      }
    });
  }

  ///商品列表数据
  void _requestProductData() async {
    setState(() {
      _flag = false;
    });

    String url;
    if (_keyWords == null) {
      url = Config.getProductList(
          widget.arguments['cid'], _page, _sort, _pageSize);
    } else {
      url = Config.getProductListByKeyWords(_keyWords, _page, _sort, _pageSize);
    }
    debugPrint("商品列表url:$url");
    var response = await Dio().get(url);
    var result = ProductModel.fromJson(response.data);

    if (result.result.length < _pageSize) {
      _hasMore = false;
    } else {
      _page++;
      _hasMore = true;
    }

    setState(() {
      _hasMore = _hasMore;
      _page = _page;
      _flag = true;
      if (_productList == null) {
        _productList = [];
      }
      _productList.addAll(result.result);
    });
  }

  ///商品列表
  Widget _getProductListWidget() {
    debugPrint("商品列表");
    return _productList == null
        ? LoadingWidget()
        : _productList.length > 0
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: _productList.length,
                itemBuilder: (context, index) {
                  ProductItemModel model = _productList[index];
                  String imageUrl =
                      Config.domain + model.pic.replaceAll("\\", "/");
                  debugPrint(imageUrl);
                  return Column(
                    children: [
                      InkWell(
                          child: Padding(
                              padding: EdgeInsets.all(20.w),
                              child: Row(
                                children: [
                                  Container(
                                    width: 180.w,
                                    height: 180.h,
                                    child: Image.network(imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 180.h,
                                        margin: EdgeInsets.only(left: 20.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(model.title,
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            Row(
                                              children: [
                                                Chip(
                                                    label: Text("WIFI",
                                                        style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))),
                                                SizedBox(width: 10.w),
                                                Chip(
                                                    label: Text("128g",
                                                        style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)))
                                              ],
                                            ),
                                            Text(
                                              "¥${model.price}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 30.sp),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              )),
                          onTap: () {
                            Navigator.pushNamed(context, "/productDetail",
                                arguments: {"id": model.id});
                          }),
                      _getBottomWidget(index)
                    ],
                  );
                })
            : NoDataWidget();
  }

  ///底部loading
  Widget _getBottomWidget(int index) {
    if (_hasMore) {
      return index == _productList.length - 1
          ? LoadingWidget()
          : Divider(
              height: 5.w,
            );
    } else {
      return index == _productList.length - 1
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    height: 1.w,
                    decoration: BoxDecoration(color: Colors.black54),
                  )),
              Text("我是有底线的"),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w),
                    height: 1.w,
                    decoration: BoxDecoration(color: Colors.black54),
                  ))
            ])
          : Divider(
              height: 5.w,
            );
    }
  }

  ///头部item
  List<Widget> _getSubHeaderItemWidget() {
    List<Widget> widgets = [];
    for (int i = 0; i < _tabs.length; i++) {
      widgets.add(Expanded(
          flex: 1,
          child: InkWell(
              onTap: () {
                _headTap(i);
              },
              child: Container(
                  height: 80.h,
                  alignment: Alignment.center,
                  decoration: _currentIndex == i
                      ? BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.red, width: 1.w)))
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_tabs[i]["title"],
                          style: TextStyle(
                              color: _currentIndex == i
                                  ? Colors.red
                                  : Colors.black54),
                          textAlign: TextAlign.center),
                      i != 0
                          ? Icon(_tabs[i]["sort"] == 1
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down)
                          : Text("")
                    ],
                  )))));
    }
    return widgets;
  }

  ///头部点击
  void _headTap(int index) {
    setState(() {
      if (_currentIndex == index) {
        _tabs[_currentIndex]["sort"] = _tabs[_currentIndex]["sort"] * (-1);
      }
      _currentIndex = index;
    });
    _sort = "${_tabs[_currentIndex]["fileds"]}_${_tabs[_currentIndex]["sort"]}";
    _page = 1;
    _productList = [];
    _hasMore = true;
    _scrollController.jumpTo(0);
    _requestProductData();
  }

  ///头部
  PreferredSizeWidget _getSubHeaderWidget() {
    return PreferredSize(
        preferredSize: Size(ScreenUtil().screenWidth, 80.h),
        child: Container(
            height: 80.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        width: 1.w,
                        color: Color.fromRGBO(233, 233, 233, 0.9)))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getSubHeaderItemWidget())));
  }

  ///侧边栏
  Widget _getRightDrawerWidget() {
    return Drawer(
        child: Column(
      children: [DrawerHeader(child: Text("侧边栏"))],
    ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
        key: _key,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          leading: BackButton(),
          title: Text('商品列表'),
          bottom: _getSubHeaderWidget(),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: IconButton(
                    icon: Icon(Icons.select_all),
                    onPressed: () {
                      _key.currentState.openEndDrawer();
                    }))
          ],
        ),
        body: _getProductListWidget(),
        endDrawer: _getRightDrawerWidget());
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
