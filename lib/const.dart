import '../view/subViews/moreView/rateOurAppView.dart';
import '../view/subViews/moreView/orderView/allOrdersView.dart';
import '../view/subViews/moreView/orderView/finishedOrdersView.dart';
import '../view/subViews/moreView/orderView/pendingShipmentsView.dart';
import 'helper/goTransittedPage.dart';
import 'view/subViews/moreView/shippingAddressView/shippingAddressView.dart';
import 'view/subViews/moreView/paymentMethodView/paymentMethodView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const priColor = Color.fromRGBO(255, 105, 105, 1);
const swatchColor = Color.fromRGBO(81, 92, 111, 1);
enum DeviceType { Mobile, Tablet, Desktop }

String joinFirstTwoLetter(String subtence) {
  return subtence.capitalize!.split(" ").length == 1
      ? subtence.capitalize![0]
      : subtence.capitalize!.split(" ")[0][0] +
          subtence.capitalize!.split(" ")[1][0];
}

List<Map<String, dynamic>> moreComponents = [
  {
    'icon': 'assets/more/all-order.png',
    'txt': 'All My Orders',
    'onTap': () => Go.to(() => AllOrdersView()),
  },
  {
    'icon': 'assets/more/pending-shipments.png',
    'txt': 'Pending Shipments',
    'onTap': () => Go.to(() => PendingShipmentsView()),
  },
  {
    'icon': 'assets/more/finished.png',
    'txt': 'Finished Orders',
    'onTap': () => Go.to(() => FinishedOrdersView()),
  },
  {
    'icon': 'assets/more/shipping.png',
    'txt': 'Shipping Address',
    'onTap': () => Go.to(() => ShippingView()),
  },
  {
    'icon': 'assets/more/payment.png',
    'txt': 'Payment Method',
    'onTap': () => Go.to(() => PaymentMethodView()),
  },
  {
    'icon': 'assets/more/rate.png',
    'txt': 'Rate Our App',
    'onTap': () => Go.to(() => RateOurAppView()),
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
List<String> notificationIcon = [
  'assets/other/order.png',
  'assets/other/destination.png',
  'assets/other/discount.png',
];
String serverToken =
    'AAAAOtJSvxg:APA91bFGC9EUaMW6eilnS3OM0qu3bvWswykHs1BbNh6uZISX6kqr77D8-cnF8jkGdt9HKEQ8N8VsTCy76cBY3p5D5UERU4C-1XqI1LoavWyVWxCVPe-XV0XE1cQJvZ0NuuBlzEZ9it95';
String vapidKey =
    'BLmKD0J1hMxp3bCZORqQpj53Q5F6YtUN9ZdrfbmokNRugj-ePwrSnH2WZ5mHmPnD95IYKZi3Ohvd_9XhWjVg2gc';
