import 'package:flutter/material.dart';
import 'package:flutter_jdshop/page/address/address_add_page.dart';
import 'package:flutter_jdshop/page/address/address_edit_page.dart';
import 'package:flutter_jdshop/page/address/address_list_page.dart';
import 'package:flutter_jdshop/page/checkout/check_out_page.dart';
import 'package:flutter_jdshop/page/login_page.dart';
import 'package:flutter_jdshop/page/order/order_detail_page.dart';
import 'package:flutter_jdshop/page/order/order_page.dart';
import 'package:flutter_jdshop/page/pay_page.dart';
import 'package:flutter_jdshop/page/product_detail/product_detal_page.dart';
import 'package:flutter_jdshop/page/product_list_page.dart';
import 'package:flutter_jdshop/page/register/register_first_page.dart';
import 'package:flutter_jdshop/page/register/register_second_page.dart';
import 'package:flutter_jdshop/page/register/register_third_page.dart';

import '../page/search_page.dart';
import '../page/tabs_page.dart';

//配置路由
final routes = {
  ///首页
  '/': (context) => TabsPage(),

  ///搜索页面
  '/search': (context) => SearchPage(),

  ///商品列表页面
  '/productList': (context, {arguments}) =>
      ProductListPage(arguments: arguments),

  ///商品详情页面
  '/productDetail': (context, {arguments}) =>
      ProductDetailPage(arguments: arguments),

  ///登录
  '/login': (context) => LoginPage(),

  ///注册1
  '/registerFirst': (context) => RegisterFirstPage(),

  ///注册2
  '/registerSecond': (context, {arguments}) =>
      RegisterSecondPage(arguments: arguments),

  ///注册2
  '/registerThird': (context, {arguments}) =>
      RegisterThirdPage(arguments: arguments),

  ///结算
  '/checkOut': (context, {arguments}) => CheckOutPage(arguments: arguments),

  ///添加地址
  '/addressAdd': (context) => AddressAddPage(),

  ///编辑地址
  '/addressEdit': (context, {arguments}) =>
      AddressEditPage(arguments: arguments),

  ///地址列表
  '/addressList': (context) => AddressListPage(),

  ///支付页面
  '/pay': (context, {arguments}) => PayPage(arguments: arguments),

  ///订单界面
  '/order': (context, {arguments}) => OrderListPage(arguments: arguments),

  ///订单详情
  '/orderDetail': (context, {arguments}) =>
      OrderDetailPage(arguments: arguments)
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          settings: settings,
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
