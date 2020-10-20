import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text("登录"),
          actions: [
            FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text("客服"),
              onPressed: () {
                debugPrint("客服");
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Center(
                child: Container(
                    margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
                    width: 200.w,
                    height: 200.h,
                    child: Image.network(
                        'https://www.itying.com/images/flutter/list5.jpg',
                        fit: BoxFit.cover))),
            CustomTextField(
                text: "用户名/手机号",
                password: false,
                onChange: (value) {
                  debugPrint(value);
                }),
            CustomTextField(
                text: "请输入密码",
                password: true,
                onChange: (value) {
                  debugPrint(value);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  padding: EdgeInsets.zero,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text("忘记密码"),
                  onPressed: () {},
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text("新用户注册"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registerFirst');
                  },
                )
              ],
            ),
            CustomButton(
                buttonText: "登录",
                buttonColor: Colors.red,
                margin: EdgeInsets.all(30.w))
          ],
        ));
  }
}
