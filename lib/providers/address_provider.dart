import 'package:flutter/cupertino.dart';
import 'package:flutter_jdshop/models/address_model.dart';

class AddressProvider with ChangeNotifier {
  AddressItemModel _addressItemModel;
  AddressItemModel get defaultAddress => _addressItemModel;

  void setDefaultAddress(AddressItemModel model) {
    _addressItemModel = model;
    notifyListeners();
  }
}
