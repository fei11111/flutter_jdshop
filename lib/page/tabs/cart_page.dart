import 'package:flutter/material.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/page/cart/cart_item_page.dart';
import 'package:flutter_jdshop/providers/cart_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _allCheck = false;

  @override
  void initState() {
    super.initState();
    debugPrint("cart initState");
    _allCheck = context.watch<CartProviders>().allCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("购物车"),
          elevation: 0.0,
          actions: [
            IconButton(
                icon: Icon(Icons.launch),
                onPressed: () {
                  debugPrint("分享");
                })
          ],
        ),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 78.h),
                child: ListView.builder(
                    itemCount: context.watch<CartProviders>().cartNum,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      ProductDetailItemModel model =
                          context.watch<CartProviders>().cartList[index];
                      return InkWell(
                          splashColor: Colors.transparent,
                          child: CartItemPage(model: model),
                          onTap: () {
                            Navigator.pushNamed(context, '/productDetail',
                                arguments: {"id": model.id});
                          });
                    })),
            Align(alignment: Alignment.bottomCenter, child: _getBalanceWidget())
          ],
        ));
  }

  Widget _getBalanceWidget() {
    return Container(
        width: double.infinity,
        height: 78.h,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1.w, color: Colors.black12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(children: [
                  Checkbox(
                      activeColor: Colors.pink,
                      onChanged: (value) {
                        _checkAll();
                      },
                      value: _allCheck),
                  Text("全选")
                ]),
                onTap: () {
                  _checkAll();
                }),
            InkWell(
                onTap: () {
                  debugPrint("结算");
                },
                child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    decoration: BoxDecoration(color: Colors.red),
                    padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                    child: Text("结算", style: TextStyle(color: Colors.white))))
          ],
        ));
  }

  void _checkAll() {
    context.watch<CartProviders>().checkAll(!_allCheck);
  }
}
