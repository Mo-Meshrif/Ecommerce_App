import '../view/subViews/orderView/allOrdersView.dart';
import '../view/subViews/orderView/finishedOrdersView.dart';
import '../view/subViews/orderView/pendingShipmentsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/subViews/moreView/shippingAddressView/shippingAddressView.dart';
import 'view/subViews/moreView/paymentMethodView/paymentMethodView.dart';

const priColor = Color.fromRGBO(255, 105, 105, 1);
const swatchColor = Color.fromRGBO(81, 92, 111, 1);

String capitalizeFirstofEach(String text) {
  if (text == null) {
    return null;
  }
  if (text.length <= 1) {
    return text.toUpperCase();
  }
  // Split string into multiple words
  final List<String> words = text.split(' ');
  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);
      return '$firstLetter$remainingLetters';
    }
    return '';
  });
  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
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
    'icon': 'assets/more/language.png',
    'txt': 'Language',
    'onTap': () => null,
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
