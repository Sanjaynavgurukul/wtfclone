// To parse this JSON data, do
//
//     final allNotifications = allNotificationsFromJson(jsonString);

import 'dart:convert';

AllNotifications allNotificationsFromJson(String str) =>
    AllNotifications.fromJson(json.decode(str));

String allNotificationsToJson(AllNotifications data) =>
    json.encode(data.toJson());

class AllNotifications {
  AllNotifications({
    this.status,
    this.data,
  });

  bool status;
  List<NotificationData> data;

  factory AllNotifications.fromJson(Map<String, dynamic> json) =>
      AllNotifications(
        status: json["status"],
        data: List<NotificationData>.from(
          json["data"].map(
            (x) => NotificationData.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(
          data.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class NotificationData {
  NotificationData({
    this.id,
    this.uid,
    this.userId,
    this.mode,
    this.title,
    this.status,
    this.dateAdded,
    this.date,
    this.description,
  });

  int id;
  String uid;
  String userId;
  String mode;
  String title;
  String status;
  String dateAdded;
  String date;
  String description;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"],
        uid: json["uid"],
        userId: json["user_id"],
        mode: json["mode"],
        title: json["title"],
        status: json["status"],
        dateAdded: json["date_added"],
        date: json["date"],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "user_id": userId,
        "mode": mode,
        "title": title,
        "status": status,
        "date_added": dateAdded,
        "date": date,
        'description': description,
      };
}
