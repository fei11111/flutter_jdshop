import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterFirstPage extends StatefulWidget {
  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
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
                          margin: EdgeInsets.zero,
                          onChange: (value) {},
                          border: Border.all(color: Colors.black12, width: 1.w),
                        ))
                  ],
                ),
                CustomButton(
                    buttonText: "下一步",
                    buttonColor: Colors.red,
                    margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    tap: () {
                      Navigator.pushNamed(context, '/registerSecond');
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
