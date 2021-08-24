import '../../helper/paymentDatabaseHelper.dart';
import '../../model/paymentMethodModel.dart';
import 'package:flutter/material.dart';
import '../../helper/shippingDatabaseHelper.dart';
import '../../model/shippingAddressModel.dart';
import 'package:get/get.dart';

class MoreViewModel extends GetxController {
  MoreViewModel() {
    getAllShipping();
    getAllPayments();
  }
  //ShippingAddress
  final ShippingDatabaseHelper dbShippingClient = ShippingDatabaseHelper.db;
  List<ShippingAddressModel> _shippingList;
  List<ShippingAddressModel> get shippingList => _shippingList;
  GlobalKey<FormState> _shippingKey = GlobalKey<FormState>();
  GlobalKey<FormState> get shippingKey => _shippingKey;

  String fullName,
      mobileNumber,
      state = 'Select State',
      city = 'Select City',
      street;
  getState(val) {
    state = val;
    update();
  }

  getCity(val) {
    city = val;
    update();
  }

  addAddress(ShippingAddressModel shipping) {
    dbShippingClient.insert(shipping).then((_) {
      getAllShipping();
      Get.back();
    });
  }

  getAllShipping() async {
    _shippingList = await dbShippingClient.getAllShipping();
    update();
  }

  deleteOneShipping(id) {
    dbShippingClient.deleteOneShipping(id).then((_) => getAllShipping());
  }

  updateSelectedShippingParameter(id) {
    dbShippingClient.updateSelected(id).then((_) => getAllShipping());
  }

  clearShippingData() {
    fullName = mobileNumber = street = null;
    state = 'Select State';
    city = 'Select City';
    update();
  }

  //paymentMethod
  String cardImage = 'assets/profile-more/visa.png';
  final PaymentDatabaseHelper dbPaymentClient = PaymentDatabaseHelper.db;
  GlobalKey<FormState> _paymentKey = GlobalKey<FormState>();
  GlobalKey<FormState> get paymentKey => _paymentKey;
  List<PaymentMehodModel> _paymentsList;
  List<PaymentMehodModel> get paymentsList => _paymentsList;
  getSelectedCardImg(cardImg) {
    cardImage = cardImg;
    update();
  }

  String cardNumber = '', expireDate = '', cvv = '', cardHolderName = '';
  getCardNumber(val) {
    cardNumber = val;
    update();
  }

  getExpireDate(val) {
    expireDate = val;
    update();
  }

  getCvv(val) {
    cvv = val;
    update();
  }

  getCardHolderName(val) {
    cardHolderName = val;
    update();
  }

  addPayment(PaymentMehodModel payment) {
    dbPaymentClient.insert(payment).then((_) {
      getAllPayments();
      Get.back();
    });
  }

  getAllPayments() async {
    _paymentsList = await dbPaymentClient.getAllPayments();
    update();
  }

  deleteOnePayment(id) {
    dbPaymentClient.deleteOnePayment(id).then((_) => getAllPayments());
  }

  updateSelectedPaymentsParameter(id) {
    dbPaymentClient.updateSelected(id).then((_) => getAllPayments());
  }

  clearPaymentData() {
    cardNumber = expireDate = cvv = cardHolderName = '';
    cardImage = 'assets/profile-more/visa.png';
    update();
  }
}
