import 'package:flutter/material.dart';

class ProductDetailMiddle extends StatefulWidget {
  @override
  _ProductDetailMiddleState createState() => _ProductDetailMiddleState();
}

class _ProductDetailMiddleState extends State<ProductDetailMiddle>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    debugPrint("ProductDetailMiddle");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("middle"),
    );
  }
}
