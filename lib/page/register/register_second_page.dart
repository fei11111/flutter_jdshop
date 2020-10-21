import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterSecondPage extends StatefulWidget {
  final Map arguments;

  const RegisterSecondPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String _code = "";
  String _tel;
  bool _isSendCode = false;
  int _second = 10;
  Timer _t;

  @override
  void initState() {
    super.initState();
    _tel = widget.arguments['tel'];
    debugPrint("initState tel=$_tel");
    _showTimer(); //定时器
  }

  void _showTimer() {
    _t = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        _t.cancel();
        setState(() {
          _isSendCode = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(elevation: 0.0, centerTitle: true, title: Text("用户注册-第二步")),
        body: Container(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            child: ListView(
              children: [
                Text("请输入收到的验证码",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 30.sp)),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CustomTextField(
                          text: "请输入验证码",
                          password: false,
                          margin: EdgeInsets.zero,
                          onChange: (value) {
                            setState(() {
                              _code = value;
                            });
                          },
                          border: Border.all(color: Colors.black12, width: 1.w),
                        )),
                    CustomButton(
                        buttonText: _isSendCode ? "重新发送" : "$_second秒后重发",
                        buttonColor: _isSendCode ? Colors.red : Colors.black12,
                        margin: EdgeInsets.only(
                            left: 20.w, top: 20.h, bottom: 20.h),
                        tap: () {
                          if (_isSendCode) {
                            _sendCode();
                          }
                        })
                  ],
                ),
                CustomButton(
                    buttonText: "下一步",
                    buttonColor: Colors.red,
                    margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    tap: () {
                      if (_code.length > 0) {
                        _validateCode();
                      } else {
                        toastShort("请输入验证码!");
                      }
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("遇到问题?您可以",
                        style:
                            TextStyle(color: Colors.black38, fontSize: 26.sp)),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text("联系客服",
                          style: TextStyle(
                              color: Colors.black38,
                              decoration: TextDecoration.underline,
                              fontSize: 26.sp)),
                      onTap: () {
                        debugPrint("联系客服");
                      },
                    )
                  ],
                )
              ],
            )));
  }

  void _validateCode() async {
    var response = await Dio()
        .post(Config.getValidateCode(), data: {'tel': _tel, 'code': _code});
    var data = response.data;
    debugPrint("注册第二步返回：$data");
    if (data['success']) {
      Navigator.pushNamed(context, '/registerThird',
          arguments: {'tel': _tel, 'code': _code});
    } else {
      toastShort(data['message']);
    }
  }

  void _sendCode() async {
    RegExp reg = RegExp(Config.getPhoneExp());
    if (reg.hasMatch(_tel)) {
      var response = await Dio().post(Config.getCode(), data: {'tel': _tel});
      var data = response.data;
      debugPrint("发送验证码返回$data");
      setState(() {
        _second = 10;
        _isSendCode = false;
      });
      _showTimer();
      if (data['success'] && data['code'] != null) {
      } else {
        toastShort(data['message']);
      }
    } else {
      toastShort("手机格式不对");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _t?.cancel();
  }
}
