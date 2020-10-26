import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/http/http_manager.dart';
import 'package:flutter_jdshop/http/result_data.dart';
import 'package:flutter_jdshop/providers/user_providers.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userName;
  String _password;

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
                    child: Image.asset('images/login.png', fit: BoxFit.cover))),
            CustomTextField(
                text: "用户名/手机号",
                password: false,
                onChange: (value) {
                  setState(() {
                    _userName = value;
                  });
                }),
            CustomTextField(
                text: "请输入密码",
                password: true,
                onChange: (value) {
                  setState(() {
                    _password = value;
                  });
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
                bgColor: _userName != null &&
                        _password != null &&
                        _userName.length >= 11 &&
                        _password.length >= 6
                    ? Colors.red
                    : Colors.black12,
                margin: EdgeInsets.all(30.w),
                tap: () {
                  if (_userName != null && _password != null) {
                    _login();
                  }
                })
          ],
        ));
  }

  void _login() async {
    RegExp reg = RegExp(Config.phoneExp);
    if (!reg.hasMatch(_userName)) {
      toastShort("手机格式不对");
      return;
    }
    if (_password.length < 6) {
      toastShort("密码少于6位");
      return;
    }
    ResultData resultData = await HttpManager.getInstance().post(
        Config.getLogin(),
        params: {'username': _userName, 'password': _password});
    if (resultData.success) {
      var list = resultData.data['userinfo'];
      if (list.length > 0) {
        var userInfo = list[0];
        context.read<UserProvider>().login(userInfo);
        toastShort("登录成功");
        Navigator.pop(context);
      } else {
        toastShort(resultData.message);
      }
    } else {
      toastShort(resultData.message);
    }
  }
}
