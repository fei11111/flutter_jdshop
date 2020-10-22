import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_jdshop/config/sp.dart';
import 'package:flutter_jdshop/models/user_info.dart';
import 'package:flutter_jdshop/utils/sp_util.dart';

class UserProvider with ChangeNotifier {
  UserInfo _userInfo;
  UserInfo get userInfo => _userInfo;

  UserProvider() {
    _init();
  }

  void _init() async {
    String str = await SPUtil.getString(SP.userInfoKey);
    if (str != null) {
      _userInfo = UserInfo.fromJson(json.decode(str));
    }
    notifyListeners();
    debugPrint("UserProvider init $str");
  }

  void login(dynamic userInfo) async {
    try {
      _userInfo = UserInfo.fromJson(userInfo);
      await SPUtil.setString(SP.userInfoKey, json.encode(userInfo));
      debugPrint("UserProvider login");
    } catch (e) {
      _userInfo = null;
    }
    notifyListeners();
  }

  void logout() async {
    await SPUtil.remove(SP.userInfoKey);
    _userInfo = null;
    notifyListeners();
  }
}
