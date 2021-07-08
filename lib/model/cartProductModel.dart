class CartProductModel {
  String id, name, imgUrl, size, color, price;
  int quantity;
  CartProductModel(
      {this.id,
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
      'name': name,
      'imgUrl': imgUrl,
      'size': size,
      'color': color,
      'price': price,
      'quantity': quantity,
    };
  }
}
