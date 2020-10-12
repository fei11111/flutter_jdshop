import 'package:flutter/material.dart';

class ProductDetailRight extends StatefulWidget {
  @override
  _ProductDetailRightState createState() => _ProductDetailRightState();
}

class _ProductDetailRightState extends State<ProductDetailRight>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    debugPrint("ProductFoot");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("foot"),
    );
  }
}
