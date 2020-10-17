import 'package:flutter/material.dart';
import 'package:flutter_jdshop/page/tabs/cart_page.dart';
import 'package:flutter_jdshop/page/tabs/category_page.dart';
import 'package:flutter_jdshop/page/tabs/home_page.dart';
import 'package:flutter_jdshop/page/tabs/user_page.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_jdshop/utils/event_bus.dart';

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
    initListener();
  }

  void initListener() {
    _pageController.addListener(() {
      int page = _pageController.page.toInt();
      if (page != _currentIndex)
        setState(() {
          _currentIndex = page;
        });
    });
    eventBus.on<ProductDetailEvent>().listen((event) {
      if (event.type == ProductDetailType.TO_SHOPPING) {
        setState(() {
          _pageController.jumpToPage(0);
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Widget _getAppBarWidget() {
    return _currentIndex != 3
        ? AppBar(
            elevation: 0.0,
            titleSpacing: 0.0,
            leading: IconButton(
              icon: Icon(Icons.center_focus_weak,
                  size: 28, color: Colors.black54),
              onPressed: () {},
            ),
            title: InkWell(
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, size: 24, color: Colors.black45),
                    SizedBox(width: 10.w),
                    Text("搜索最新商品",
                        style:
                            TextStyle(color: Colors.black54, fontSize: 28.sp))
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            actions: [
              IconButton(
                icon:
                    Icon(Icons.message_sharp, size: 28, color: Colors.black45),
                onPressed: () {},
              )
            ],
          )
        : AppBar(centerTitle: true, title: Text("我的"), elevation: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: _pageList,
      // ),
      body: PageView(
        physics: BouncingScrollPhysics(),
        // physics: NeverScrollableScrollPhysics(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart), label: "购物车"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的")
        ],
      ),
    );
  }
}
