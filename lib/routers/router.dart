import 'package:flutter/material.dart';
import 'package:flutter_jdshop/page/product_list.dart';
import '../page/search.dart';
import '../page/tabs.dart';

//配置路由
final routes = {
  '/': (context) => TabsPage(),
  '/search': (context) => SearchPage(),
  '/productList': (context, {arguments}) =>
      ProductListPage(arguments: arguments)
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
