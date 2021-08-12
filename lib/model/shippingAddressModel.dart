class ShippingAddressModel {
  String fullName, mobileNumber, state, city, street;
  int id, isDef, isSelected;
  ShippingAddressModel({
    this.fullName,
    this.mobileNumber,
    this.state,
    this.city,
    this.street,
    this.isDef,
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
    isDef = map['isDef'];
    isSelected = map['isSelected'];
  }
  toJson() {
    return {
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'state': state,
      'city': city,
      'street': street,
      'isDef': isDef,
      'isSelected': isSelected,
    };
  }
}
