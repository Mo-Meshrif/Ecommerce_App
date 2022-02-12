import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreRateApp {
  final collectionOrder = FirebaseFirestore.instance.collection('AppRate');
  Future<void> addAppRateToFireStore(rateVal, uid) async {
    return await collectionOrder.doc(uid).set({'rateValue': rateVal});
  }

  Future<Map<String, dynamic>?> getAppRateFromFireStore(uid) async {
    var val = await collectionOrder.doc(uid).get();
    return val.data();
  }
}
