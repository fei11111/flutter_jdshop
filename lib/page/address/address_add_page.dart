import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/http/http_manager.dart';
import 'package:flutter_jdshop/http/result_data.dart';
import 'package:flutter_jdshop/models/user_model.dart';
import 'package:flutter_jdshop/providers/user_providers.dart';
import 'package:flutter_jdshop/utils/event_bus_util.dart';
import 'package:flutter_jdshop/utils/sign_util.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressAddPage extends StatefulWidget {
  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String _userName;
  String _tel;
  String _area;
  String _detail;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _area = _controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("增加收货地址"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
            padding: EdgeInsets.all(10.w),
            child: ListView(
              children: [
                CustomTextField(
                    margin: EdgeInsets.only(top: 20.h),
                    text: "收货人姓名",
                    onChange: (value) {
                      setState(() {
                        _userName = value;
                      });
                    }),
                CustomTextField(
                    keyboardType: TextInputType.phone,
                    margin: EdgeInsets.only(top: 20.h),
                    text: "收货人电话",
                    maxLength: 11,
                    onChange: (value) {
                      setState(() {
                        _tel = value;
                      });
                    }),
                CustomTextField(
                    controller: _controller,
                    margin: EdgeInsets.only(top: 20.h),
                    text: "省/市/区",
                    readOnly: true,
                    onTap: () async {
                      Result result = await CityPickers.showCityPicker(
                          height: 350.h,
                          context: context,
                          cancelWidget:
                              Text("取消", style: TextStyle(fontSize: 28.sp)),
                          confirmWidget:
                              Text("确定", style: TextStyle(fontSize: 28.sp)));
                      debugPrint(result.toString());
                      _controller.text = result.provinceName +
                          result.cityName +
                          result.areaName;
                    }),
                CustomTextField(
                    margin: EdgeInsets.only(top: 20.h),
                    text: "详细地址",
                    onChange: (value) {
                      setState(() {
                        _detail = value;
                      });
                    }),
                CustomButton(
                    margin: EdgeInsets.only(top: 50.h),
                    buttonText: "增加",
                    bgColor: _userName != null &&
                            _tel != null &&
                            _area != null &&
                            _detail != null &&
                            _userName.length > 0 &&
                            _tel.length > 0 &&
                            _area.length > 0 &&
                            _detail.length > 0
                        ? Colors.red
                        : Colors.black12,
                    tap: () {
                      if (_userName != null &&
                          _tel != null &&
                          _area != null &&
                          _detail != null &&
                          _userName.length > 0 &&
                          _tel.length > 0 &&
                          _area.length > 0 &&
                          _detail.length > 0) {
                        RegExp reg = RegExp(Config.phoneExp);
                        if (reg.hasMatch(_tel)) {
                          _addAddress();
                        } else {
                          toastShort("手机格式不对");
                        }
                      }
                    })
              ],
            )));
  }

  ///新增地址
  void _addAddress() async {
    UserModel userModel = context.read<UserProvider>().userModel;
    Map map = {
      'uid': userModel.id,
      'salt': userModel.salt,
      'phone': _tel,
      'name': _userName,
      'address': _area + _detail
    };
    String sign = SignUtil.getSign(map);
    debugPrint("_addAddress sign=$sign");
    ResultData result =
        await HttpManager.getInstance().post(Config.getAddAddress(), params: {
      'uid': userModel.id,
      'sign': sign,
      'phone': _tel,
      'name': _userName,
      'address': _area + _detail
    });
    if (result.success) {
      eventBus.fire(AddressEvent("新增成功!", AddressType.ADD_ADDRESS));
      eventBus.fire(AddressEvent("更新默认地址", AddressType.DEFAULT_ADDRESS));
      Navigator.pop(context);
    } else {
      toastShort(result.message);
    }
  }
}
