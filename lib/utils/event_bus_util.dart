import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductDetailEvent {
  String str;
  ProductDetailType type;

  ProductDetailEvent(String str, ProductDetailType type) {
    this.str = str;
    this.type = type;
  }
}

class UserEvent {
  String str;

  UserEvent(String str) {
    this.str = str;
  }
}

class AddressEvent {
  String str;

  AddressType type;

  AddressEvent(String str, AddressType type) {
    this.str = str;
    this.type = type;
  }
}

enum AddressType {
  ///添加地址
  ADD_ADDRESS,

  ///编辑地址
  EDIT_ADDRESS,

  ///删除地址
  DELETE_ADDRESS,

  ///修改为默认
  DEFAULT_ADDRESS
}

enum ProductDetailType {
  ///加入购物车
  ADD_CART,

  ///立即购买
  MUST_BUY,

  ///去购物
  TO_SHOPPING,
}
