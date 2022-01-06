// To parse this JSON data, do
//
//     final addOnSlotDetails = addOnSlotDetailsFromJson(jsonString);

import 'dart:convert';

AddOnSlotDetails addOnSlotDetailsFromJson(String str) =>
    AddOnSlotDetails.fromJson(json.decode(str));

String addOnSlotDetailsToJson(AddOnSlotDetails data) =>
    json.encode(data.toJson());

class AddOnSlotDetails {
  AddOnSlotDetails({
    this.status,
    this.data,
  });

  bool status;
  List<AddOnSlotDetailsData> data;

  factory AddOnSlotDetails.fromJson(Map<String, dynamic> json) =>
      AddOnSlotDetails(
        status: json["status"],
        data: List<AddOnSlotDetailsData>.from(
            json["data"].map((x) => AddOnSlotDetailsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AddOnSlotDetailsData {
  AddOnSlotDetailsData({
    this.key,
    this.data,
  });

  String key;
  List<SlotData> data;

  factory AddOnSlotDetailsData.fromJson(Map<String, dynamic> json) {
    String key = '';
    if (json['key'] == '5-8') {
      key = '5AM - 8AM';
    } else if (json['key'] == '8-11') {
      key = '8AM - 11AM';
    } else if (json['key'] == '11-14') {
      key = '11AM - 2PM';
    } else if (json['key'] == '14-17') {
      key = '2PM - 5PM';
    } else if (json['key'] == '17-20') {
      key = '5PM - 8PM';
    } else if (json['key'] == '20-23') {
      key = '8PM - 11PM';
    } else {
      key = 'Other';
    }
    return AddOnSlotDetailsData(
      key: key ?? 'n/a',
      data: List<SlotData>.from(json["data"].map((x) => SlotData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SlotData {
  SlotData({
    this.id,
    this.uid,
    this.gymId,
    this.trainerId,
    this.startTime,
    this.endTime,
    this.slot,
    this.lastUpdated,
    this.status,
    this.dateAdded,
    this.addonsId,
    this.date,
  });

  int id;
  String uid;
  String gymId;
  String trainerId;
  String startTime;
  String endTime;
  String slot;
  dynamic lastUpdated;
  String status;
  String dateAdded;
  String addonsId;
  DateTime date;

  factory SlotData.fromJson(Map<String, dynamic> json) {
    String temp = json['start_time'];
    String temp2 = '';
    switch (temp.split(':')[0]) {
      case '00':
        temp2 = '12';
        break;
      case '01':
        temp2 = '01';
        break;
      case '02':
        temp2 = '02';
        break;
      case '03':
        temp2 = '03';
        break;
      case '04':
        temp2 = '04';
        break;
      case '05':
        temp2 = '05';
        break;
      case '06':
        temp2 = '06';
        break;
      case '07':
        temp2 = '07';
        break;
      case '08':
        temp2 = '08';
        break;
      case '09':
        temp2 = '09';
        break;
      case '10':
        temp2 = '10';
        break;
      case '11':
        temp2 = '11';
        break;
      case '12':
        temp2 = '12';
        break;
      case '13':
        temp2 = '01';
        break;
      case '14':
        temp2 = '02';
        break;
      case '15':
        temp2 = '03';
        break;
      case '16':
        temp2 = '04';
        break;
      case '17':
        temp2 = '05';
        break;
      case '18':
        temp2 = '06';
        break;
      case '19':
        temp2 = '07';
        break;
      case '20':
        temp2 = '08';
        break;
      case '21':
        temp2 = '09';
        break;
      case '22':
        temp2 = '10';
        break;
      case '23':
        temp2 = '11';
        break;
      case '24':
        temp2 = '12';
        break;
    }

    return SlotData(
      id: json["id"],
      uid: json["uid"],
      gymId: json["gym_id"],
      trainerId: json["trainer_id"],
      startTime: '$temp2:${temp.split(':')[1]}',
      endTime: json["end_time"],
      slot: json["slot"],
      lastUpdated: json["last_updated"],
      status: json["status"],
      dateAdded: json["date_added"],
      addonsId: json["addons_id"],
      date: DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "gym_id": gymId,
        "trainer_id": trainerId,
        "start_time": startTime,
        "end_time": endTime,
        "slot": slot,
        "last_updated": lastUpdated,
        "status": status,
        "date_added": dateAdded,
        "addons_id": addonsId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
