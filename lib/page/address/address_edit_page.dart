import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/address_model.dart';
import 'package:flutter_jdshop/models/user_model.dart';
import 'package:flutter_jdshop/providers/user_providers.dart';
import 'package:flutter_jdshop/utils/event_bus_util.dart';
import 'package:flutter_jdshop/utils/sign_util.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressEditPage extends StatefulWidget {
  final Map arguments;

  const AddressEditPage({Key key, this.arguments}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  AddressItemModel _addressItemModel;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  String _detail = "";

  @override
  void initState() {
    super.initState();
    _addressItemModel = widget.arguments['address'];
    _nameController.text = _addressItemModel.name;
    _telController.text = _addressItemModel.phone;
    _areaController.text = _addressItemModel.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: Text("修改收货地址"), elevation: 0.0),
        body: Container(
            padding: EdgeInsets.all(10.w),
            child: ListView(
              children: [
                CustomTextField(
                    controller: _nameController,
                    margin: EdgeInsets.only(top: 20.h),
                    text: "收货人姓名",
                    onChange: (value) {
                      _nameController.text = value;
                    }),
                CustomTextField(
                    controller: _telController,
                    keyboardType: TextInputType.phone,
                    margin: EdgeInsets.only(top: 20.h),
                    text: "收货人电话",
                    maxLength: 11,
                    onChange: (value) {
                      _telController.text = value;
                    }),
                CustomTextField(
                    controller: _areaController,
                    margin: EdgeInsets.only(top: 20.h),
                    text: "省/市/区",
                    readOnly: true,
                    onTap: () async {
                      Result result = await CityPickers.showCityPicker(
                          locationCode: "130102",
                          height: 350.h,
                          context: context,
                          cancelWidget:
                              Text("取消", style: TextStyle(fontSize: 28.sp)),
                          confirmWidget:
                              Text("确定", style: TextStyle(fontSize: 28.sp)));
                      debugPrint(result.toString());
                      _areaController.text = result.provinceName +
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
                    buttonColor: _nameController.text.length > 0 &&
                            _telController.text.length > 0 &&
                            _areaController.text.length > 0 &&
                            _detail.length > 0
                        ? Colors.red
                        : Colors.black12,
                    tap: () {
                      if (_nameController.text.length > 0 &&
                          _telController.text.length > 0 &&
                          _areaController.text.length > 0 &&
                          _detail.length > 0) {
                        RegExp reg = RegExp(Config.phoneExp);
                        if (reg.hasMatch(_telController.text)) {
                          _changeAddress();
                        } else {
                          toastShort("手机格式不对");
                        }
                      }
                    })
              ],
            )));
  }

  void _changeAddress() async {
    UserModel userModel = context.read<UserProvider>().userModel;
    Map map = {
      'uid': userModel.id,
      'salt': userModel.salt,
      'id': _addressItemModel.id,
      'name': _nameController.text,
      'phone': _telController.text,
      'address': _areaController.text + _detail
    };
    String sign = SignUtil.getSign(map);
    var response = await Dio().post(Config.getEditAddress(), data: {
      'uid': userModel.id,
      'sign': sign,
      'id': _addressItemModel.id,
      'name': _nameController.text,
      'phone': _telController.text,
      'address': _areaController.text + _detail
    });
    var data = response.data;
    debugPrint("修改地址请求返回$data");
    if (data['success']) {
      if (_addressItemModel.defaultAddress == 1) {
        ///本来是默认就要调用重新获取默认接口数据
        eventBus.fire(AddressEvent("修改地址", AddressType.DEFAULT_ADDRESS));
      }
      eventBus.fire(AddressEvent('修改地址', AddressType.EDIT_ADDRESS));
      Navigator.pop(context);
    } else {
      toastShort(data['message']);
    }
  }
}
