// To parse this JSON data, do
//
//     final memberDetails = memberDetailsFromJson(jsonString);

import 'dart:convert';

MemberDetails memberDetailsFromJson(String str) =>
    MemberDetails.fromJson(json.decode(str));

String memberDetailsToJson(MemberDetails data) => json.encode(data.toJson());

class MemberDetails {
  MemberDetails({
    this.status,
    this.data,
  });

  bool status;
  MemberData data;

  factory MemberDetails.fromJson(Map<String, dynamic> json) => MemberDetails(
        status: json["status"],
        data: MemberData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class MemberData {
  MemberData({
    this.uid,
    this.name,
    this.userId,
    this.height,
    this.weight,
    this.targetWeight,
    this.targetDuration,
    this.location,
    this.lat,
    this.long,
    this.bodyType,
    this.existingDisease,
    this.isSmoking,
    this.isDrinking,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.howActive,
    this.dietcategoryid,
  });

  String uid;
  String name;
  String userId;
  String height;
  String weight;
  String targetWeight;
  String targetDuration;
  String location;
  String lat;
  String long;
  String bodyType;
  String howActive;
  String existingDisease;
  String isSmoking;
  String isDrinking;
  String status;
  String dateAdded;
  dynamic lastUpdated;
  String dietcategoryid;

  factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
        uid: json["uid"],
        name: json["name"],
        userId: json["user_id"],
        height: json["height"],
        weight: json["weight"],
        targetWeight: json["target_weight"],
        targetDuration: json["target_duration"],
        location: json["location"],
        lat: json["lat"],
        long: json["long"],
        bodyType: json["body_type"],
        existingDisease: json["existing_disease"],
        isSmoking: json["is_smoking"],
        isDrinking: json["is_drinking"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        howActive: json["howactive"],
        dietcategoryid: json["diet_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "user_id": userId,
        "height": height,
        "weight": weight,
        "target_weight": targetWeight,
        "target_duration": targetDuration,
        "location": location,
        "lat": lat,
        "long": long,
        "body_type": bodyType,
        "existing_disease": existingDisease,
        "is_smoking": isSmoking,
        "is_drinking": isDrinking,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "diet_category_id": dietcategoryid,
      };
}
