// To parse this JSON data, do
//
//     final dietItem = dietItemFromJson(jsonString);

import 'dart:convert';

class DietItem {
  DietItem({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory DietItem.fromRawJson(String str) =>
      DietItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DietItem.fromJson(Map<String, dynamic> json) => DietItem(
        status: json["status"],
        data: json.containsKey('data')
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.uid,
    this.name,
    this.description,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.type1,
    this.type2,
    this.type3,
    this.type1Name,
    this.type2Name,
    this.type3Name,
    this.day,
  });

  String uid;
  String name;
  String description;
  String status;
  String dateAdded;
  dynamic lastUpdated;
  String type1;
  String type2;
  dynamic type3;
  String type1Name;
  String type2Name;
  dynamic type3Name;
  Day day;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uid: json["uid"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        type1: json["type1"],
        type2: json["type2"],
        type3: json["type3"],
        type1Name: json["type1_name"],
        type2Name: json["type2_name"],
        type3Name: json["type3_name"],
        day: Day.fromJson(json["day"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "description": description,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "type1": type1,
        "type2": type2,
        "type3": type3,
        "type1_name": type1Name,
        "type2_name": type2Name,
        "type3_name": type3Name,
        "day": day.toJson(),
      };
}

class Day {
  Day({
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snacks,
  });

  List<Breakfast> breakfast;
  List<Breakfast> lunch;
  List<Breakfast> dinner;
  List<Breakfast> snacks;

  factory Day.fromRawJson(String str) => Day.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        breakfast: List<Breakfast>.from(
            json["breakfast"].map((x) => Breakfast.fromJson(x))),
        lunch: List<Breakfast>.from(
            json["lunch"].map((x) => Breakfast.fromJson(x))),
        dinner: List<Breakfast>.from(
            json["dinner"].map((x) => Breakfast.fromJson(x))),
        snacks: List<Breakfast>.from(
            json["snacks"].map((x) => Breakfast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "breakfast": List<dynamic>.from(breakfast.map((x) => x.toJson())),
        "lunch": List<dynamic>.from(lunch.map((x) => x.toJson())),
        "dinner": List<dynamic>.from(dinner.map((x) => x.toJson())),
        "snacks": List<dynamic>.from(snacks.map((x) => x.toJson())),
      };
}

class Breakfast {
  Breakfast({
    this.uid,
    this.name,
    this.category,
    this.description,
    this.dateAdded,
    this.coImage,
    this.cal,
    this.consumptionStatus,
  });

  String uid;
  String name;
  String category;
  String description;
  String dateAdded;
  String coImage;
  String cal;
  bool consumptionStatus;

  factory Breakfast.fromRawJson(String str) =>
      Breakfast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Breakfast.fromJson(Map<String, dynamic> json) => Breakfast(
        uid: json["uid"],
        name: json["name"],
        category: json["category"],
        description: json["description"],
        dateAdded: json["date_added"],
        coImage: json["co_image"],
        cal: json["cal"],
        consumptionStatus: json["consumption_status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "category": category,
        "description": description,
        "date_added": dateAdded,
        "co_image": coImage,
        "cal": cal,
        "consumption_status": consumptionStatus,
      };
}
