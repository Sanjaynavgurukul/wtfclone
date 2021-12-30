// To parse this JSON data, do
//
//     final redeemHistory = redeemHistoryFromJson(jsonString);

import 'dart:convert';

class RedeemHistory {
  RedeemHistory({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory RedeemHistory.fromRawJson(String str) =>
      RedeemHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RedeemHistory.fromJson(Map<String, dynamic> json) => RedeemHistory(
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
    this.uid,
    this.label,
    this.offerName,
    this.offerDetails,
    this.offerCode,
    this.coins,
    this.dateAdded,
  });

  String uid;
  String label;
  dynamic offerName;
  dynamic offerDetails;
  dynamic offerCode;
  int coins;
  DateTime dateAdded;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uid: json["uid"],
        label: json["label"],
        offerName: json["offer_name"],
        offerDetails: json["offer_details"],
        offerCode: json["offer_code"],
        coins: json["coins"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "label": label,
        "offer_name": offerName,
        "offer_details": offerDetails,
        "offer_code": offerCode,
        "coins": coins,
        "date_added": dateAdded.toIso8601String(),
      };
}
