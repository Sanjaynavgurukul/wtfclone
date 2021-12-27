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
  OfferData({
    this.uid,
    this.gymId,
    this.name,
    this.code,
    this.validity,
    this.mode,
    this.type,
    this.value,
    this.status,
    this.dateAdded,
    this.lastUpdated,
  });

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
