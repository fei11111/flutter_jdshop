import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jdshop/providers/counter.dart';

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
    return Container(
      child: Text("购物车数量=${context.watch<Counter>().count}"),
    );
  }
}
