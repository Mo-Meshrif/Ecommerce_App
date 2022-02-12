import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreChat {
  final collectionChat = FirebaseFirestore.instance.collection('Chats');
  final storageRef = FirebaseStorage.instance;
  Future<List<QueryDocumentSnapshot>> getChatsFromFireStore() async {
    var val = await collectionChat.orderBy('createdAt').get();
    return val.docs;
  }

  Future<void> addMessageToFireStore(
      {required Timestamp createdAt,
      required String? vendorId,
      required String? customerId,
      required String? from,
      required String? to,
      required String? message,
      required String? imgUrl,
      required int? orderNumber}) async => await collectionChat.add({
      'createdAt': createdAt,
      'vendorId': vendorId,
      'customerId': customerId,
      'from': from,
      'to': to,
      'message': message,
      'pic': imgUrl,
      'orderNumber': orderNumber,
      'isOpened': false
    });

  Future<String> uploadChatPic(File pic, String uid, Timestamp time) async {
    String url = '';
    Reference reference = storageRef
        .ref()
        .child('chatImages/')
        .child('${uid + time.toDate().second.toString()}+.jpg');
    await reference.putFile(pic).then((val) async {
      url = await val.ref.getDownloadURL();
    });
    return url;
  }

  Future<void> updateIsOpenedParameter(id) async {
    await collectionChat.doc(id).update({'isOpened': true});
  }

  Future<void> deleteMessage(id) async {
    await collectionChat.doc(id).delete();
  }
}
