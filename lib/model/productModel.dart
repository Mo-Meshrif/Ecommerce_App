import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id, prodName, imgUrl, price, brand, condition, category, sku, material;
  List<dynamic> color, size;
  bool trend;
  Timestamp createdAt;
  ProductModel({
    this.id,
    this.prodName,
    this.imgUrl,
    this.color,
    this.size,
    this.price,
    this.trend,
    this.createdAt,
    this.brand,
    this.condition,
    this.category,
    this.sku,
    this.material,
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
    trend = map['trend'];
    createdAt = map['createdAt'];
    brand = map['brand'];
    condition = map['condition'];
    category = map['category'];
    sku = map['sku'];
    material = map['material'];
  }
  toJson() {
    return {
      'id': id,
      'prodName': prodName,
      'imgUrl': imgUrl,
      'color': color,
      'size': size,
      'price': price,
      'trend': trend,
      'createdAt': createdAt,
      'brand': brand,
      'condition': condition,
      'category': category,
      'sku': sku,
      'material': material,
    };
  }
}
