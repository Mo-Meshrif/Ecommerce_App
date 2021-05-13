class User {
  String id, userName, email, image;
  User({
    this.id,
    this.userName,
    this.email,
    this.image,
  });
  User.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = map['id'];
    userName = map['userName'];
    email = map['email'];
    image = map['image'];
  }

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'image': image,
    };
  }
}
