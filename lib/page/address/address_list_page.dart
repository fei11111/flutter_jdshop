import 'dart:async';

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
import 'package:flutter_jdshop/widget/custom_tip_dialog.dart';
import 'package:flutter_jdshop/widget/loading_dialog.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';
import 'package:flutter_jdshop/widget/no_data_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<AddressItemModel> _list;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _initListener();
    _getAddressList();
  }

  void _initListener() {
    _subscription = eventBus.on<AddressEvent>().listen((event) {
      if (event.type != AddressType.DEFAULT_ADDRESS) {
        toastShort(event.str);
        _getAddressList();
        debugPrint("AddressListPage listener");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
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
      AddressModel addressModel = AddressModel.fromJson(data);
      if (addressModel != null) {
        setState(() {
          _list = addressModel.result;
        });
      } else {
        _list = [];
      }
    } else {
      _list = [];
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
      eventBus.fire(AddressEvent("更新默认地址", AddressType.DEFAULT_ADDRESS));
      Navigator.pop(context);
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
            _list == null
                ? LoadingWidget()
                : _list.length > 0
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 78.h),
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _list.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  margin: EdgeInsets.only(top: 15.h),
                                  padding: EdgeInsets.all(15.w),
                                  child: ListTile(
                                      leading: Icon(Icons.check,
                                          color:
                                              _list[index].defaultAddress == 1
                                                  ? Colors.red
                                                  : Colors.black38,
                                          size: 30),
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
                                          }),
                                      onLongPress: () {
                                        _delete(_list[index]);
                                      },
                                      onTap: () {
                                        if (_list[index].defaultAddress != 1) {
                                          _changeDefaultAddress(_list[index]);
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      }));
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

  ///删除
  void _delete(AddressItemModel model) {
    showCustomTipDialog(context, null, "确认删除？", "取消", "确认", null, () async {
      UserModel userInfo = context.read<UserProvider>().userModel;
      Map map = {'uid': userInfo.id, 'salt': userInfo.salt, 'id': model.id};
      String sign = SignUtil.getSign(map);
      showingDialog(context);
      var response = await Dio().post(Config.getDeleteAddress(),
          data: {'uid': userInfo.id, 'sign': sign, 'id': model.id});
      var data = response.data;
      debugPrint("删除请求返回数据$data");
      if (data['success']) {
        closeDialog(context);
        if (_list.length == 1) {
          ///剩下一个后还删除，就要更新默认地址
          eventBus.fire(AddressEvent("更新默认地址", AddressType.DEFAULT_ADDRESS));
        }
        _getAddressList();
      } else {
        closeDialog(context);
        toastShort(data['message']);
      }
    });
  }
}
