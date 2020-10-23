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
import 'package:flutter_jdshop/widget/no_data_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<AddressItemModel> _list = [];

  @override
  void initState() {
    super.initState();
    _initListener();
    _getAddressList();
  }

  void _initListener() {
    eventBus.on<AddressEvent>().listen((event) {
      _getAddressList();
      // if (event.type != AddressType.DEFAULT_ADDRESS) {
      //   _getAddressList();
      // } else {
      //   eventBus.fire(event);
      // }
    });
  }

  void _getAddressList() async {
    UserModel userInfo = context.read<UserProvider>().userModel;
    Map map = {'uid': userInfo.id, 'salt': userInfo.salt};
    String sign = SignUtil.getSign(map);
    debugPrint("_getAddressList sign=$sign");
    var response = await Dio().get(Config.getAddressList(userInfo.id, sign));
    var data = response.data;
    debugPrint("addressList 请求返回$data");
    if (data['success']) {
      var result = data['result'];
      if (result.length > 0) {
        AddressModel addressModel = AddressModel.fromJson(result);
        if (addressModel != null) {
          setState(() {
            _list = addressModel.result;
          });
        }
      }
    } else {
      toastShort(data['message']);
    }
  }

  void _changeDefaultAddress(AddressItemModel model) async {
    UserModel userInfo = context.read<UserProvider>().userModel;
    Map map = {'uid': userInfo.id, 'salt': userInfo.salt, 'id': model.id};
    String sign = SignUtil.getSign(map);
    var response = await Dio().post(Config.getChangeDefaultAddress(),
        data: {'uid': userInfo.id, 'sign': sign, 'id': model.id});
    var data = response.data;
    if (data['success']) {
      _getAddressList();
    } else {
      toastShort(data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("addressList build");
    return Scaffold(
        appBar:
            AppBar(title: Text("收货地址列表"), elevation: 0.0, centerTitle: true),
        body: Stack(
          children: [
            _list.length > 0
                ? Padding(
                    padding: EdgeInsets.only(bottom: 78.h),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(color: Colors.white),
                              margin: EdgeInsets.only(top: 15.h),
                              padding: EdgeInsets.all(15.w),
                              child: ListTile(
                                  leading: IconButton(
                                      icon: Icon(Icons.check,
                                          color:
                                              _list[index].defaultAddress == 1
                                                  ? Colors.red
                                                  : Colors.black38,
                                          size: 30),
                                      onPressed: () {
                                        if (_list[index].defaultAddress != 1) {
                                          _changeDefaultAddress(_list[index]);
                                        }
                                      }),
                                  title: Text(_list[index].name +
                                      "  " +
                                      _list[index].phone),
                                  subtitle: Text(_list[index].address),
                                  trailing: IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.blue, size: 30),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/addressEdit',
                                            arguments: {
                                              'address': _list[index]
                                            });
                                      })));
                        }))
                : NoDataWidget(),
            Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                    buttonColor: Colors.red,
                    buttonText: "新增",
                    tap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    }))
          ],
        ));
  }
}
