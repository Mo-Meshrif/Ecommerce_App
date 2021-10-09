import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireStoreChat {
  final collectionChat = FirebaseFirestore.instance.collection('Chats');

  Future<List<QueryDocumentSnapshot>> getChatsFromFireStore() async {
    var val = await collectionChat.orderBy('createdAt').get();
    return val.docs;
  }

  Future<void> addMessageToFireStore(
      {@required Timestamp createdAt,
      @required String vendorId,
      @required String from,
      @required String to,
      @required String message,
      @required int orderNumber}) async {
    return await collectionChat.add({
      'createdAt': createdAt,
      'vendorId': vendorId,
      'from': from,
      'to': to,
      'message': message,
      'orderNumber': orderNumber,
      'isOpened': false
    });
  }

  Future<void> updateIsOpenedParameter(id) async {
    await collectionChat.doc(id).update({'isOpened': true});
  }

  Future<void> deleteMessage(id) async {
    await collectionChat.doc(id).delete();
  }
}
