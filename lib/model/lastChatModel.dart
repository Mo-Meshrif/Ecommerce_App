import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/userModel.dart';

class LastChatModel {
  String id;
  Timestamp messageTime;
  UserModel from;
  UserModel to;
  String lastMessage;
  int orderNumber;
  bool isOpened;
  LastChatModel({
    this.id,
    this.from,
    this.messageTime,
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
    from = map['from'];
    to = map['to'];
    messageTime = map['messageTime'];
    lastMessage = map['lastMessage'];
    orderNumber = map['orderNumber'];
    isOpened = map['isOpened'];
  }
  toJson() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'messageTime': messageTime,
      'lastMessage': lastMessage,
      'orderNumber': orderNumber,
      'isOpened': isOpened,
    };
  }
}
