import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../model/userModel.dart';

class FireStoreUser {
  final collectionRef = FirebaseFirestore.instance.collection('Users');
  final storageRef = FirebaseStorage.instance;
  Future<void> addUserToFireStore(UserModel user) async {
    return await collectionRef.doc(user.id).set(user.toJson());
  }

  Future<DocumentSnapshot> getUserFromFireStore(uid) async {
    return await collectionRef.doc(uid).get();
  }

  Future<List<QueryDocumentSnapshot>> getUsersFromFireStore() async {
    var val = await collectionRef.get();
    return val.docs;
  }

  Future<void> uploadProfilePic(File pic, UserModel user) async {
    Reference reference =
        storageRef.ref().child('profileImages/').child('${user.id}+.jpg');
    await reference.putFile(pic).then((val) async {
      String url = await val.ref.getDownloadURL();
      await collectionRef.doc(user.id).set({
        'id': user.id,
        'userName': user.userName,
        'email': user.email,
        'pic': url,
      });
    });
  }

  Future<void> updateOnlineState(uid, bool isOnline) async {
    return await collectionRef.doc(uid).update({
      'isOnline': isOnline,
    });
  }
}
