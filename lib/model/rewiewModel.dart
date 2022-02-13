import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? reviewId, prodId, userId, reviewTxt;
  Timestamp? createdAt;
  double? rateValue;
  ReviewModel({
    this.prodId,
    this.userId,
    this.reviewTxt,
    this.createdAt,
    this.rateValue,
  });
  ReviewModel.fromJson(String revId, Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    reviewId = revId;
    prodId = map['prodId'];
    userId = map['userId'];
    reviewTxt = map['reviewTxt'];
    createdAt = map['createdAt'];
    rateValue = map['rateValue'];
  }

  toJson() {
    return {
      'prodId': prodId,
      'userId': userId,
      'reviewTxt': reviewTxt,
      'createdAt': createdAt,
      'rateValue': rateValue
    };
  }
}
