// To parse this JSON data, do
//
//     final coinHistory = coinHistoryFromJson(jsonString);

import 'dart:convert';

CoinHistory coinHistoryFromJson(String str) =>
    CoinHistory.fromJson(json.decode(str));

String coinHistoryToJson(CoinHistory data) => json.encode(data.toJson());

class CoinHistory {
  CoinHistory({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory CoinHistory.fromJson(Map<String, dynamic> json) => CoinHistory(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.uid,
    this.userId,
    this.label,
    this.coins,
    this.type,
    this.status,
    this.dateAdded,
  });

  int id;
  String uid;
  String userId;
  String label;
  int coins;
  String type;
  String status;
  String dateAdded;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        uid: json["uid"],
        userId: json["user_id"],
        label: json["label"],
        coins: json["coins"],
        type: json["type"],
        status: json["status"],
        dateAdded: json["date_added"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "user_id": userId,
        "label": label,
        "coins": coins,
        "type": type,
        "status": status,
        "date_added": dateAdded,
      };
}
