import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';

class CartProviders with ChangeNotifier, DiagnosticableTreeMixin {
  List<ProductDetailItemModel> _cartList = [];
  int get cartNum => _cartList.length;
  List get cartList => _cartList;
  bool _isAllCheck = false;
  bool get allCheck => _isAllCheck;

  void addCart(ProductDetailItemModel value) {
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
    notifyListeners();
  }

  void deleteCart(value) {
    if (_cartList.contains(value)) {
      int index = _cartList.indexOf(value);
      _cartList.removeAt(index);
      notifyListeners();
    }
  }

  void checkAll(bool value) {
    for (int i = 0; i < _cartList.length; i++) {
      _cartList[i].checked = value;
    }
    _isAllCheck = value;
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

  void itemCheck() {
    _isAllCheck = _isAllChecked();
    notifyListeners();
  }
}
