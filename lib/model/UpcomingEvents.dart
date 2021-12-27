// To parse this JSON data, do
//
//     final upcomingEvents = upcomingEventsFromJson(jsonString);

import 'dart:convert';

UpcomingEvents upcomingEventsFromJson(String str) =>
    UpcomingEvents.fromJson(json.decode(str));

String upcomingEventsToJson(UpcomingEvents data) => json.encode(data.toJson());

class UpcomingEvents {
  UpcomingEvents({
    this.status,
    this.data,
  });

  bool status;
  List<UpcomingEventsData> data;

  factory UpcomingEvents.fromJson(Map<String, dynamic> json) => UpcomingEvents(
        status: json["status"],
        data: List<UpcomingEventsData>.from(
            json["data"].map((x) => UpcomingEventsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UpcomingEventsData {
  UpcomingEventsData({
    this.id,
    this.uid,
    this.gymId,
    this.userId,
    this.price,
    this.trxId,
    this.trxStatus,
    this.taxPercentage,
    this.taxAmount,
    this.orderStatus,
    this.dateAdded,
    this.slotId,
    this.addon,
    this.startDate,
    this.expireDate,
    this.coupon,
    this.planId,
    this.remark,
    this.type,
    this.eventId,
    this.eventName,
    this.eventDate,
    this.eventMode,
    this.eventImage,
    this.eventIsPublic,
    this.eventDescription,
    this.eventPrice,
    this.eventStatus,
    this.startTime,
    this.endTime,
    this.gymLng,
    this.gymLat,
    this.gymName,
    this.gymAddress1,
    this.gymAddress2,
  });

  int id;
  String uid;
  String gymId;
  String userId;
  var price;
  String trxId;
  String trxStatus;
  String taxPercentage;
  var taxAmount;
  String orderStatus;
  String dateAdded;
  String slotId;
  String addon;
  DateTime startDate;
  String startTime;
  String endTime;
  DateTime expireDate;
  dynamic coupon;
  dynamic planId;
  String remark;
  String type;
  String eventId;
  String eventName;
  DateTime eventDate;
  String eventMode;
  String eventImage;
  String eventIsPublic;
  String eventDescription;
  var eventPrice;
  String eventStatus;
  String gymName;
  String gymAddress1;
  String gymAddress2;
  String gymLat;
  String gymLng;

  factory UpcomingEventsData.fromJson(Map<String, dynamic> json) =>
      UpcomingEventsData(
        id: json["id"],
        uid: json["uid"],
        gymId: json["gym_id"],
        userId: json["user_id"],
        price: json["price"],
        trxId: json["trx_id"],
        trxStatus: json["trx_status"],
        taxPercentage: json["tax_percentage"],
        taxAmount: json["tax_amount"],
        orderStatus: json["order_status"],
        dateAdded: json["date_added"],
        slotId: json["slot_id"],
        addon: json["addon"],
        startDate: DateTime.parse(json["start_date"]),
        expireDate: DateTime.parse(json["expire_date"]),
        coupon: json["coupon"],
        planId: json["plan_id"],
        remark: json["remark"],
        type: json["type"],
        eventId: json["event_id"],
        eventName: json["event_name"],
        eventDate: DateTime.parse(json["event_date"]),
        eventMode: json["event_mode"],
        eventImage: json["event_image"],
        eventIsPublic: json["event_is_public"],
        eventDescription: json["event_description"],
        eventPrice: json["event_price"],
        eventStatus: json["event_status"],
        endTime: json['end_time'],
        startTime: json['start_time'],
        gymLat: json['gym_name'] ?? '',
        gymName: json['gym_name'] ?? '',
        gymAddress1: json['gym_address1'] ?? '',
        gymAddress2: json['gym_address2'] ?? '',
        gymLng: json['gym_lat'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "gym_id": gymId,
        "user_id": userId,
        "price": price,
        "trx_id": trxId,
        "trx_status": trxStatus,
        "tax_percentage": taxPercentage,
        "tax_amount": taxAmount,
        "order_status": orderStatus,
        "date_added": dateAdded,
        "slot_id": slotId,
        "addon": addon,
        "start_date": startDate.toIso8601String(),
        "expire_date": expireDate.toIso8601String(),
        "coupon": coupon,
        "plan_id": planId,
        "remark": remark,
        "type": type,
        "event_id": eventId,
        "event_name": eventName,
        "event_date":
            "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
        "event_mode": eventMode,
        "event_image": eventImage,
        "event_is_public": eventIsPublic,
        "event_description": eventDescription,
        "event_price": eventPrice,
        "event_status": eventStatus,
        "gym_name": gymName,
        "gym_address1": gymAddress1,
        "gym_address2": gymAddress2,
        "gym_lat": gymLat,
        "gym_long": gymLng,
      };
}
