// To parse this JSON data, do
//
//     final whyChooseWtf = whyChooseWtfFromJson(jsonString);

import 'dart:convert';

WhyChooseWtf whyChooseWtfFromJson(String str) =>
    WhyChooseWtf.fromJson(json.decode(str));

String whyChooseWtfToJson(WhyChooseWtf data) => json.encode(data.toJson());

class WhyChooseWtf {
  WhyChooseWtf({
    this.status,
    this.data,
  });

  bool status;
  List<WhyChooseWtfData> data;

  factory WhyChooseWtf.fromJson(Map<String, dynamic> json) => WhyChooseWtf(
        status: json["status"],
        data: List<WhyChooseWtfData>.from(
            json["data"].map((x) => WhyChooseWtfData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WhyChooseWtfData {
  WhyChooseWtfData({
    this.uid,
    this.name,
    this.icon,
    this.dateAdded,
    this.lastUpdated,
    this.status,
  });

  String uid;
  String name;
  String icon;
  String dateAdded;
  dynamic lastUpdated;
  String status;

  factory WhyChooseWtfData.fromJson(Map<String, dynamic> json) =>
      WhyChooseWtfData(
        uid: json["uid"],
        name: json["name"],
        icon: json["icon"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "icon": icon,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "status": status,
      };
}
