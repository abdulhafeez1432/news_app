import 'dart:convert';

List<Category> categoryFromJson(List jsonData) {
  return List<Category>.from(
      jsonData.map((x) => Category.fromJson(x)).toList());
}

String categoryToJson(List<Category> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(dynamic json) => Category(
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
