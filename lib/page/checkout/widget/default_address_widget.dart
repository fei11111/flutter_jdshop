import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/address_model.dart';
import 'package:flutter_jdshop/models/user_model.dart';
import 'package:flutter_jdshop/providers/address_provider.dart';
import 'package:flutter_jdshop/providers/user_providers.dart';
import 'package:flutter_jdshop/utils/event_bus_util.dart';
import 'package:flutter_jdshop/utils/sign_util.dart';
import 'package:flutter_jdshop/utils/toast_util.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///默认地址，独立写就不会刷新除默认地址以外的其它布局
class DefaultAddressWidget extends StatefulWidget {
  @override
  _DefaultAddressWidgetState createState() => _DefaultAddressWidgetState();
}

class _DefaultAddressWidgetState extends State<DefaultAddressWidget> {
  AddressItemModel _addressItemModel;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _initListener();
    _getDefaultAddress();
  }

  void _initListener() {
    _subscription = eventBus.on<AddressEvent>().listen((event) {
      if (event.type == AddressType.DEFAULT_ADDRESS) {
        _getDefaultAddress();
        debugPrint("DefaultWidget listener");
      }
    });
  }

  ///获取用户默认地址
  void _getDefaultAddress() async {
    UserModel userModel = context.read<UserProvider>().userModel;
    Map map = {'uid': userModel.id, 'salt': userModel.salt};
    String sign = SignUtil.getSign(map);
    debugPrint("_getDefaultAddress sign=$sign");
    var response =
        await Dio().get(Config.getDefaultAddress(userModel.id, sign));
    var data = response.data;
    debugPrint("默认地址返回:$data");
    if (data['success']) {
      AddressModel addressModel = AddressModel.fromJson(data);
      if (addressModel != null) {
        if (addressModel.result != null && addressModel.result.length > 0) {
          _addressItemModel = addressModel.result[0];
        } else {
          _addressItemModel = AddressItemModel();
        }
      }
    } else {
      _addressItemModel = AddressItemModel(); //初始化，为了让界面显示loading状态
      toastShort(data['message']);
    }
    context.read<AddressProvider>().setDefaultAddress(_addressItemModel);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _addressItemModel = context.watch<AddressProvider>().defaultAddress;
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        color: Colors.white,
        child: _addressItemModel == null
            ? LoadingWidget()
            : _addressItemModel.id == null
                ? ListTile(
                    leading: Icon(Icons.add_location),
                    title: Center(
                      child: Text("请添加收货地址"),
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.pushNamed(context, '/addressList');
                    })
                : ListTile(
                    title: Text(_addressItemModel.name +
                        "  " +
                        _addressItemModel.phone),
                    subtitle: Text(_addressItemModel.address),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      Navigator.pushNamed(context, '/addressList');
                    }));
  }
}
