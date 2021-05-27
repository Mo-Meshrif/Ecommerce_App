import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/userModel.dart';

class FireStoreUser {
  final collectionRef = FirebaseFirestore.instance.collection('Users');
  Future<void> addUserToFireStore(UserModel user) async {
    return await collectionRef.doc(user.id).set(user.toJson());
  }
}
