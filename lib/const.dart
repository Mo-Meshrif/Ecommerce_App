import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/subViews/moreView/shippingAddressView.dart';

const priColor = Color.fromRGBO(255, 105, 105, 1);
const swatchColor = Color.fromRGBO(81, 92, 111, 1);
List<Map<String, dynamic>> profileComponents = [
  {
    'icon': 'assets/profile-more/all-order.png',
    'txt': 'All My Orders',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/pending-shipments.png',
    'txt': 'Pending Shipments',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/pending-payment.png',
    'txt': 'Pending Payments',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/finished.png',
    'txt': 'Finished Orders',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/invite.png',
    'txt': 'Invite Friends',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/support.png',
    'txt': 'Customer Support',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/rate.png',
    'txt': 'Rate Our App',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/suggest.png',
    'txt': 'Make a Suggestion',
    'onTap': () => null,
  },
];
List<Map<String, dynamic>> moreComponents = [
  {
    'icon': 'assets/profile-more/shipping.png',
    'txt': 'Shipping Address',
    'onTap': () => Get.to(() => ShippingView()),
  },
  {
    'icon': 'assets/profile-more/payment.png',
    'txt': 'Payment Method',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/currency.png',
    'txt': 'Currency',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/language.png',
    'txt': 'Language',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/bell.png',
    'txt': 'Notification Settings',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/shield.png',
    'txt': 'Privacy Policy',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/discuss-issue.png',
    'txt': 'Frequently Asked Questions',
    'onTap': () => null,
  },
  {
    'icon': 'assets/profile-more/check-form.png',
    'txt': 'Legal Information',
    'onTap': () => null,
  },
];
