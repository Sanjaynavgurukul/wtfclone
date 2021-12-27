// To parse this JSON data, do
//
//     final gymAddOn = gymAddOnFromJson(jsonString);

import 'dart:convert';

GymAddOn gymAddOnFromJson(String str) => GymAddOn.fromJson(json.decode(str));

String gymAddOnToJson(GymAddOn data) => json.encode(data.toJson());

class GymAddOn {
  GymAddOn({
    this.status,
    this.data,
  });

  bool status;
  List<AddOnData> data;

  factory GymAddOn.fromJson(Map<String, dynamic> json) => GymAddOn(
        status: json["status"],
        data: json.containsKey('data')
            ? List<AddOnData>.from(
                json["data"].map((x) => AddOnData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AddOnData {
  AddOnData({
    this.uid,
    this.name,
    this.gymId,
    this.description,
    this.image,
    this.price,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.isPt,
  });

  String uid;
  String name;
  String gymId;
  String description;
  String image;
  String isPt;
  String price;
  String status;
  String dateAdded;
  dynamic lastUpdated;

  factory AddOnData.fromJson(Map<String, dynamic> json) => AddOnData(
        uid: json["uid"],
        name: json["name"],
        gymId: json["gym_id"],
        description: json["description"],
        image: json["image"] == null ? null : json["image"],
        price: json["price"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        isPt: json['is_pt'] != null ? json['is_pt'] : '0',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "gym_id": gymId,
        "description": description,
        "image": image == null ? null : image,
        "price": price,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "is_pt": isPt,
      };
}
