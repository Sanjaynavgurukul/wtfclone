// To parse this JSON data, do
//
//     final currentTrainer = currentTrainerFromJson(jsonString);

import 'dart:convert';

import 'package:wtf/helper/app_constants.dart';

CurrentTrainer currentTrainerFromJson(String str) =>
    CurrentTrainer.fromJson(json.decode(str));

String currentTrainerToJson(CurrentTrainer data) => json.encode(data.toJson());

class CurrentTrainer {
  CurrentTrainer({
    this.status,
    this.data,
  });

  bool status;
  CurrentTrainerData data;

  factory CurrentTrainer.fromJson(Map<String, dynamic> json) => CurrentTrainer(
        status: json["status"],
        // data: List<CurrentTrainerData>.from(json["data"].map((x) => CurrentTrainerData.fromJson(x))),
        data: json.containsKey('data')
            ? CurrentTrainerData.fromJson(json['data'][0])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "data": List<dynamic>.from(
        //   data.map(
        //     (x) => x.toJson(),
        //   ),
        // ),
        "data": data.toJson(),
      };
}

class CurrentTrainerData {
  CurrentTrainerData({
    this.id,
    this.uid,
    this.userId,
    this.gymId,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.pin,
    this.country,
    this.dateOnboarding,
    this.aadharCard,
    this.panCard,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.trainerCategoryId,
    this.description,
    this.trainerProfile,
    this.trainerName,
    this.isPt,
    this.rating,
  });

  int id;
  String uid;
  String userId;
  String gymId;
  String name;
  String address1;
  String address2;
  String city;
  String state;
  String pin;
  String country;
  String dateOnboarding;
  dynamic aadharCard;
  dynamic panCard;
  String status;
  String dateAdded;
  String lastUpdated;
  String trainerCategoryId;
  String description;
  dynamic trainerProfile;
  String trainerName;
  int isPt;
  String rating;

  factory CurrentTrainerData.fromJson(Map<String, dynamic> json) {
    String img =
        json.containsKey('trainer_profile') ? json['trainer_profile'] : '';
    if (img != null &&
        img.startsWith(
            'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com/')) {
      print('inside---------------------');
      img = img.replaceFirst(
          'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com',
          AppConstants.cloudFrontImage);
    }
    print('new img: $img');
    print('trainer json :: ${json}');
    return CurrentTrainerData(
      id: json["id"],
      uid: json["uid"],
      userId: json["user_id"],
      gymId: json["gym_id"],
      name: json["name"],
      address1: json["address1"],
      address2: json["address2"],
      city: json["city"],
      state: json["state"],
      pin: json["pin"],
      country: json["country"],
      dateOnboarding: json["date_onboarding"],
      aadharCard: json["aadhar_card"],
      panCard: json["pan_card"],
      status: json["status"],
      dateAdded: json["date_added"],
      lastUpdated: json["last_updated"],
      trainerCategoryId: json["trainer_category_id"],
      description: json["description"],
      trainerProfile: img,
      trainerName: json["trainer_name"],
      isPt: json["is_pt"],
      rating: json['rating'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "user_id": userId,
        "gym_id": gymId,
        "name": name,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "pin": pin,
        "country": country,
        "date_onboarding": dateOnboarding,
        "aadhar_card": aadharCard,
        "pan_card": panCard,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "trainer_category_id": trainerCategoryId,
        "description": description,
        "trainer_profile": trainerProfile,
        "trainer_name": trainerName,
        "is_pt": isPt,
        "rating": rating,
      };
}
