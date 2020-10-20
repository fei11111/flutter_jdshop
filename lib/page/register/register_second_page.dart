import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterSecondPage extends StatefulWidget {
  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
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
                          onChange: (value) {},
                          border: Border.all(color: Colors.black12, width: 1.w),
                        )),
                    CustomButton(
                        buttonText: "重新发送",
                        buttonColor: Colors.red,
                        margin: EdgeInsets.only(
                            left: 20.w, top: 20.h, bottom: 20.h),
                        tap: () {
                          Navigator.pushNamed(context, '/registerThird');
                        })
                  ],
                ),
                CustomButton(
                    buttonText: "下一步",
                    buttonColor: Colors.red,
                    margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    tap: () {
                      Navigator.pushNamed(context, '/registerThird');
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
