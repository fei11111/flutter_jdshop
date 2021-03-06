import 'package:flutter/material.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/providers/cart_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartNumPage extends StatefulWidget {
  final ProductDetailItemModel model;

  const CartNumPage({Key key, this.model}) : super(key: key);

  @override
  _CartNumPageState createState() => _CartNumPageState();
}

class _CartNumPageState extends State<CartNumPage> {
  ProductDetailItemModel _model;

  @override
  void initState() {
    super.initState();
    debugPrint("CartNumPage initState");
    _model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
        child: Row(
          children: [
            _getLeftWidget(context),
            _getMiddleWidget(),
            _getRightWidget(context)
          ],
        ));
  }

  Widget _getLeftWidget(BuildContext context) {
    return InkWell(
        onTap: () {
          if (_model.count == 1) return;
          _model.count--;
          context.read<CartProviders>().itemChange();
        },
        child: Container(
            alignment: Alignment.center,
            width: 60.w,
            height: 60.h,
            child: Text("-", style: TextStyle(fontSize: 35.sp))));
  }

  Widget _getMiddleWidget() {
    return Container(
      width: 70.w,
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.black12, width: 1),
              right: BorderSide(color: Colors.black12, width: 1))),
      child: Text("${_model.count}"),
    );
  }

  Widget _getRightWidget(BuildContext context) {
    return InkWell(
        onTap: () {
          _model.count++;
          context.read<CartProviders>().itemChange();
        },
        child: Container(
            alignment: Alignment.center,
            width: 60.w,
            height: 60.h,
            child: Text("+", style: TextStyle(fontSize: 35.sp))));
  }
}
