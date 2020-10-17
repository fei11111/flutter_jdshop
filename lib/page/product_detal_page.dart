import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/page/product_detail/product_detail_right_page.dart';
import 'package:flutter_jdshop/page/product_detail/product_detail_left_page.dart';
import 'package:flutter_jdshop/page/product_detail/product_detail_middle_page.dart';
import 'package:flutter_jdshop/page/tabs_page.dart';
import 'package:flutter_jdshop/providers/cart_providers.dart';
import 'package:flutter_jdshop/utils/event_bus.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

///商品详情页面
class ProductDetailPage extends StatefulWidget {
  final Map arguments;

  const ProductDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductDetailItemModel _itemModel;
  String _id;

  @override
  void initState() {
    super.initState();
    _getProductDetailData();
  }

  void _getProductDetailData() async {
    _id = widget.arguments['id'];
    String url = Config.getProductDetail(_id);
    debugPrint("商品详情URL:$url");
    var response = await Dio().get(url);
    var data = ProductDetailModel.fromJson(response.data);
    setState(() {
      _itemModel = data.result;
    });
  }

  ///头部切换按钮
  Widget _getAppBarWidget() {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      title: Container(
          // width: 300.w,
          child: TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [Tab(text: "商品"), Tab(text: "详情"), Tab(text: "评价")])),
      actions: [
        IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(ScreenUtil().screenWidth,
                      ScreenUtil().statusBarHeight + kToolbarHeight, 0, 0),
                  items: [
                    PopupMenuItem(
                        child: FlatButton(
                            child: Text("首页"),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => TabsPage()),
                                  (route) => route == null);
                            })),
                    PopupMenuItem(
                        child: FlatButton(
                            child: Text("搜索"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/search');
                            }))
                  ]);
            })
      ],
    );
  }

  ///底部购物车按钮
  Widget _getBottomWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 90.h,
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Color.fromRGBO(233, 233, 233, 0.8)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.shopping_cart), Text("购物车")]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton("加入购物车", Colors.red, () {
                  if (_itemModel.attr.length > 0) {
                    ///说明有款式可以选，弹出选择框，不然就直接提示加入购物车
                    eventBus.fire(ProductDetailEvent(
                        "加入购物车", ProductDetailType.ADD_CART));
                  } else {
                    Fluttertoast.showToast(
                      msg: '加入购物车成功',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                    context.read<CartProviders>().addCart(_itemModel);
                  }
                }),
                CustomButton("立即购买", Colors.yellow, () {
                  if (_itemModel.attr.length > 0) {
                    ///说明有款式可以选，弹出选择框，不然就直接提示加入购物车
                    eventBus.fire(
                        ProductDetailEvent("立即购买", ProductDetailType.MUST_BUY));
                  } else {}
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: _getAppBarWidget(),
            body: Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 90.h),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _itemModel == null
                            ? LoadingWidget()
                            : ProductDetailLeft(itemModel: _itemModel),
                        _id == null || _id.isEmpty
                            ? LoadingWidget()
                            : ProductDetailMiddle(arguments: {"id": _id}),
                        ProductDetailRight()
                      ],
                    )),
                _getBottomWidget()
              ],
            )));
  }
}
