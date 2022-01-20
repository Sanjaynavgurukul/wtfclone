// To parse this JSON data, do
//
//     final dietConsumed = dietConsumedFromJson(jsonString);

import 'dart:convert';

class DietConsumed {
  DietConsumed({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory DietConsumed.fromRawJson(String str) =>
      DietConsumed.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DietConsumed.fromJson(Map<String, dynamic> json) => DietConsumed(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.uid,
    this.mealId,
    this.userId,
    this.dietcategoryId,
    this.status,
    this.dateAdded,
    this.cal,
    this.lastModified,
    this.date,
    this.coins,
    this.memberName,
    this.dietName,
  });

  int id;
  String uid;
  String mealId;
  String userId;
  String dietcategoryId;
  String status;
  String dateAdded;
  dynamic cal;
  dynamic lastModified;
  String date;
  String coins;
  String memberName;
  String dietName;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        uid: json["uid"],
        mealId: json["meal_id"],
        userId: json["user_id"],
        dietcategoryId: json["dietcategory_id"],
        status: json["status"],
        dateAdded: json["date_added"],
        cal: json["cal"],
        lastModified: json["last_modified"],
        date: json["date"],
        coins: json["coins"],
        memberName: json["member_name"],
        dietName: json["diet_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "meal_id": mealId,
        "user_id": userId,
        "dietcategory_id": dietcategoryId,
        "status": status,
        "date_added": dateAdded,
        "cal": cal,
        "last_modified": lastModified,
        "date": date,
        "coins": coins,
        "member_name": memberName,
        "diet_name": dietName,
      };
}
