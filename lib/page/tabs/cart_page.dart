import 'package:flutter/material.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/page/cart/cart_item_page.dart';
import 'package:flutter_jdshop/providers/cart_providers.dart';
import 'package:flutter_jdshop/utils/event_bus_util.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/custom_tip_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    debugPrint("cart initState");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("cart build");
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("购物车"),
          elevation: 0.0,
          actions: [
            FlatButton(
                child: Text("删除"),
                onPressed: () {
                  ///小于等于0，说明没有勾选
                  if (context.read<CartProviders>().allPrice <= 0) {
                    return;
                  }
                  showCustomTipDialog(
                      context, "提示", "是否确认删除勾选的商品？", "取消", "确认", () {}, () {
                    context.read<CartProviders>().deleteCartByChecked();
                    toastShort("删除成功");
                  });
                })
          ],
        ),
        body: context.watch<CartProviders>().cartNum > 0
            ? Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 78.h),
                      child: ListView.builder(
                          itemCount: context.watch<CartProviders>().cartNum,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            ProductDetailItemModel model =
                                context.watch<CartProviders>().cartList[index];
                            debugPrint("商品:${model.title}");
                            return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: CartItemPage(model: model),
                                onTap: () {
                                  Navigator.pushNamed(context, '/productDetail',
                                      arguments: {"id": model.id});
                                });
                          })),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: _getBalanceWidget())
                ],
              )
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Text("购物车空空如也...",
                        style:
                            TextStyle(fontSize: 30.sp, color: Colors.black38)),
                    SizedBox(height: 10.h),
                    RaisedButton(
                        child: Text("去购物"),
                        onPressed: () {
                          eventBus.fire(ProductDetailEvent(
                              "去购物", ProductDetailType.TO_SHOPPING));
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     new MaterialPageRoute(
                          //         builder: (context) => TabsPage()),
                          //     (route) => route == null);
                        })
                  ])));
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
                      value: context.watch<CartProviders>().allCheck),
                  Text("全选")
                ]),
                onTap: () {
                  _checkAll();
                }),
            Row(
              children: [
                Text("合计:￥${context.watch<CartProviders>().allPrice}",
                    style: TextStyle(color: Colors.red, fontSize: 30.sp)),
                SizedBox(width: 20.w),
                InkWell(
                    onTap: () {
                      List<ProductDetailItemModel> _checkList =
                          context.watch<CartProviders>().checkList;
                      if (_checkList.length > 0) {
                        ///跳到结算页面
                        Navigator.pushNamed(context, '/checkOut',
                            arguments: {'list': _checkList});
                      } else {
                        toastShort("请勾选一件商品结算");
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        decoration: BoxDecoration(color: Colors.red),
                        padding: EdgeInsets.fromLTRB(45.w, 10.h, 45.w, 10.h),
                        child:
                            Text("结算", style: TextStyle(color: Colors.white))))
              ],
            )
          ],
        ));
  }

  void _checkAll() {
    bool allCheck = context.read<CartProviders>().allCheck;
    debugPrint("全选:$allCheck");
    context.read<CartProviders>().checkAll(!allCheck);
  }
}
