// To parse this JSON data, do
//
//     final gymTypes = gymTypesFromJson(jsonString);

import 'dart:convert';

GymTypes gymTypesFromJson(String str) => GymTypes.fromJson(json.decode(str));

String gymTypesToJson(GymTypes data) => json.encode(data.toJson());

class GymTypes {
  GymTypes({
    this.status,
    this.pagination,
    this.data,
  });

  bool status;
  List<Pagination> pagination;
  List<GymData> data;

  factory GymTypes.fromJson(Map<String, dynamic> json) =>
      GymTypes(
        status: json["status"],
        pagination: json.containsKey('pagination')
            ? List<Pagination>.from(
            json["pagination"].map((x) => Pagination.fromJson(x)))
            : null,
        data: json.containsKey('data')
            ? List<GymData>.from(json["data"].map((x) => GymData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "pagination": pagination != null
            ? List<dynamic>.from(pagination.map((x) => x.toJson()))
            : null,
        "data": data != null && data.isNotEmpty
            ? List<dynamic>.from(pagination.map((x) => x.toJson()))
            : [],
      };
}

class Pagination {
  Pagination({
    this.pagination,
    this.limit,
    this.pages,
  });

  var pagination;
  var limit;
  var pages;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      Pagination(
        pagination: json["pagination"],
        limit: json["limit"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() =>
      {
        "pagination": pagination,
        "limit": limit,
        "pages": pages,
      };
}

class GymModel {
  bool status;
  String message;
  List<GymData> data;

  GymModel({this.status, this.message, this.data});

  factory GymModel.fromJson(Map<String, dynamic> json) {
    return GymModel(
        status: json['status'],
        data: json.containsKey('data') && json['data'] != null
            ? List<GymData>.from(json["data"].map((x) => GymData.fromJson(x)))
            : []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}


class Facility{
  String label;
  String imageUrl;
  Facility({this.label,this.imageUrl});
}

class GymData {
  String gym_id;
  String gym_name;
  String address1;
  String address2;
  String city;
  String state;
  String lat;
  String long;
  String pin;
  String country;
  String distance;
  String distance_text;
  String duration;
  String duration_text;
  int rating;
  String text1 = '';
  String text2 = '';
  String plan_text;

  String description;
  List<String> gallery;
  String coverImage;
  List<Facility> facility = [];

  GymData({
    this.gym_id,
    this.gym_name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.lat,
    this.long,
    this.pin,
    this.country,
    this.distance,
    this.distance_text,
    this.duration,
    this.duration_text,
    this.rating,
    this.text1,
    this.text2,
    this.plan_text,

    this.description,
    this.gallery,
    this.coverImage,
    this.facility,
  });

  GymData.fromJson(Map<String, dynamic> json) {
    gym_id = json['gym_id'];
    gym_name = json['gym_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    lat = json['lat'];
    long = json['long'];
    pin = json['pin'];
    country = json['country'];
    distance = json['distance'].toString();
    distance_text = json['distance_text'];
    duration = json['duration'].toString();
    duration_text = json['duration_text'];
    rating = json['rating'] ?? 0;
    text1 = json['text1'] ?? '';
    text2 = json['text2'] ?? '';
    plan_text = json['plan_text'];
    description = json['description'];
    gallery = json['gallery'];
    coverImage = json['coverImage'];
    //TODO Uncomment this code after impletemnt api facility = json['facility'];


    // uid = json['uid'];
    // gymId = json['gym_id'];
    // description = json['description'];
    // name = json['name'];
    // userId = json['user_id'];
    // gymName = json['gym_name'];
    // address1 = json['address1'];
    // address2 = json['address2'];
    // city = json['city'];
    // status = json['status'] ?? '';
    // state = json['state'];
    // country = json['country'];
    // pin = json['pin'];
    // latitude = json['latitude'];
    // longitude = json['longitude'];
    // leaseAgreement = json['lease_agreement'];
    // electricityBill = json['electricity_bill'];
    // bankStatement = json['bank_statement'] ?? '';
    // dateAdded = json['date_added'];
    // coverImage = json['cover_image'];
    // lateUpdated = json['late_updated'] != null ? json['late_updated'] : '';
    // type = json.containsKey('type') && json['type'].isNotEmpty
    //     ? json['type']
    //     : 'Gym';
    //
    // //New Variables :D
    // text1 = json['text1'] ?? '';
    // text2 = json['text2'] ?? '';
    // rating = json['rating'] ?? 0;
    // duration_text = json['duration_text'] ?? '';
    // duration = json['duration'] ?? '';
    // distanct_text = json['distanct_text'] ?? '';
    // distance = json['distance'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gym_id'] = this.gym_id;
    data['gym_name'] = this.gym_name;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['pin'] = this.pin;
    data['country'] = this.country;
    data['distance'] = this.distance;
    data['distance_text'] = this.distance_text;
    data['duration'] = this.duration;
    data['duration_text'] = this.duration_text;
    data['rating'] = this.rating;
    data['text1'] = this.text1;
    data['text2'] = this.text2;
    data['plan_text'] = this.plan_text;

    data['description'] = this.description ??'';
    data['gallery'] = this.gallery ??'';
    data['coverImage'] = this.coverImage??'';
    //TODO Uncomment this code after impletemnt api facility = json['facility'];
    // data['plan_text'] = this.plan_text;

    // data['uid'] = this.uid;
    // data['gym_id'] = this.gymId;
    // data['description'] = this.description;
    // data['name'] = this.name;
    // data['user_id'] = this.userId;
    // data['gym_name'] = this.gymName;
    // data['address1'] = this.address1;
    // data['address2'] = this.address2;
    // data['city'] = this.city;
    // data['state'] = this.state;
    // data['status'] = this.status;
    // data['country'] = this.country;
    // data['pin'] = this.pin;
    // data['latitude'] = this.latitude;
    // data['longitude'] = this.longitude;
    // data['lease_agreement'] = this.leaseAgreement;
    // data['electricity_bill'] = this.electricityBill;
    // data['bank_statement'] = this.bankStatement;
    // data['date_added'] = this.dateAdded;
    // data['late_updated'] = this.lateUpdated;
    // data['cover_image'] = this.coverImage;

    // //New Variables :D
    // data['text1'] = this.rating;
    // data['text2'] = this.text2;
    // data['rating'] = this.rating;
    // data['duration_text'] = this.duration_text;
    // data['duration'] = this.duration;
    // data['distanct_text'] = this.distanct_text;
    // data['distance'] = this.distance;
    return data;
  }
}

class GymDataa {
  String uid;
  String gymId;
  String description;
  String name;
  String userId;
  String gymName;
  String type;
  String status;
  String address1;
  String address2;
  String city;
  String state;
  String country;
  String pin;
  String latitude;
  String longitude;
  String leaseAgreement;
  String electricityBill;
  String bankStatement;
  String coverImage;
  String dateAdded;
  String lateUpdated;

  // //New Variables :D
  // String text1;
  // String text2;
  double rating;

  // String duration_text;
  // String duration;
  // String distanct_text;
  // String distance;

  GymDataa({
    this.uid,
    this.gymId,
    this.description,
    this.name,
    this.userId,
    this.gymName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.pin,
    this.latitude,
    this.longitude,
    this.leaseAgreement,
    this.electricityBill,
    this.bankStatement,
    this.dateAdded,
    this.lateUpdated,
    this.coverImage,
    this.type,
    this.status,

    // //New variables
    // this.text1,
    // this.text2,
    // this.rating,
    // this.duration_text,
    // this.duration,
    // this.distanct_text,
    // this.distance,
  });

  GymDataa.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    gymId = json['gym_id'];
    description = json['description'];
    name = json['name'];
    userId = json['user_id'];
    gymName = json['gym_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    status = json['status'] ?? '';
    state = json['state'];
    country = json['country'];
    pin = json['pin'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    leaseAgreement = json['lease_agreement'];
    electricityBill = json['electricity_bill'];
    bankStatement = json['bank_statement'] ?? '';
    dateAdded = json['date_added'];
    coverImage = json['cover_image'];
    lateUpdated = json['late_updated'] != null ? json['late_updated'] : '';
    type = json.containsKey('type') && json['type'].isNotEmpty
        ? json['type']
        : 'Gym';
    //
    // //New Variables :D
    // text1 = json['text1'] ?? '';
    // text2 = json['text2'] ?? '';
    // rating = json['rating'] ?? 0;
    // duration_text = json['duration_text'] ?? '';
    // duration = json['duration'] ?? '';
    // distanct_text = json['distanct_text'] ?? '';
    // distance = json['distance'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['gym_id'] = this.gymId;
    data['description'] = this.description;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['gym_name'] = this.gymName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['status'] = this.status;
    data['country'] = this.country;
    data['pin'] = this.pin;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['lease_agreement'] = this.leaseAgreement;
    data['electricity_bill'] = this.electricityBill;
    data['bank_statement'] = this.bankStatement;
    data['date_added'] = this.dateAdded;
    data['late_updated'] = this.lateUpdated;
    data['cover_image'] = this.coverImage;

    // //New Variables :D
    // data['text1'] = this.rating;
    // data['text2'] = this.text2;
    // data['rating'] = this.rating;
    // data['duration_text'] = this.duration_text;
    // data['duration'] = this.duration;
    // data['distanct_text'] = this.distanct_text;
    // data['distance'] = this.distance;
    return data;
  }
}
