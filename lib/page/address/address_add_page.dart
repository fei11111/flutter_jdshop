import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/address_model.dart';
import 'package:flutter_jdshop/providers/address_provider.dart';
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
  bool _isDefault = false;
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
                    margin: EdgeInsets.only(top: 20.h),
                    text: "收货人电话",
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
                Row(
                  children: [
                    Checkbox(
                        value: _isDefault,
                        onChanged: (value) {
                          setState(() {
                            _isDefault = value;
                          });
                        }),
                    Text("设置为默认")
                  ],
                ),
                CustomButton(
                    margin: EdgeInsets.only(top: 50.h),
                    buttonText: "增加",
                    buttonColor: _userName != null &&
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
                        RegExp reg = RegExp(Config.PHONE_EXP);
                        if (reg.hasMatch(_tel)) {
                          AddressModel model = AddressModel(
                              area: _area,
                              id: context.read<AddressProvider>().size,
                              userName: _userName,
                              tel: _tel,
                              detail: _detail,
                              isDefault: _isDefault);
                          context.read<AddressProvider>().addAddress(model);
                          Navigator.pop(context);
                        } else {
                          toastShort("手机格式不对");
                        }
                      }
                    })
              ],
            )));
  }
}
