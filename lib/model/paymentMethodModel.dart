class PaymentMehodModel {
  String? cardImage, cardNumber, expireDate, cvv, cardHolderName;
  int? id, isSelected;
  PaymentMehodModel({
    this.id,
    this.isSelected,
    this.cardImage,
    this.cardNumber,
    this.expireDate,
    this.cvv,
    this.cardHolderName,
  });
  PaymentMehodModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    isSelected = map['isSelected'];
    cardImage = map['cardImage'];
    cardNumber = map['cardNumber'];
    expireDate = map['expireDate'];
    cvv = map['cvv'];
    cardHolderName = map['cardHolderName'];
  }
  toJson() {
    return {
      'isSelected': isSelected,
      'cardImage': cardImage,
      'cardNumber': cardNumber,
      'expireDate': expireDate,
      'cvv': cvv,
      'cardHolderName': cardHolderName,
    };
  }
}
