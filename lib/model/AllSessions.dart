// To parse this JSON data, do
//
//     final allSessions = allSessionsFromJson(jsonString);

import 'dart:convert';

AllSessions allSessionsFromJson(String str) =>
    AllSessions.fromJson(json.decode(str));

String allSessionsToJson(AllSessions data) => json.encode(data.toJson());

class AllSessions {
  AllSessions({
    this.status,
    this.data,
  });

  bool status;
  List<SessionData> data;

  factory AllSessions.fromJson(Map<String, dynamic> json) => AllSessions(
        status: json["status"],
        data: json['data'] != null
            ? List<SessionData>.from(
                json["data"].map((x) => SessionData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SessionData {
  SessionData({
    this.id,
    this.uid,
    this.addon,
    this.nSession,
    this.price,
    this.status,
    this.dateAdded,
    this.duration,
  });

  int id;
  String uid;
  String addon;
  String nSession;
  String price;
  String status;
  String dateAdded;
  String duration;

  factory SessionData.fromJson(Map<String, dynamic> json) => SessionData(
        id: json["id"],
        uid: json["uid"],
        addon: json["addon"],
        nSession: json["n_session"],
        price: json["price"],
        status: json["status"],
        dateAdded: json["date_added"],
        duration: json['duration'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "addon": addon,
        "n_session": nSession,
        "price": price,
        "status": status,
        "date_added": dateAdded,
      };
}
