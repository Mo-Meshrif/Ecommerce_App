class CategoryModel {
  int id;
  String imgUrl, txt, avatarCol;
  Map<String, dynamic> shop;
  Map<String, dynamic> subCat;
  CategoryModel({
    this.id,
    this.imgUrl,
    this.txt,
    this.avatarCol,
    this.shop,
    this.subCat,
  });
  CategoryModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = map['id'];
    imgUrl = map['imgUrl'];
    txt = map['txt'];
    avatarCol = map['avatarCol'];
    shop = map['shop'];
    subCat = map['sub-cat'];
  }

  toJson() {
    return {
      'id': id,
      'imgUrl': imgUrl,
      'txt': txt,
      'avatarCol': avatarCol,
      'shop': shop,
      'sub-cat': subCat
    };
  }
}
