import 'package:news_app/Model/site.dart';


class FavoriteDetails {
  int? id;
  String? title;
  String? content;
  String? imageUrl;
  String? url;
  Category? category;
  // Null? author;
  Site? site;
  String? uploaded;
  // List<Null> comment;

  FavoriteDetails({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.url,
    this.category,
    // this.author,
    this.site,
    this.uploaded,
    //  this.comment
  });

  FavoriteDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['image_url'];
    url = json['url'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    // author = json['author'];
    site = json['site'] != null ? new Site.fromJson(json['site']) : null;
    uploaded = json['uploaded'];
    // if (json['comment'] != null) {
    //   comment = new List<Null>();
    //   json['comment'].forEach((v) {
    //     comment.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    // data['author'] = this.author;
    if (this.site != null) {
      data['site'] = this.site!.toJson();
    }
    data['uploaded'] = this.uploaded;
    // if (this.comment != null) {
    //   data['comment'] = this.comment.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? updatedAt;
  String? createdAt;

  Category({this.id, this.name, this.updatedAt, this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
