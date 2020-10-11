import 'package:flutter/material.dart';
import 'package:flutter_jdshop/routers/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      title: 'JD Shop',
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
