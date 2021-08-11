import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MoreViewModel extends GetxController {
  //ShippingAddress
  ValueNotifier<bool> _isAdd = ValueNotifier(false);
  ValueNotifier<bool> get isAdd => _isAdd;
  changeShippingState(val) {
    _isAdd.value = val;
    update();
  }
}
