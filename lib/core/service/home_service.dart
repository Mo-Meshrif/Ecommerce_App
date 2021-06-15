import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final CollectionReference _collectionCategoriesRef =
      FirebaseFirestore.instance.collection('Categories');
  final CollectionReference _collectionProductsRef =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getCategoriesFromFireStore() async {
    var val = await _collectionCategoriesRef.orderBy('createdAt').get();
    return val.docs;
  }

  Future<List<QueryDocumentSnapshot>> getProductsFromFireStore() async {
    var val = await _collectionProductsRef
        .orderBy('createdAt', descending: true)
        .get();
    return val.docs;
  }
}
