// To parse this JSON data, do
//
//     final shoppingCategories = shoppingCategoriesFromJson(jsonString);

import 'dart:convert';

ShoppingCategories shoppingCategoriesFromJson(String str) =>
    ShoppingCategories.fromJson(json.decode(str));

String shoppingCategoriesToJson(ShoppingCategories data) =>
    json.encode(data.toJson());

class ShoppingCategories {
  ShoppingCategories({
    this.status,
    this.data,
  });

  bool status;
  List<Data> data;

  factory ShoppingCategories.fromJson(Map<String, dynamic> json) =>
      ShoppingCategories(
        status: json["status"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.keyword,
    this.icon,
  });

  String keyword;
  String icon;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        keyword: json["keyword"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "icon": icon,
      };
}
