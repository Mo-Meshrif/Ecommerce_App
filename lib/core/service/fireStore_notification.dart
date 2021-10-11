import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreNotification {
  final collectionDevicesToken =
      FirebaseFirestore.instance.collection('DevicesToken');
  setDeviceToken(tokenVal, uid) async {
    return await collectionDevicesToken.doc(uid).set({'token': tokenVal});
  }
}
