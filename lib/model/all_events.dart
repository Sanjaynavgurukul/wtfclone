// To parse this JSON data, do
//
//     final allEvents = allEventsFromJson(jsonString);

import 'dart:convert';

AllEvents allEventsFromJson(String str) => AllEvents.fromJson(json.decode(str));

String allEventsToJson(AllEvents data) => json.encode(data.toJson());

class AllEvents {
  AllEvents({
    this.status,
    this.pagination,
    this.data,
  });

  bool status;
  List<Pagination> pagination;
  List<EventsData> data;

  factory AllEvents.fromJson(Map<String, dynamic> json) => AllEvents(
        status: json["status"],
        pagination: json.containsKey('pagination')
            ? List<Pagination>.from(
                json["pagination"].map((x) => Pagination.fromJson(x)))
            : null,
        data: json.containsKey('data')
            ? List<EventsData>.from(
                json["data"].map((x) => EventsData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pagination": List<dynamic>.from(pagination.map((x) => x.toJson())),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EventsData {
  EventsData({
    this.uid,
    this.name,
    this.date,
    this.mode,
    this.image,
    this.isPublic,
    this.description,
    this.price,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.validFrom,
    this.validTo,
    this.gymId,
    this.gymUid,
    this.gymAddress1,
    this.gymAddress2,
    this.gymCity,
    this.gymState,
    this.gymPin,
    this.gymCountry,
    this.gymCoverImage,
    this.gymType,
    this.gymName,
    this.timeFrom,
    this.timeTo,
    this.gymLat,
    this.gymLong,
  });

  String uid;
  String name;
  String date;
  String mode;
  String image;
  String isPublic;
  String description;
  String price;
  String status;
  String dateAdded;
  String lastUpdated;
  String validFrom;
  String timeFrom;
  String validTo;
  String timeTo;
  String gymId;
  String gymUid;
  String gymLat;
  String gymLong;
  String gymAddress1;
  String gymAddress2;
  String gymCity;
  String gymState;
  String gymPin;
  String gymCountry;
  String gymCoverImage;
  String gymType;
  String gymName;

  factory EventsData.fromJson(Map<String, dynamic> json) => EventsData(
        uid: json["uid"],
        name: json["name"],
        date: json["date"],
        mode: json["mode"],
        image: json["image"],
        isPublic: json["is_public"],
        description: json["description"],
        price: json["price"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        validFrom: json["valid_from"],
        validTo: json["valid_to"],
        gymId: json["gym_id"],
        gymUid: json["gym_uid"],
        gymAddress1: json["gym_address1"],
        gymAddress2: json["gym_address2"],
        gymCity: json["gym_city"],
        gymState: json["gym_state"],
        gymPin: json["gym_pin"],
        gymCountry: json["gym_country"],
        gymCoverImage: json["gym_cover_image"],
        gymType: json["gym_type"],
        gymName: json["gym_name"],
        timeFrom: json['time_from'] ?? '',
        timeTo: json['time_to'] ?? '',
        gymLat: json['gym_lat'] ?? '28.576639',
        gymLong: json['gym_long'] ?? '77.388474',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "date": date,
        "mode": mode,
        "image": image,
        "is_public": isPublic,
        "description": description,
        "price": price,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "valid_from": validFrom,
        "valid_to": validTo,
        "gym_id": gymId,
        "gym_uid": gymUid,
        "gym_address1": gymAddress1,
        "gym_address2": gymAddress2,
        "gym_city": gymCity,
        "gym_state": gymState,
        "gym_pin": gymPin,
        "gym_country": gymCountry,
        "gym_cover_image": gymCoverImage,
        "gym_type": gymType,
        "gym_name": gymName,
        "time_from": timeFrom,
        "time_to": timeTo,
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
