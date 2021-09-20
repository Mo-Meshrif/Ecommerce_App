import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderId, customerId, status, promoCode;
  Timestamp createdAt;
  List orderTrack;
  int orderNumber;
  Map<String, dynamic> shippingAdress, paymentMehod;
  List items;
  double rate;
  OrderModel({
    this.orderId,
    this.customerId,
    this.status,
    this.promoCode,
    this.createdAt,
    this.orderTrack,
    this.orderNumber,
    this.shippingAdress,
    this.paymentMehod,
    this.items,
    this.rate,
  });
  OrderModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    orderId = map['orderId'];
    customerId = map['customerId'];
    status = map['status'];
    promoCode = map['promoCode'];
    createdAt = map['createdAt'];
    orderTrack = map['orderTrack'];
    orderNumber = map['orderNumber'];
    shippingAdress = map['shippingAdress'];
    paymentMehod = map['paymentMehod'];
    items = map['items'];
    rate = map['rate'];
  }
  tojson() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'status': status,
      'promoCode': promoCode,
      'createdAt': createdAt,
      'orderTrack': orderTrack,
      'orderNumber': orderNumber,
      'shippingAdress': shippingAdress,
      'paymentMehod': paymentMehod,
      'items': items,
      'rate': rate,
    };
  }
}
