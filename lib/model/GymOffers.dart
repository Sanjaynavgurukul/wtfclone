// To parse this JSON data, do
//
//     final gymOffers = gymOffersFromJson(jsonString);

import 'dart:convert';

GymOffers gymOffersFromJson(String str) => GymOffers.fromJson(json.decode(str));

String gymOffersToJson(GymOffers data) => json.encode(data.toJson());

class GymOffers {
  GymOffers({
    this.status,
    // this.pagination,
    this.data,
  });

  bool status;

  // List<Pagination> pagination;
  List<OfferData> data;

  factory GymOffers.fromJson(Map<String, dynamic> json) => GymOffers(
        status: json["status"],
        // pagination: List<Pagination>.from(
        //     json["pagination"].map((x) => Pagination.fromJson(x))),
        data: json.containsKey('data') && json['data'] != null
            ? List<OfferData>.from(
                json["data"].map((x) => OfferData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "pagination": List<dynamic>.from(pagination.map((x) => x.toJson())),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OfferData {
  OfferData(
      {this.uid,//
      this.gymId,//
      this.name,//
      this.code,//
      this.validity,//
      this.mode,//
      this.type,//
      this.value,//
      this.status,//
      this.dateAdded,//
      this.lastUpdated,//
      this.gym_name,
      this.is_public,
      this.is_trigger,
      this.offer_type,
      this.type_id,
      this.type_name});

  String uid;
  String gymId;
  String name;
  String code;
  String validity;
  String mode;
  String type;
  String value;
  String status;
  String dateAdded;

  int is_trigger;
  String offer_type;
  String type_id;
  int is_public;
  String gym_name;
  String type_name;

  dynamic lastUpdated;

  factory OfferData.fromJson(Map<String, dynamic> json) => OfferData(
        uid: json["uid"],
        gymId: json["gym_id"],
        name: json["name"],
        code: json["code"],
        validity: json["validity"],
        mode: json["mode"],
        type: json["type"],
        value: json["value"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        is_trigger: json["is_trigger"],
        offer_type: json["offer_type"],
        type_id: json["type_id"],
        is_public: int.parse(json["is_public"].toString() ?? '0'),
        gym_name: json["gym_name"] == null ? '':json["gym_name"],
        type_name: json["type_name"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "gym_id": gymId,
        "name": name,
        "code": code,
        "validity": validity,
        "mode": mode,
        "type": type,
        "value": value,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "is_trigger": is_trigger,
        "offer_type": offer_type,
        "type_id": type_id,
        "is_public": is_public,
        "gym_name": gym_name,
        "type_name": type_name,
      };
}

class Pagination {
  Pagination({
    this.pagination,
    this.limit,
    this.pages,
  });

  int pagination;
  int limit;
  int pages;

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
