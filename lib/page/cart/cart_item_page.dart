import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/page/cart/cart_num_page.dart';
import 'package:flutter_jdshop/providers/cart_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartItemPage extends StatefulWidget {
  final ProductDetailItemModel model;

  const CartItemPage({Key key, this.model}) : super(key: key);

  @override
  _CartItemPageState createState() => _CartItemPageState();
}

class _CartItemPageState extends State<CartItemPage> {
  ProductDetailItemModel _model;
  // CartProviders _cartProviders;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("cart build");
    // _cartProviders = Provider.of<CartProviders>(context);
    return Container(
      height: 200.w,
      margin: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          Checkbox(
              value: _model.checked,
              onChanged: (value) {
                _model.checked = value;
                // _cartProviders.itemCheck();
              },
              activeColor: Colors.pink),
          Container(
              width: 160.w,
              height: 160.h,
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                      "${Config.domain}${_model.pic.replaceAll("\\", "/")}",
                      fit: BoxFit.cover))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(_model.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 26.sp))),
                        Container(
                            child: Text("款式：${_model.selectedAttr}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.blue))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("￥${_model.price.toString()}",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 24.sp)),
                            CartNumPage(model: _model)
                          ],
                        )
                      ])))
        ],
      ),
    );
  }
}
