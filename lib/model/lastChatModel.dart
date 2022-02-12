import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/userModel.dart';

class LastChatModel {
  String? id;
  Timestamp? messageTime;
  String? vendorId;
  String? customerId;
  UserModel? from;
  UserModel? to;
  String? lastMessage;
  int? orderNumber;
  bool? isOpened;
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
}
