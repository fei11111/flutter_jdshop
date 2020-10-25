import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/models/order_model.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/page/cart/cart_item_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///订单详情
class OrderDetailPage extends StatefulWidget {
  final Map arguments;

  const OrderDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  OrderItemModel _orderItemModel;

  @override
  void initState() {
    super.initState();
    debugPrint("OrderDetailPage initState");
    _orderItemModel = widget.arguments['detail'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("订单详情"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(children: [
          Padding(
              padding: EdgeInsets.only(bottom: 78.h),
              child: ListView(physics: BouncingScrollPhysics(), children: [
                _getAddressWidget(),
                _getProductItemWiget(),
                _getAllOtherWidget()
              ])),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 15.w),
                  height: 78.h,
                  alignment: Alignment.centerLeft,
                  child: RichText(
                      text: TextSpan(
                          text: "总金额 : ",
                          children: [
                            TextSpan(
                                text: "￥${_orderItemModel.allPrice}",
                                style: TextStyle(color: Colors.red))
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)))))
        ]));
  }

  ///地址
  Widget _getAddressWidget() {
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        color: Colors.white,
        child: ListTile(
            title: Text(_orderItemModel.name + "  " + _orderItemModel.phone),
            leading: Icon(Icons.location_on),
            subtitle: Text(_orderItemModel.address)));
  }

  ///商品列表
  Widget _getProductItemWiget() {
    return Column(
        children: _orderItemModel.orderItem.map((element) {
      ProductDetailItemModel model = ProductDetailItemModel(
        id: element.productId,
        price: element.productPrice,
        title: element.productTitle,
        pic: element.productImg,
        count: element.productCount,
        selectedAttr: element.selectedAttr,
      );
      return CartItemPage(model: model, isCheckOut: true);
    }).toList());
  }

  ///其它信息
  Widget _getOtherWiget(String key, String value) {
    return Container(
        padding: EdgeInsets.all(15.w),
        child: RichText(
            text: TextSpan(
                text: key,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "   $value",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 28.sp))
            ])));
  }

  ///所有其它信息
  Widget _getAllOtherWidget() {
    return Container(
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.all(10.w),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _getOtherWiget("订单编号 :", _orderItemModel.id),
          _getOtherWiget(
              "下单日期 :", _orderItemModel.orderItem[0].addTime.toString()),
          _getOtherWiget("支付方式 :", _orderItemModel.payStatus.toString()),
          _getOtherWiget("配送方式 :", "顺丰")
        ]));
  }
}
