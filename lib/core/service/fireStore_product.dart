import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreProduct {
  final collectionRef = FirebaseFirestore.instance.collection('Products');

  Future<DocumentSnapshot> getProductsFromFireStore() async {
    return await collectionRef.doc().get();
  }
}
