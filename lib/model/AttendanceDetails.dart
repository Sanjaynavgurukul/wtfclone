// To parse this JSON data, do
//
//     final attendanceDetails = attendanceDetailsFromJson(jsonString);

import 'dart:convert';

AttendanceDetails attendanceDetailsFromJson(String str) =>
    AttendanceDetails.fromJson(json.decode(str));

String attendanceDetailsToJson(AttendanceDetails data) =>
    json.encode(data.toJson());

class AttendanceDetails {
  AttendanceDetails({
    this.data,
    this.status,
  });

  AttendanceDetailsData data;
  bool status;

  factory AttendanceDetails.fromJson(Map<String, dynamic> json) =>
      AttendanceDetails(
        data: AttendanceDetailsData.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
      };
}

class AttendanceDetailsData {
  AttendanceDetailsData({
    this.id,
    this.uid,
    this.userId,
    this.mode,
    this.date,
    this.time,
    this.location,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.role,
    this.qrCode,
    this.long,
  });

  int id;
  String uid;
  String userId;
  String mode;
  String date;
  String time;
  String location;
  String status;
  String dateAdded;
  dynamic lastUpdated;
  String role;
  String qrCode;
  String long;

  factory AttendanceDetailsData.fromJson(Map<String, dynamic> json) =>
      AttendanceDetailsData(
        id: json["id"],
        uid: json["uid"],
        userId: json["user_id"],
        mode: json["mode"],
        date: json["date"],
        time: json["time"],
        location: json["location"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        role: json["role"],
        qrCode: json["qr_code"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "user_id": userId,
        "mode": mode,
        "date": date,
        "time": time,
        "location": location,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "role": role,
        "qr_code": qrCode,
        "long": long,
      };
}
