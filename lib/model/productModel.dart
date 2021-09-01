import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id, viewerId, prodName, imgUrl, price, brand, condition, sku, material;
  Map<String, dynamic> classification;
  List<dynamic> color, size;
  Timestamp createdAt;
  ProductModel({
    this.id,
    this.viewerId,
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
    viewerId = map['viewerId'];
    prodName = map['prodName'];
    imgUrl = map['imgUrl'];
    color = map['color'];
    size = map['size'];
    price = map['price'];
    createdAt = map['createdAt'] is String
        ? Timestamp.fromDate(DateTime.parse(map['createdAt']))
        : map['createdAt'];
    brand = map['brand'];
    condition = map['condition'];
    sku = map['sku'];
    material = map['material'];
    classification = map['classification'];
  }
  static toJson(ProductModel prod) {
    return {
      'id': prod.id,
      'viewerId': prod.viewerId,
      'prodName': prod.prodName,
      'imgUrl': prod.imgUrl,
      'color': prod.color,
      'size': prod.size,
      'price': prod.price,
      'createdAt': prod.createdAt.toDate()?.toIso8601String(),
      'brand': prod.brand,
      'condition': prod.condition,
      'sku': prod.sku,
      'material': prod.material,
      'classification': prod.classification,
    };
  }

  static String encode(List<ProductModel> prods) => jsonEncode(
        prods
            .map<Map<String, dynamic>>((item) => ProductModel.toJson(item))
            .toList(),
      );

  static List<ProductModel> decode(String prod) =>
      (jsonDecode(prod) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
}
