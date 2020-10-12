import 'package:flutter/material.dart';
import 'package:flutter_jdshop/page/product_detal_page.dart';
import 'package:flutter_jdshop/page/product_list_page.dart';
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
      ProductDetailPage(arguments: arguments)
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
