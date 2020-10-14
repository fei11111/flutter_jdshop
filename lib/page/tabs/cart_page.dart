import 'package:flutter/material.dart';
import 'package:flutter_jdshop/providers/cart.dart';
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
          children: [],
        ));
  }
}
