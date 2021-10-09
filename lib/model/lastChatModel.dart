import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/userModel.dart';

class LastChatModel {
  String id;
  Timestamp messageTime;
  String vendorId;
  String customerId;
  UserModel from;
  UserModel to;
  String lastMessage;
  int orderNumber;
  bool isOpened;
  LastChatModel({
    this.id,
    this.messageTime,
    this.vendorId,
    this.customerId,
    this.from,
    this.to,
    this.lastMessage,
    this.orderNumber,
    this.isOpened,
  });
  LastChatModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    messageTime = map['messageTime'];
    vendorId = map['vendorId'];
    customerId = map['customerId'];
    from = map['from'];
    to = map['to'];
    lastMessage = map['lastMessage'];
    orderNumber = map['orderNumber'];
    isOpened = map['isOpened'];
  }
  toJson() {
    return {
      'id': id,
      'messageTime': messageTime,
      'vendorId': vendorId,
      'customerId': customerId,
      'from': from,
      'to': to,
      'lastMessage': lastMessage,
      'orderNumber': orderNumber,
      'isOpened': isOpened,
    };
  }
}
