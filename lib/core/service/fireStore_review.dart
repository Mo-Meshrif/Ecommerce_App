import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/rewiewModel.dart';

class FireStoreReview {
  final collectionIndividualRef =
      FirebaseFirestore.instance.collection('Reviews');

  Future<void> addReviewToFireStore(ReviewModel review, String userId) async {
    return await collectionIndividualRef
        .doc(review.prodId! + userId)
        .set(review.toJson());
  }

  Future<List<QueryDocumentSnapshot>> getAllReviewsFromFireStore() async {
    var val = await collectionIndividualRef
        .orderBy('createdAt', descending: true)
        .get();
    return val.docs;
  }
}
