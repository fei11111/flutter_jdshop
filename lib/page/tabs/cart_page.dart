import 'package:flutter/material.dart';

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
    return Text("购物车页面");
  }
}
