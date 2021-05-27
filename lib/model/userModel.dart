class UserModel {
  String id, userName, email;
  UserModel({
    this.id,
    this.userName,
    this.email, 
  });
  UserModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = map['id'];
    userName = map['userName'];
    email = map['email'];
  }

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
    };
  }
}
