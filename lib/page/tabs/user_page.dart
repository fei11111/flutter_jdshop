import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jdshop/providers/cart_providers.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    debugPrint("user initState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("我的"), elevation: 0.0),
      body: Text("购物车数量=${context.watch<CartProviders>().cartNum}"),
    );
  }
}
