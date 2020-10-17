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

enum ProductDetailType {
  ///加入购物车
  ADD_CART,

  ///立即购买
  MUST_BUY,

  ///去购物
  TO_SHOPPING,
}
