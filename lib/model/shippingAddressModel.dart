class ShippingAddressModel {
  String fullName, mobileNumber, state, city, street;
  int id, isSelected;
  ShippingAddressModel({
    this.fullName,
    this.mobileNumber,
    this.state,
    this.city,
    this.street,
    this.isSelected,
  });
  ShippingAddressModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    fullName = map['fullName'];
    mobileNumber = map['mobileNumber'];
    state = map['state'];
    city = map['city'];
    street = map['street'];
    isSelected = map['isSelected'];
  }
  toJson() {
    return {
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'state': state,
      'city': city,
      'street': street,
      'isSelected': isSelected,
    };
  }
}
