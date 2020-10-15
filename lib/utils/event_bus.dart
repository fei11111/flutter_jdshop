import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductDetailEvent {
  String str;
  ProductDetailEvent(str) {
    this.str = str;
  }
}
