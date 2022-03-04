// To parse this JSON data, do
//
//     final gymTypes = gymTypesFromJson(jsonString);

import 'dart:convert';

import 'package:wtf/model/gym_details_model.dart';

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
  List<GymModelData> data;

  factory GymTypes.fromJson(Map<String, dynamic> json) =>
      GymTypes(
        status: json["status"],
        pagination: json.containsKey('pagination')
            ? List<Pagination>.from(
            json["pagination"].map((x) => Pagination.fromJson(x)))
            : null,
        data: json.containsKey('data')
            ? List<GymModelData>.from(json["data"].map((x) => GymModelData.fromJson(x)))
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
  List<GymModelData> data;

  GymModel({this.status, this.message, this.data});

  factory GymModel.fromJson(Map<String, dynamic> json) {
    return GymModel(
        status: json['status'],
        data: json.containsKey('data') && json['data'] != null
            ? List<GymModelData>.from(json["data"].map((x) => GymModelData.fromJson(x)))
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

class GymModelData {

  String uid;
  String userId;
  String description;
  String name;
  String gymName;
  String address1;
  String address2;
  String city;
  String state;
  String country;
  String pin;
  String latitude = '';
  String longitude = '';
  String leaseAgreement;
  String electricityBill;
  String bankStatement;
  String dateAdded;
  List<Gallery> gallery;
  List<Benfit> benefits;
  dynamic lastUpdated;
  String status;
  String planType;
  String cover_image;

  //New Variables :D
  String distance;
  String distance_text;
  String duration;
  String duration_text;
  String text1 = '';
  String text2 = '';
  String plan_text;
  double rating;

  String plan_name;
  String plan_duration;
  String plan_price='';
  String plan_description;

  //Static Variable
  bool isFullPayment = true;
  String first_payment;
  String first_payment_amount;
  String second_payment;
  String second_payment_amount;
  String third_payment;
  String third_payment_amount;

  GymModelData({
    this.uid,
    this.description,
    this.name,
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
    this.cover_image,
    this.bankStatement,
    this.dateAdded,
    this.lastUpdated,
    this.status,
    this.planType,
    this.userId,
    this.benefits,
    this.gallery,
    //New Variables :D
    this.distance,
    this.distance_text,
    this.duration,
    this.duration_text,
    this.text1,
    this.text2,
    this.plan_text,
    this.rating,

    this.plan_name,
    this.plan_duration,
    this.plan_price,
    this.plan_description,

    //Static Variable
    this.first_payment,
    this.first_payment_amount,
    this.second_payment,
    this.second_payment_amount,
    this.third_payment,
    this.third_payment_amount,
  });

  factory GymModelData.fromJson(Map<String, dynamic> json) => GymModelData(
    uid: json["uid"],
    userId: json["user_id"],
    description: json["description"],
    name: json["name"],
    gymName: json["gym_name"],
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pin: json["pin"],
    cover_image: json["cover_image"],
    latitude: json["lat"],
    longitude: json["long"],
    leaseAgreement: json["lease_agreement"],
    electricityBill: json["electricity_bill"],
    bankStatement: json["bank_statement"],
    dateAdded: json["date_added"],
    lastUpdated: json["last_updated"],
    status: json["status"],
    planType: json["plan_type"],
    gallery: json.containsKey('gallery') && json['gallery'] != null
        ? List<Gallery>.from(
        json["gallery"].map((x) => Gallery.fromJson(x)))
        : [],
    // equipment: List<Equipment>.from(
    //     json["equipment"].map((x) => Equipment.fromJson(x))),
    benefits: json.containsKey('benefits') && json['benefits'] != null
        ? List<Benfit>.from(json["benefits"].map((x) => Benfit.fromJson(x)))
        : [],

    //New Variables :D
    distance: json["distance"].toString(),
    distance_text: json["distance_text"],
    duration: json["duration"].toString(),
    duration_text: json["duration_text"],
    text1: json["text1"],
    text2: json["text2"],
    plan_text: json["plan_text"],
    rating: json["rating"].toDouble(),

    plan_name: json["plan_name"],
    plan_duration: json["plan_duration"],
    plan_price: json["plan_price"],
    plan_description: json["plan_description"],

    first_payment: json["first_payment"],
    first_payment_amount: json["first_payment_amount"],
    second_payment: json["second_payment"],
    second_payment_amount: json["second_payment_amount"],
    third_payment: json["third_payment"],
    third_payment_amount: json["third_payment_amount"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "description": description,
    "name": name,
    "gym_name": gymName,
    "address1": address1,
    "address2": address2,
    "city": city,
    "state": state,
    "country": country,
    "pin": pin,
    "cover_image": cover_image,
    "latitude": latitude,
    "longitude": longitude,
    "lease_agreement": leaseAgreement,
    "electricity_bill": electricityBill,
    "bank_statement": bankStatement,
    "date_added": dateAdded,
    "last_updated": lastUpdated,
    "status": status,
    "plan_type": planType,
    "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
    "benefits": List<dynamic>.from(benefits.map((x) => x.toJson())),
    //New Variables :D
    "distance": distance,
    "distance_text": distance_text,
    "duration": duration,
    "duration_text": duration_text,
    "text1": text1,
    "text2": text2,
    "plan_text": plan_text,
    "rating": rating,

    "plan_name": plan_name,
    "plan_duration": plan_duration,
    "plan_price": plan_price,
    "plan_description": plan_description,

    "first_payment": first_payment,
    "first_payment_amount": first_payment_amount,
    "second_payment": second_payment,
    "second_payment_amount": second_payment_amount,
    "third_payment": third_payment,
    "third_payment_amount": third_payment_amount,
  };
}

