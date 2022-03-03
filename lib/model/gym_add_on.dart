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

  factory GymAddOn.fromJson(Map<String, dynamic> json) {
    List<AddOnData> temp = [];
    if (json.containsKey('data') && json['data'] != null) {
      for (var x in json['data']) {
        if (x['status'] != 'inactive') {
          temp.add(AddOnData.fromJson(x));
        }
      }
    }
    return GymAddOn(
      status: json["status"],
      data: json.containsKey('data') ? temp : [],
    );
  }

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
    this.isLive,
    this.gymName,
    this.freeSession,
  });

  String uid;
  String name;
  String gymId;
  String description;
  String image;
  int isPt;
  String price;
  bool isLive;
  String freeSession;
  String gymName;
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
      isPt: int.parse(json['is_pt']),
      gymName: json['gym_name'] ?? '',
      freeSession: json['free_seesion'] ?? '',
      isLive: json['is_live'] ?? false);

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
        "is_live": isLive,
        'gym_name': gymName,
        'free_seesion': freeSession,
      };
}
