import 'package:flutter/material.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/page/cart/cart_item_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///结算界面
class CheckOutPage extends StatefulWidget {
  final Map arguments;

  const CheckOutPage({Key key, this.arguments}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List<ProductDetailItemModel> _list;
  double _totalPrice = 0; //总价
  double _discount = 15.0; //折扣
  double _postage = 0; //邮费

  @override
  void initState() {
    super.initState();
    _list = widget.arguments["list"];
    debugPrint("CheckOutPage initState 商品数量${_list.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0.0, centerTitle: true, title: Text("订单页面")),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 78.h),
                child: ListView(physics: BouncingScrollPhysics(), children: [
                  _getAddressWidget(),
                  _getProductListWidget(),
                  _getOtherPrice()
                ])),
            Align(alignment: Alignment.bottomCenter, child: _getBalanceWidget())
          ],
        ));
  }

  /// 其他价格收费
  Widget _getOtherPrice() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20.w, top: 20.h),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("商品总金额:￥$_totalPrice"),
              Divider(),
              Text("立减:￥$_discount"),
              Divider(),
              Text("运费:￥0")
            ]));
  }

  ///收货地址
  Widget _getAddressWidget() {
    return Container(
        height: 80.h,
        alignment: Alignment.center,
        child: InkWell(
            child: Text("添加收货地址"),
            onTap: () {
              Navigator.pushNamed(context, '/addressList');
            }));
  }

  ///商品列表
  Widget _getProductListWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _list.map((e) {
          _totalPrice += e.count * double.parse(e.price);
          return CartItemPage(model: e, isCheckOut: true);
        }).toList());
  }

  Widget _getBalanceWidget() {
    return Container(
        width: double.infinity,
        height: 78.h,
        padding: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1.w, color: Colors.black12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("实付款￥${_totalPrice - _discount - _postage}"),
            InkWell(
                onTap: () {
                  debugPrint("结算");
                },
                child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    decoration: BoxDecoration(color: Colors.red),
                    padding: EdgeInsets.fromLTRB(45.w, 10.h, 45.w, 10.h),
                    child: Text("结算", style: TextStyle(color: Colors.white))))
          ],
        ));
  }
}
