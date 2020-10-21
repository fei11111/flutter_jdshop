import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterThirdPage extends StatefulWidget {
  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  bool _isPassword = true;

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
                  margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  onChange: (value) {},
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
                    buttonColor: Colors.red,
                    margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    tap: () {}),
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
