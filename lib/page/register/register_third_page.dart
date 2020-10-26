import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/config/sp.dart';
import 'package:flutter_jdshop/http/http_manager.dart';
import 'package:flutter_jdshop/http/result_data.dart';
import 'package:flutter_jdshop/utils/sp_util.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterThirdPage extends StatefulWidget {
  final Map arguments;

  const RegisterThirdPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  bool _isPassword = true;
  String _code = "";
  String _tel = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    debugPrint("registerThird initState");
    _code = widget.arguments['code'];
    _tel = widget.arguments['tel'];
  }

  void _register() async {
    ResultData resultData = await HttpManager.getInstance().post(
        Config.getRegister(),
        params: {'tel': _tel, 'code': _code, 'password': _password});
    if (resultData.success) {
      var list = resultData.data['userinfo'];
      if (list.length > 0) {
        var userInfo = list[0];
        await SPUtil.setString(SP.userInfoKey, json.encode(userInfo));
        // debugPrint("str = $str");
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/'));

        ///下面这种也是可以的
        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (context) {
        //   return LoginPage();
        // }), (route) {
        //   debugPrint("name:${route.settings.name}");
        //   return route.settings.name == '/';
        // });
        toastShort("注册成功");
      } else {
        toastShort(resultData.message);
      }
    } else {
      toastShort(resultData.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(elevation: 0.0, centerTitle: true, title: Text("用户注册-第三步")),
        body: Container(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            child: ListView(
              children: [
                Text("请设置登录密码",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 30.sp)),
                CustomTextField(
                  text: "请设置6~20位字符",
                  password: _isPassword,
                  maxLength: 20,
                  margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  onChange: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  border: Border.all(color: Colors.black12, width: 1.w),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _isPassword = !_isPassword;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: !_isPassword ? Colors.red : Colors.black38),
                      SizedBox(width: 10.w),
                      Text("密码可见", style: TextStyle(color: Colors.black38))
                    ],
                  ),
                ),
                Text("  密码由6~20位字母、数字或半角符号组成，不能是10位以下纯数字/字母/半角符号，字母需区分大小写",
                    style: TextStyle(color: Colors.black38, fontSize: 23.sp)),
                CustomButton(
                    buttonText: "完成",
                    bgColor:
                        _password.length >= 6 ? Colors.red : Colors.black12,
                    margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    tap: () {
                      if (_password.length >= 6) {
                        _register();
                      } else {
                        toastShort("密码至少6位字符");
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
}
