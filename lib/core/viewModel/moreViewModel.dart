import 'package:flutter/material.dart';

import '../../helper/shippingDatabaseHelper.dart';
import '../../model/shippingAddressModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MoreViewModel extends GetxController {
  MoreViewModel() {
    getAllShipping();
  }
  //ShippingAddress
  final ShippingDatabaseHelper dbShippingClient = ShippingDatabaseHelper.db;
  List<ShippingAddressModel> _shippingList;
  List<ShippingAddressModel> get shippingList => _shippingList;
  GlobalKey<FormState> _shippingKey = GlobalKey<FormState>();
  GlobalKey<FormState> get shippingKey => _shippingKey;
  ValueNotifier<bool> _isAdd = ValueNotifier(false);
  ValueNotifier<bool> get isAdd => _isAdd;
  changeShippingState(val) {
    if (!val) {
      clearShippingData();
    }
    _isAdd.value = val;
    update();
  }

  String fullName,
      mobileNumber,
      state = 'Select State',
      city = 'Select City',
      street;
  bool isDef = false;
  getState(val) {
    state = val;
    update();
  }

  getCity(val) {
    city = val;
    update();
  }

  getIsDef(val) {
    isDef = val;
    update();
  }

  addAddress(ShippingAddressModel shipping) {
    dbShippingClient.insert(shipping).then((_) {
      getAllShipping();
      changeShippingState(false);
    });
  }

  getAllShipping() async {
    _shippingList = await dbShippingClient.getAllShipping();
    update();
  }

  deleteOneShipping(id) {
    dbShippingClient.deleteOneShipping(id).then((_) => getAllShipping());
  }

  updateSelectedParameter(id) {
    dbShippingClient.updateSelected(id).then((_) => getAllShipping());
  }

  clearShippingData() {
    fullName = mobileNumber = street = null;
    state = 'Select State';
    city = 'Select City';
    isDef = false;
    update();
  }
}
