class UserModel {
  String id, userName, email, pic;
  UserModel({
    this.id,
    this.userName,
    this.email,
    this.pic,
  });
  UserModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = map['id'];
    userName = map['userName'];
    email = map['email'];
    pic = map['pic'];
  }

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'pic': pic,
    };
  }
}
