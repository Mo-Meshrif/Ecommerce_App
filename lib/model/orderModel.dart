import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id, status, promoCode;
  Timestamp createdAt;
  int orderNumber;
  Map<String, dynamic> shippingAdress, paymentMehod;
  List items;
  OrderModel(
      {this.id,
      this.status,
      this.promoCode,
      this.createdAt,
      this.orderNumber,
      this.shippingAdress,
      this.paymentMehod,
      this.items});
  OrderModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    status = map['status'];
    promoCode = map['promoCode'];
    createdAt = map['createdAt'];
    orderNumber = map['orderNumber'];
    shippingAdress = map['shippingAdress'];
    paymentMehod = map['paymentMehod'];
    items = map['items'];
  }
  tojson() {
    return {
      'id': id,
      'status': status,
      'promoCode': promoCode,
      'createdAt': createdAt,
      'orderNumber': orderNumber,
      'shippingAdress': shippingAdress,
      'paymentMehod': paymentMehod,
      'items': items,
    };
  }
}
