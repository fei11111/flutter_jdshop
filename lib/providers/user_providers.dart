import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_jdshop/config/sp.dart';
import 'package:flutter_jdshop/models/user_model.dart';
import 'package:flutter_jdshop/utils/sp_util.dart';

class UserProvider with ChangeNotifier {
  UserModel _userModel;
  UserModel get userModel => _userModel;

  UserProvider() {
    _init();
  }

  void _init() async {
    String str = await SPUtil.getString(SP.userInfoKey);
    if (str != null) {
      _userModel = UserModel.fromJson(json.decode(str));
    }
    notifyListeners();
    debugPrint("UserProvider init $str");
  }

  void login(dynamic userInfo) async {
    try {
      _userModel = UserModel.fromJson(userInfo);
      await SPUtil.setString(SP.userInfoKey, json.encode(userInfo));
      debugPrint("UserProvider login");
    } catch (e) {
      _userModel = null;
    }
    notifyListeners();
  }

  void logout() async {
    await SPUtil.remove(SP.userInfoKey);
    _userModel = null;
    notifyListeners();
  }
}
