import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/orderModel.dart';

class FireStoreOrder {
  final collectionOrder = FirebaseFirestore.instance.collection('Orders');
  Future<void> addOrderToFireStore(OrderModel order) async {
    return await collectionOrder.add(order.tojson());
  }

  Future<List<QueryDocumentSnapshot>> getOrdersFromFireStore() async {
    var val = await collectionOrder.orderBy('createdAt').get();
    return val.docs;
  }
}
