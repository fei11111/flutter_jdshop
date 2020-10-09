import 'package:flutter/material.dart';

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
      child: Text("用户页面"),
    );
  }
}
