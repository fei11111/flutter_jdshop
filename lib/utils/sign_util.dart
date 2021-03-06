import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

class SignUtil {
  static String getSign(Map map) {
    List keys = map.keys.toList();
    keys.sort(); //排序  ASCII 字符顺序进行升序排列
    String str = '';
    for (var item in keys) {
      str += "$item${map[item]}";
    }
    debugPrint("排序后$str");
    return md5.convert(utf8.encode(str)).toString();
  }
}
