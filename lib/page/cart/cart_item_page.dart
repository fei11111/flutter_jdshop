import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/page/cart/cart_num_page.dart';
import 'package:flutter_jdshop/providers/cart_providers.dart';
import 'package:flutter_jdshop/widget/custom_tip_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartItemPage extends StatefulWidget {
  final ProductDetailItemModel model;
  final bool isCheckOut; //结算页面

  const CartItemPage({Key key, this.model, this.isCheckOut = false})
      : super(key: key);

  @override
  _CartItemPageState createState() => _CartItemPageState();
}

class _CartItemPageState extends State<CartItemPage> {
  ProductDetailItemModel _model;
  bool _isCheckOut;

  @override
  void initState() {
    super.initState();
    debugPrint("cart item init");
  }

  @override
  Widget build(BuildContext context) {
    ///放在这里是因为要实时从父类那数据
    _model = widget.model;
    _isCheckOut = widget.isCheckOut;
    debugPrint("cart item build");
    debugPrint("cart item 商品:${_model.title}");
    return Container(
      height: 200.w,
      margin: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          !_isCheckOut
              ? Checkbox(
                  value: _model.checked,
                  onChanged: (value) {
                    _model.checked = value;
                    context.read<CartProviders>().itemCheck();
                  },
                  activeColor: Colors.pink)
              : SizedBox(),
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
                            height: 70.h,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(_model.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 26.sp))),
                                !_isCheckOut
                                    ? IconButton(
                                        icon: Icon(Icons.delete_outline,
                                            color: Colors.black54),
                                        onPressed: () {
                                          showCustomTipDialog(
                                              context,
                                              "提示",
                                              "是否确认删除该商品？",
                                              "取消",
                                              "确认",
                                              () {}, () {
                                            context
                                                .read<CartProviders>()
                                                .deleteCart(_model);
                                            Fluttertoast.showToast(
                                                msg: "删除成功",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER);
                                          });
                                        })
                                    : SizedBox()
                              ],
                            )),
                        Container(
                            height: 30.h,
                            child: Text("款式：${_model.selectedAttr}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: !_isCheckOut
                                        ? Colors.blue
                                        : Colors.black))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("￥${_model.price.toString()}",
                                style: TextStyle(
                                    color: !_isCheckOut
                                        ? Colors.red
                                        : Colors.black,
                                    fontSize: 24.sp)),
                            !_isCheckOut
                                ? CartNumPage(model: _model)
                                : Text("x${_model.count}")
                          ],
                        )
                      ])))
        ],
      ),
    );
  }
}
