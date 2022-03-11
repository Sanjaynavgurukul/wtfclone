import 'dart:convert';

import 'package:flutter/material.dart';

class PreambleModel {
  String gender = 'Male';
  int age = 24;

  String user_id;
  String user_uid;

  String body_type;

  bool heightInCm = true;
  int heightCm = 160;
  double heightFeet = 5.0;
  String height;

  bool weightInKg = true;
  int weightKg;
  int weightInLbs;
  String weight;

  bool targetWeightInKg = true;
  int targetWeight;
  int targetWeightInLbs;

  bool gainingWeight = true;
  double goalWeight = 0.25;
  List<String> existing_disease = [];
  bool is_smoking = false;
  bool is_drinking = false;

  String type1;
  String type2;

  DateTime date;
  String bmr_result;

  //Extra For Member
  String uid;

  // String user_uid;
  String name;
  String email;
  double target_weight;
  String target_duration = '30 days';
  String location;
  String lat;
  String long;
  String n_token;
  String device_id;
  String howactive;
  String tainer_notes;
  String diet_category_id;

  PreambleModel();

  PreambleModel.fromJson(Map<String,dynamic> json){
    this.gender =  json["gender"];
    this.age= json["age"] ?? 24;
    this.date= json['date'];
    this.bmr_result= json['bmr_result'];
    this.diet_category_id= json['diet_category_id'];
    this.body_type= json["body_type"];
    this.heightInCm= json["heightInCm"] ?? true;
    // this.heightCm = json["heightCm"] ?? 160;
    // this.heightFeet = json["heightFeet"] ?? 5.0;
    this.heightCm= convertHeightFromJson(value:json['height']);
    this.heightFeet= convertHeightFromJsonFeet(value: json['height']);
    this.weightInKg= json["weightInKg"] ?? true;
    // this.weightKg = json["weightKg"];
    // this.weightInLbs = json["weightInLbs"];
    this.weightKg= convertWeightFromJson(value:json['weight']);
    this.weightInLbs= convertWeightFromJson(value: json['weight']);
    this.targetWeightInKg= json["targetWeightInKg"] ?? true;
    this.targetWeight= json["targetWeight"];
    this.targetWeightInLbs= json["targetWeightInLbs"];
    this.gainingWeight= json["gainingWeight"] ?? true;
    this.goalWeight= json["goalWeight"] ?? 0.25;
    this.existing_disease= convertMedical(json["existing_disease"] ?? []);
    // this.existing_disease = json["existing_disease"] as List;
    this.is_smoking= convertBool(json["is_smoking"]) ?? false;
    this.is_drinking= convertBool(json["is_drinking"]) ?? false;
    this.type1= json["type1"];
    this.type2= json["type2"];
    this.uid= json["uid"];
    this.user_id= json["user_id"];
    this.name= json["name"];
    this.email= json["email"];
    this.user_uid= json["user_uid"];
    this.target_weight= double.parse(json["target_weight"]);
    this.target_duration= json["target_duration"];
    this.location= json["location"];
    this.lat= json["lat"];
    this.long= json["long"];
    this.n_token= json["n_token"];
    this.device_id= json["device_id"];
    this.howactive= json["howactive"];
    this.tainer_notes= json["tainer_notes"];
  }

  String convertListToString(List<String> data){
    if(data.isEmpty || data == null) return '';
    else{
      String commaSeparatedNames= data
          .map((item) => item)
          .toList()
          .join(",");
      print("convert of string  -- $commaSeparatedNames");
      return commaSeparatedNames;
    }
  }
  static List<String> convertMedical(String value) {
    // var ab = json.decode(value);
    print('something $value');
    var ab = (value.split(','));
    print('something $ab');
    // List<String> v = json.decode(value).cast < List<String>();
    return ab;
  }

  static bool convertBool(var value) {
    if (value == 'false') {
      return false;
    } else {
      return true;
    }
  }

  Map<String, dynamic> toJsonPreamble(PreambleModel data) => {
    'user_id': data.user_id,
    "date": DateTime.now().toIso8601String(),
    "age": data.age,
    "gender": data.gender,
    'height': convertHeightToJson(value: data),
    'weight': convertWeightToJson(value: data),
    "bmr_result": data.bmr_result,
  };

  Map<String, dynamic> toJsonMember(PreambleModel data) => {
    "gender": data.gender,
    "age": data.age,
    'user_id': data.user_id,
    'user_uid':data.user_id,
    "body_type": data.body_type,

    "heightInCm": data.heightInCm,
    "heightCm": data.heightCm,
    "heightFeet": data.heightFeet,
    'height': convertHeightToJson(value: data),

    //"date": DateTime.now().toIso8601String(),
    //"bmr_result": data.bmr_result,

    "weightInKg": data.weightInKg,
    "weightKg": data.weightKg,
    "weightInLbs": data.weightInLbs,
    'weight': convertWeightToJson(value: data),

    "targetWeightInKg": data.targetWeightInKg,
    "targetWeight": data.targetWeight,
    "targetWeightInLbs": data.targetWeightInLbs,
    "gainingWeight": data.gainingWeight,
    "goalWeight": data.goalWeight,
    // "existing_disease": data.existing_disease.toString(),
    "existing_disease": convertListToString(data.existing_disease),
    "is_smoking": data.is_smoking,
    "is_drinking": data.is_drinking,

    "type1": data.type1,
    "type2": data.type2,

    "uid": data.uid,
    "name": data.name,
    "email": data.email,
    "target_weight": data.goalWeight, //data.target_weight,
    "target_duration": data.target_duration,
    "location": data.location,
    "lat": data.lat,
    "long": data.long,
    "n_token": data.n_token,
    "device_id": data.device_id,
    "howactive": data.howactive,
    "tainer_notes": data.tainer_notes,
    "diet_category_id": data.diet_category_id,
    'status': 'active'
  };

  static String convertHeightToJson({PreambleModel value}) {
    if (value.heightInCm) {
      String d = value.heightCm.toString();
      d += '_cm';
      return d;
    } else {
      String d = value.heightFeet.toString();
      d += '_ft';
      return d;
    }
  }

  static dynamic convertHeightFromJson({String value}) {
    bool isCm = value.contains(RegExp('_cm'));

    if (isCm) {
      int d = int.parse(value.replaceAll(RegExp('_cm'), ''));
      return d;
    } else {
      double d = double.parse(value.replaceAll(RegExp('_ft'), ''));
      return d;
    }
  }

  static dynamic convertHeightFromJsonFeet({String value}) {
    bool isCm = value.contains(RegExp('_ft'));

    if (isCm) {
      double d = double.parse(value.replaceAll(RegExp('_ft'), ''));
      return d;
    } else {
      return null;
    }
  }

  static String convertWeightToJson({PreambleModel value}) {
    if (value.weightInKg) {
      String d = value.weightKg.toString();
      d += '_kg';
      return d;
    } else {
      String d = value.weightInLbs.toString();
      d += '_lbs';
      return d;
    }
  }

  static int convertWeightFromJson({String value}) {
    bool isKg = value.contains(RegExp('_kg'));

    if (isKg) {
      int d = int.parse(value.replaceAll(RegExp('_kg'), ''));
      return d;
    } else {
      int d = int.parse(value.replaceAll(RegExp('_lbs'), ''));
      return d;
    }
  }

}
