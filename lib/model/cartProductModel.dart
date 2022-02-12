class CartProductModel {
  String? id, customerId, name, imgUrl, size, color, price;
  int? quantity;
  CartProductModel(
      {this.id,
      this.customerId,
      this.name,
      this.imgUrl,
      this.size,
      this.color,
      this.price,
      this.quantity});
  CartProductModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = map['id'];
    customerId = map['customerId'];
    name = map['name'];
    imgUrl = map['imgUrl'];
    size = map['size'];
    color = map['color'];
    price = map['price'];
    quantity = map['quantity'];
  }

  toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'name': name,
      'imgUrl': imgUrl,
      'size': size,
      'color': color,
      'price': price,
      'quantity': quantity,
    };
  }
}
