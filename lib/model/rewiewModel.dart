import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? prodId, userName, reviewTxt;
  Timestamp? createdAt;
  double? rateValue;
  ReviewModel({
    this.prodId,
    this.userName,
    this.reviewTxt,
    this.createdAt,
    this.rateValue,
  });
  ReviewModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    prodId = map['prodId'];
    userName = map['userName'];
    reviewTxt = map['reviewTxt'];
    createdAt = map['createdAt'];
    rateValue = map['rateValue'];
  }

  toJson() {
    return {
      'prodId': prodId,
      'userName': userName,
      'reviewTxt': reviewTxt,
      'createdAt': createdAt,
      'rateValue': rateValue
    };
  }
}
