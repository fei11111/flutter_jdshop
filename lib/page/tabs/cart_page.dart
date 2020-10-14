import 'package:flutter/material.dart';
import 'package:flutter_jdshop/providers/counter.dart';
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
    return RaisedButton(
        child: Text("购物车+1"),
        onPressed: () {
          context.read<Counter>().increment();
        });
  }
}
