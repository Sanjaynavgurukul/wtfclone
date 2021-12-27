// To parse this JSON data, do
//
//     final checkEventParticipation = checkEventParticipationFromJson(jsonString);

import 'dart:convert';

CheckEventParticipation checkEventParticipationFromJson(String str) =>
    CheckEventParticipation.fromJson(json.decode(str));

String checkEventParticipationToJson(CheckEventParticipation data) =>
    json.encode(data.toJson());

class CheckEventParticipation {
  CheckEventParticipation({
    this.status,
    this.data,
  });

  bool status;
  EventParticipationData data;

  factory CheckEventParticipation.fromJson(Map<String, dynamic> json) =>
      CheckEventParticipation(
        status: json["status"],
        data: EventParticipationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class EventParticipationData {
  EventParticipationData({
    this.id,
    this.uid,
    this.eventId,
    this.memberId,
    this.dateAdded,
    this.dateCheckedin,
    this.status,
  });

  int id;
  String uid;
  String eventId;
  String memberId;
  String dateAdded;
  DateTime dateCheckedin;
  String status;

  factory EventParticipationData.fromJson(Map<String, dynamic> json) =>
      EventParticipationData(
        id: json["id"],
        uid: json["uid"],
        eventId: json["event_id"],
        memberId: json["member_id"],
        dateAdded: json["date_added"],
        dateCheckedin: json["date_checkedin"] != null
            ? DateTime.parse(json["date_checkedin"])
            : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "event_id": eventId,
        "member_id": memberId,
        "date_added": dateAdded,
        "date_checkedin": dateCheckedin.toIso8601String(),
        "status": status,
      };
}
