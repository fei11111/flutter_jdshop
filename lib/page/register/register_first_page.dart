import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';

class RegisterFirstPage extends StatefulWidget {
  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  bool _buttonEnable = false;
  String _tel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(elevation: 0.0, centerTitle: true, title: Text("用户注册-第一步")),
        body: Container(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.w),
                      height: 68.h,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("+86"),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 1.w),
                              top:
                                  BorderSide(color: Colors.black12, width: 1.w),
                              left: BorderSide(
                                  color: Colors.black12, width: 1.w))),
                    ),
                    Expanded(
                        flex: 1,
                        child: CustomTextField(
                          text: "请输入手机号码",
                          password: false,
                          maxLength: 11,
                          keyboardType: TextInputType.phone,
                          margin: EdgeInsets.zero,
                          onChange: (value) {
                            if (value.length == 11) {
                              _buttonEnable = true;
                            } else {
                              _buttonEnable = false;
                            }
                            setState(() {
                              _tel = value;
                              _buttonEnable = _buttonEnable;
                            });
                          },
                          border: Border.all(color: Colors.black12, width: 1.w),
                        ))
                  ],
                ),
                CustomButton(
                    buttonText: "下一步",
                    bgColor: _buttonEnable ? Colors.red : Colors.black12,
                    margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    tap: () {
                      if (_buttonEnable) {
                        _sendCode();
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

  void _sendCode() async {
    RegExp reg = RegExp(Config.phoneExp);
    if (reg.hasMatch(_tel)) {
      var response = await Dio().post(Config.getCode(), data: {'tel': _tel});
      var data = response.data;
      debugPrint("发送验证码返回$data");
      if (data['success'] && data['code'] != null) {
        Navigator.pushNamed(context, '/registerSecond',
            arguments: {"tel": _tel, "code": data['code']});
      } else {
        toastShort(data['message']);
      }
    } else {
      toastShort("手机格式不对");
    }
  }
}
