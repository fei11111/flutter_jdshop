import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jdshop/config/sp.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/utils/sp_util.dart';

class CartProviders with ChangeNotifier {
  List<ProductDetailItemModel> _cartList = [];
  int get cartNum => _cartList.length;
  List get cartList => _cartList;
  bool _isAllCheck = false;
  bool get allCheck => _isAllCheck;

  CartProviders() {
    _init();
  }

  void _init() async {
    try {
      String str = await SPUtil.getString(SP.cartKey);
      debugPrint("str=$str");
      var result = json.decode(str);
      result.map<ProductDetailItemModel>((v) => new ProductDetailItemModel.fromJson(v)).toList();
    } catch (e) {
      _cartList = [];
    }
    debugPrint("初始化 购物车数量:${_cartList.length}");
    _isAllCheck = _isAllChecked();
    notifyListeners();
  }

  void addCart(ProductDetailItemModel value) async {
    debugPrint("新增的model：${value.selectedAttr}");
    if (_cartList.contains(value)) {
      int index = _cartList.indexOf(value);
      ProductDetailItemModel model = _cartList[index];
      debugPrint("获取得到list该产品数量为${model.count},${model.selectedAttr}");
      model.count++;
      _cartList[index] = model;
      debugPrint("+1之后该产品数量为${_cartList[index].count}");
      debugPrint("购物车列表数量为${_cartList.length}");
    } else {
      ProductDetailItemModel model = ProductDetailItemModel(
          id: value.id,
          price: value.price,
          checked: value.checked,
          title: value.title,
          selectedAttr: value.selectedAttr,
          pic: value.pic,
          count: value.count);
      _cartList.add(model);
    }
    await SPUtil.setString(SP.cartKey, json.encode(_cartList));
    _init();
  }

  void deleteCart(value) async {
    if (_cartList.contains(value)) {
      int index = _cartList.indexOf(value);
      _cartList.removeAt(index);
      await SPUtil.setString(SP.cartKey, json.encode(_cartList));
      notifyListeners();
    }
  }

  void checkAll(bool value) async {
    for (int i = 0; i < _cartList.length; i++) {
      _cartList[i].checked = value;
    }
    _isAllCheck = value;
    await SPUtil.setString(SP.cartKey, json.encode(_cartList));
    notifyListeners();
  }

  bool _isAllChecked() {
    if (_cartList.length == 0) return false;
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].checked == false) {
        return false;
      }
    }
    return true;
  }

  void itemCheck() async {
    _isAllCheck = _isAllChecked();
    await SPUtil.setString(SP.cartKey, json.encode(_cartList));
    notifyListeners();
  }
}
