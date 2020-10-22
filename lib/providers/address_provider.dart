import 'package:flutter/cupertino.dart';
import 'package:flutter_jdshop/config/sp.dart';
import 'package:flutter_jdshop/models/address_model.dart';
import 'package:flutter_jdshop/utils/sp_util.dart';
import 'dart:convert';

class AddressProvider with ChangeNotifier {
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  int get size => _addressList.length;

  AddressProvider() {
    _init();
  }

  void _init() async {
    String str = await SPUtil.getString(SP.addressKey);
    try {
      var result = json.decode(str);
      _addressList = result.map<AddressModel>((e) {
        return AddressModel.fromJson(e);
      }).toList();
    } catch (e) {
      _addressList = [];
    }
    notifyListeners();
  }

  void addAddress(AddressModel model) async {
    if (model.isDefault) {
      _addressList.forEach((element) {
        element.isDefault = false;
      });
    }
    _addressList.add(model);
    await SPUtil.setString(SP.addressKey, json.encode(_addressList));
    notifyListeners();
  }

  void removeAddress(AddressModel model) async {
    _addressList.remove(model);
    await SPUtil.setString(SP.addressKey, json.encode(_addressList));
    notifyListeners();
  }
}
