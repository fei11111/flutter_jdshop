import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/order_model.dart';
import 'package:flutter_jdshop/models/user_model.dart';
import 'package:flutter_jdshop/providers/user_providers.dart';
import 'package:flutter_jdshop/utils/sign_util.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';
import 'package:flutter_jdshop/widget/no_data_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///订单界面
class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<OrderItemModel> _alllist;
  List<OrderItemModel> _list;

  @override
  void initState() {
    super.initState();
    debugPrint("OrderPage initState");
    _tabController = TabController(length: 5, vsync: this);
    _getOrderList();
  }

  void _getOrderList() async {
    UserModel userModel = context.read<UserProvider>().userModel;
    String sign =
        SignUtil.getSign({'uid': userModel.id, 'salt': userModel.salt});
    String url = Config.getOrderList(userModel.id, sign);
    debugPrint("$url");
    var response = await Dio().get(Config.getOrderList(userModel.id, sign));
    var data = response.data;
    debugPrint("订单列表请求返回$data");
    if (data['success']) {
      var orderModel = OrderModel.fromJson(data);
      _alllist = orderModel.result;
      setState(() {
        _list = orderModel.result;
      });
    } else {
      toastShort(data['message']);
    }
  }

  void _filterList(int value) {
    _list = [];
    if (value == 0) {
      ///全部
      setState(() {
        _list = _alllist;
      });
    } else {
      _alllist.forEach((e) {
        if (e.orderStatus == value - 1) {
          _list.add(e);
        }
      });
      setState(() {
        _list = _list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("OrderPage build");
    return Scaffold(
        appBar: AppBar(
            title: Text("我的订单"),
            centerTitle: true,
            elevation: 0.0,
            bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "全部"),
                  Tab(text: "待付款"),
                  Tab(text: "待收货"),
                  Tab(text: "已完成"),
                  Tab(text: "已取消")
                ],
                onTap: (value) {
                  setState(() {
                    _list = null;
                  });
                  _filterList(value);
                })),
        body: _list == null
            ? LoadingWidget()
            : _list.length == 0
                ? NoDataWidget()
                : ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.all(15.w),
                              child: Column(children: [
                                Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(
                                                    233, 233, 233, 0.8)))),
                                    padding: EdgeInsets.only(
                                        top: 20.h,
                                        bottom: 20.h,
                                        left: 10.w,
                                        right: 10.w),
                                    child: Text("订单编号:${_list[index].id}")),
                                Column(children: _getOrderItem(index)),
                                Container(
                                    padding: EdgeInsets.all(15.w),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "合计:${_list[index].allPrice.toString()}"),
                                          CustomButton(
                                              buttonText: "申请售后",
                                              bgColor: Colors.black12,
                                              buttonColor: Colors.black45)
                                        ]))
                              ])),
                          onTap: () {
                            Navigator.pushNamed(context, '/orderDetail',
                                arguments: {'detail': _list[index]});
                          });
                    }));
  }

  ///订单item
  List<Widget> _getOrderItem(int index) {
    return _list[index].orderItem.map((e) {
      return Container(
          width: double.infinity,
          padding:
              EdgeInsets.only(top: 20.h, bottom: 20.h, left: 10.w, right: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 160.w,
                            height: 160.h,
                            margin: EdgeInsets.only(right: 15.w),
                            child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Image.network(
                                    "${Config.domain}${e.productImg.replaceAll("\\", "/")}",
                                    fit: BoxFit.cover))),
                        Expanded(
                            flex: 1,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.productTitle,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis),
                                  Text("￥${e.productPrice.toString()}",
                                      style: TextStyle(color: Colors.red))
                                ]))
                      ])),
              Text("x${e.productCount}")
            ],
          ));
    }).toList();
  }
}
