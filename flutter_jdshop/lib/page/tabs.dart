import 'package:flutter/material.dart';
import 'package:flutter_jdshop/page/tabs/cart.dart';
import 'package:flutter_jdshop/page/tabs/category.dart';
import 'package:flutter_jdshop/page/tabs/home.dart';
import 'package:flutter_jdshop/page/tabs/user.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List _pageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(title: Text("jdshop")),
      body: this._pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart), label: "购物车"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的")
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
