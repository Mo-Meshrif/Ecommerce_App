class LastestCollectionModel {
  String? title, season, imgUrl;
  LastestCollectionModel({
    this.title,
    this.season,
    this.imgUrl,
  });
  LastestCollectionModel.fromJson(Map<String, dynamic> map) {
    title = map['title'];
    season = map['season'];
    imgUrl = map['imgUrl'];
  }
  toJson() {
    return {
      'title': title,
      'season': season,
      'imgUrl': imgUrl,
    };
  }
}
