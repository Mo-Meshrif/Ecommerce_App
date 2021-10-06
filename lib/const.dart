import '../view/subViews/moreView/rateOurAppView.dart';
import '../view/subViews/moreView/orderView/allOrdersView.dart';
import '../view/subViews/moreView/orderView/finishedOrdersView.dart';
import '../view/subViews/moreView/orderView/pendingShipmentsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/subViews/moreView/shippingAddressView/shippingAddressView.dart';
import 'view/subViews/moreView/paymentMethodView/paymentMethodView.dart';

const priColor = Color.fromRGBO(255, 105, 105, 1);
const swatchColor = Color.fromRGBO(81, 92, 111, 1);

String joinFirstTwoLetter(String subtence) {
  return subtence.capitalize.split(" ").length == 1
      ? subtence.capitalize[0]
      : subtence.capitalize.split(" ")[0][0] +
          subtence.capitalize.split(" ")[1][0];
}

List<Map<String, dynamic>> moreComponents = [
  {
    'icon': 'assets/more/all-order.png',
    'txt': 'All My Orders',
    'onTap': () => Get.to(() => AllOrdersView()),
  },
  {
    'icon': 'assets/more/pending-shipments.png',
    'txt': 'Pending Shipments',
    'onTap': () => Get.to(() => PendingShipmentsView()),
  },
  {
    'icon': 'assets/more/finished.png',
    'txt': 'Finished Orders',
    'onTap': () => Get.to(() => FinishedOrdersView()),
  },
  {
    'icon': 'assets/more/shipping.png',
    'txt': 'Shipping Address',
    'onTap': () => Get.to(() => ShippingView()),
  },
  {
    'icon': 'assets/more/payment.png',
    'txt': 'Payment Method',
    'onTap': () => Get.to(() => PaymentMethodView()),
  },
  {
    'icon': 'assets/more/rate.png',
    'txt': 'Rate Our App',
    'onTap': () => Get.to(() => RateOurAppView()),
  },
];
List<String> states = ['Cairo', 'Dakahlia'];
Map<String, List<String>> cities = {
  'Cairo': [
    'Ain Shams',
    'Bab al-Louq',
    'Zamalek',
  ],
  'Dakahlia': [
    'El Mansoura',
    'Aga',
    'Mit Ghamr',
  ],
};
List<String> imgCards = [
  'assets/more/visa.png',
  'assets/more/mastercard.png',
  'assets/more/paypal.png',
];
