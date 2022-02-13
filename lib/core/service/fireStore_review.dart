import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/rewiewModel.dart';

class FireStoreReview {
  final collectionIndividualRef =
      FirebaseFirestore.instance.collection('Reviews');

  Future<void> addReviewToFireStore(ReviewModel review) async =>
      await collectionIndividualRef.add(review.toJson());

  Future<void> deleteReview(String revId) async {
    await collectionIndividualRef.doc(revId).delete();
  }
}
