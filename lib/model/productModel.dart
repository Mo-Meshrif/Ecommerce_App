import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id, prodName, imgUrl, price, brand, condition, sku, material;
  Map<String, dynamic> classification;
  List<dynamic> color, size;
  Timestamp createdAt;
  ProductModel({
    this.id,
    this.prodName,
    this.imgUrl,
    this.color,
    this.size,
    this.price,
    this.createdAt,
    this.brand,
    this.condition,
    this.sku,
    this.material,
    this.classification,
  });
  ProductModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    prodName = map['prodName'];
    imgUrl = map['imgUrl'];
    color = map['color'];
    size = map['size'];
    price = map['price'];
    createdAt = map['createdAt'];
    brand = map['brand'];
    condition = map['condition'];
    sku = map['sku'];
    material = map['material'];
    classification = map['classification'];
  }
  toJson() {
    return {
      'id': id,
      'prodName': prodName,
      'imgUrl': imgUrl,
      'color': color,
      'size': size,
      'price': price,
      'createdAt': createdAt,
      'brand': brand,
      'condition': condition,
      'sku': sku,
      'material': material,
      'classification': classification,
    };
  }
}
