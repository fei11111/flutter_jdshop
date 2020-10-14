import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier, DiagnosticableTreeMixin {
  List _cartList = [];
  int get cartNum => _cartList.length;
  List get cartList => _cartList;

  void addCart(value) {
    _cartList.add(value);
    notifyListeners();
  }

  void deleteCart(value) {
    _cartList.remove(value);
    notifyListeners();
  }
}
