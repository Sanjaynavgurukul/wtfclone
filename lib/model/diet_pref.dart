// To parse this JSON data, do
//
//     final dietPref = dietPrefFromJson(jsonString);

import 'dart:convert';

class DietPref {
  DietPref({
    this.status,
    this.pagination,
    this.data,
  });

  bool status;
  List<Pagination> pagination;
  List<Datum> data;

  factory DietPref.fromRawJson(String str) =>
      DietPref.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DietPref.fromJson(Map<String, dynamic> json) => DietPref(
        status: json["status"],
        pagination: List<Pagination>.from(
            json["pagination"].map((x) => Pagination.fromJson(x))),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pagination": List<dynamic>.from(pagination.map((x) => x.toJson())),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.uid,
    this.type,
    this.value,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.image
  });

  int id;
  String uid;
  String type;
  String value;
  String status;
  String dateAdded;
  String image;
  dynamic lastUpdated;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        uid: json["uid"],
        type: json["type"],
        value: json["value"],
        status: json["status"],
    image: json["image"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "type": type,
        "value": value,
        "status": status,
        "image": image,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
      };
}

class Pagination {
  Pagination({
    this.pagination,
    this.limit,
    this.pages,
  });

  String pagination;
  int limit;
  int pages;

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        pagination: json["pagination"],
        limit: json["limit"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination,
        "limit": limit,
        "pages": pages,
      };
}
