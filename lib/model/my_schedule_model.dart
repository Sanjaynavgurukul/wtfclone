// To parse this JSON data, do
//
//     final mySchedule = myScheduleFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:wtf/helper/app_constants.dart';

MySchedule myScheduleFromJson(String str) =>
    MySchedule.fromJson(json.decode(str));

String myScheduleToJson(MySchedule data) => json.encode(data.toJson());

class MySchedule {
  MySchedule({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  ScheduleData data;

  factory MySchedule.fromJson(Map<String, dynamic> json) => MySchedule(
        status: json["status"],
        message: json["message"],
        data: json.containsKey('data')
            ? ScheduleData.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ScheduleData {
  ScheduleData({
    this.regular,
    this.addon,
    this.event,
    this.addonPt,
    this.allData,
    this.addonLive,
    this.workoutAvailable,
  });

  List<MyScheduleAddonData> regular;
  List<MyScheduleAddonData> addon;
  List<MyScheduleAddonData> event;
  List<MyScheduleAddonData> addonPt;
  List<MyScheduleAddonData> addonLive;
  Map<String, List<MyScheduleAddonData>> allData;
  String workoutAvailable;

  bool hasData() =>
      (regular.isNotEmpty ||
          addon.isNotEmpty ||
          event.isNotEmpty ||
          addonPt.isNotEmpty ||
          // (addonLive != null && addonLive.isNotEmpty) ||
          (addonLive.isNotEmpty) ||
          allData.isNotEmpty) &&
      workoutAvailable != '0';
  // bool hasData() => workoutAvailable != '0';

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    Map<String, List<MyScheduleAddonData>> temp = {};
    List<MyScheduleAddonData> addon = List<MyScheduleAddonData>.from(
        json["addon"].map((x) => MyScheduleAddonData.fromJson(x)));
    List<MyScheduleAddonData> addonPt = List<MyScheduleAddonData>.from(
        json["addon_pt"].map((x) => MyScheduleAddonData.fromJson(x)));
    List<MyScheduleAddonData> regular = List<MyScheduleAddonData>.from(
        json["regular"].map((x) => MyScheduleAddonData.fromJson(x)));
    List<MyScheduleAddonData> event = List<MyScheduleAddonData>.from(
        json["event"].map((x) => MyScheduleAddonData.fromJson(x)));
    List<MyScheduleAddonData> addonLive = List<MyScheduleAddonData>.from(
        json["addon_live"].map((x) => MyScheduleAddonData.fromJson(x)));

    if (regular.isNotEmpty) {
      if (addonPt.isNotEmpty) {
        temp['Personal Training'] = addonPt;
      } else {
        temp['General Training'] = regular;
      }
    } else {
      if (addonPt.isNotEmpty) {
        temp['Personal Training'] = addonPt;
      }
    }
    if (event.isNotEmpty) {
      temp['event'] = event;
    }
    if (addon.isNotEmpty) {
      temp['addon'] = addon;
    }
    if (addonLive.isNotEmpty) {
      temp['Live Sessions'] = addonLive;
    }
    log('ALL SCHEDULE LEN:--------- $temp');
    return ScheduleData(
      regular: List<MyScheduleAddonData>.from(
          json["regular"].map((x) => MyScheduleAddonData.fromJson(x))),
      addon: List<MyScheduleAddonData>.from(
          json["addon"].map((x) => MyScheduleAddonData.fromJson(x))),
      event: List<MyScheduleAddonData>.from(
          json["event"].map((x) => MyScheduleAddonData.fromJson(x))),
      addonPt: List<MyScheduleAddonData>.from(
          json["addon_pt"].map((x) => MyScheduleAddonData.fromJson(x))),
      addonLive: List<MyScheduleAddonData>.from(
          json["addon_live"].map((x) => MyScheduleAddonData.fromJson(x))),
      allData: temp,
      workoutAvailable: json['workoutAvailable'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() => {
        "regular": List<dynamic>.from(regular.map((x) => x.toJson())),
        "addon": List<dynamic>.from(addon.map((x) => x.toJson())),
        "event": List<dynamic>.from(event.map((x) => x)),
        "addon_pt": List<dynamic>.from(addonPt.map((x) => x.toJson())),
        "addon_live": List<dynamic>.from(addonLive.map((x) => x.toJson())),
        "workoutAvailable": workoutAvailable,
      };
}

class MyScheduleAddonData {
  MyScheduleAddonData({
    this.uid,
    this.dateAdded,
    this.startDate,
    this.expireDate,
    this.coupon,
    this.type,
    this.receipt,
    this.gymname,
    this.gymUid,
    this.gymAddress1,
    this.gymType,
    this.gymAddress2,
    this.gymCity,
    this.gymState,
    this.gymPin,
    this.gymCountry,
    this.gymCoverImage,
    this.addonName,
    this.nSession,
    this.completedSession,
    this.planName,
    this.eventName,
    this.eventId,
    this.addonId,
    this.gymLat,
    this.gymLng,
    this.workoutStatus,
    this.eventType,
    this.roomId,
    this.liveClassId,
    this.roomStatus,
  });

  String uid;
  String addonId;
  String eventId;
  String dateAdded;
  DateTime startDate;
  DateTime expireDate;
  dynamic coupon;
  String type;
  String receipt;
  String gymname;
  String gymUid;
  String gymAddress1;
  String gymType;
  String gymAddress2;
  String gymCity;
  String gymState;
  String gymPin;
  String gymCountry;
  String gymLat;
  String gymLng;
  String eventType;
  bool workoutStatus;
  String gymCoverImage;
  String addonName;
  String roomStatus;
  String roomId;
  String liveClassId;
  var nSession;
  var completedSession;
  String planName;
  String eventName;

  factory MyScheduleAddonData.fromJson(Map<String, dynamic> json) {
    String img =
        json.containsKey('gym_cover_image') ? json['gym_cover_image'] : '';
    if (img.startsWith(
        'https://wtfupme-documents-1435.s3.ap-south-1.amazonaws.com/gym_upload/')) {
      img.replaceAll(
          'https://wtfupme-documents-1435.s3.ap-south-1.amazonaws.com/gym_upload/',
          AppConstants.cloudFrontDocument);
    }
    return MyScheduleAddonData(
        uid: json["uid"],
        dateAdded: json["date_added"],
        startDate: DateTime.parse(json["start_date"]),
        expireDate: DateTime.parse(json["expire_date"]),
        addonId: json['addon_id'],
        coupon: json["coupon"],
        type: json["type"],
        receipt: json["receipt"],
        gymname: json["gymname"],
        gymUid: json["gym_uid"],
        gymAddress1: json["gym_address1"],
        gymType: json["gym_type"],
        gymAddress2: json["gym_address2"],
        gymCity: json["gym_city"],
        gymState: json["gym_state"],
        gymPin: json["gym_pin"],
        eventType: json['event_type'] ?? '',
        gymCountry: json["gym_country"],
        gymCoverImage: json['gym_cover_image'],
        addonName: json["addon_name"] == null ? null : json["addon_name"],
        nSession: json["n_session"] == null ? null : json["n_session"],
        completedSession: json["completed_session"] == null
            ? null
            : json["completed_session"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        eventName: json.containsKey('event_name') ? json['event_name'] : '',
        eventId: json['event_id'] ?? '',
        gymLat: json['gym_lat'] ?? '',
        gymLng: json['gym_long'] ?? '',
        workoutStatus: json['workout_status'] ?? false,
        roomId: json['room_id'] ?? '',
        liveClassId: json['liveclass_id'] ?? '',
        roomStatus: json['room_status'] ?? 'scheduled');
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "date_added": dateAdded,
        "start_date": startDate.toIso8601String(),
        "expire_date": expireDate.toIso8601String(),
        "addon_id": addonId,
        "coupon": coupon,
        "type": type,
        "receipt": receipt,
        "gymname": gymname,
        "gym_uid": gymUid,
        "gym_address1": gymAddress1,
        "gym_type": gymType,
        "event_type": eventType,
        "gym_address2": gymAddress2,
        "gym_city": gymCity,
        "gym_state": gymState,
        "gym_pin": gymPin,
        "gym_country": gymCountry,
        "gym_cover_image": gymCoverImage,
        "addon_name": addonName == null ? null : addonName,
        "n_session": nSession == null ? null : nSession,
        "completed_session": completedSession == null ? null : completedSession,
        "plan_name": planName == null ? null : planName,
        'event_name': eventName,
        "event_id": eventId,
        "gym_lat": gymLat,
        "gym_long": gymLng,
        "workout_status": workoutStatus,
        "room_id": roomId,
        "liveclass_id": liveClassId,
      };
}
