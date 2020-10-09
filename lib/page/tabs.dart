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
  List<Widget> _pageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];
  var _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _pageController.addListener(() {
      int page = _pageController.page.toInt();
      if (page != _currentIndex)
        setState(() {
          _currentIndex = page;
        });
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(title: Text("jdshop")),
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: _pageList,
      // ),
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart), title: Text("购物车")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的"))
        ],
      ),
    );
  }
}