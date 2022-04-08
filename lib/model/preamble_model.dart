import 'dart:convert';

import 'package:flutter/material.dart';

class PreambleModel {
  bool hasData = false;
  String user_id;

  String user_uid;
  String uid;
  // =
  DateTime date;
  String n_token;
  String device_id;
  String tainer_notes;
  String diet_category_id;

  //slide one
  String name;
  String email;
  String location;
  String lat;
  String long;

  //Slide Two
  String gender = 'Male';
  int age = 24;

  //Slide Three
  String body_type;
  String howactive;

  bool heightInCm = true;
  int heightCm = 160;
  double heightFeet = 5.0;
  String height;

  bool weightInKg = true;
  int weightKg = 45;
  String weight;

  int target_weight = 40;

  //Slider Four
  double target_duration= 0.35;
  List<String> existing_disease = [];
  bool is_smoking = false;
  bool is_drinking = false;

  //Slider Five
  String type1;
  String type2;

  //Slider Six
  String bmr_result;

  //Default Constructor :D
  PreambleModel();

  PreambleModel.fromJson(Map<String,dynamic> json){
    this.uid = json["uid"];
    //Slider One
    this.name = json["name"];
    this.email = json["email"];
    this.location = json["location"] == null?'': json["location"];
    this.lat = json["lat"];
    this.long = json["long"];

    //Slider Two
    this.gender =  json["gender"];
    this.age = int.parse(json["age"].toString()??'0');

    //Slider Three
    this.body_type = json["body_type"];
    this.howactive = json["howactive"];

    this.heightInCm = isHeightInCm(json["height"] == null ? '160_cm' : json["height"].toString()) ?? true;
    this.heightCm = getHeightValueInCm(json['height']==null ?'160_cm' : json['height'].toString());
    this.heightFeet = getHeightValueInFt(json['height'] == null ? '5.0_ft':json['height'].toString());

    this.weightInKg = true;
    this.weightKg = getWeight(json['weight'] == null ? '60_kg':json['weight'].toString());

    this.target_weight = getTargetWeight(json["target_weight"] == null ?'40_kg': json["target_weight"].toString() );


    //Slider Four
    this.target_duration = double.parse(json["target_duration"] == null ? '0.25':json["target_duration"].toString() ?? '0.25');

    this.existing_disease = convertMedical(json["existing_disease"] ?? []);
    this.is_smoking = convertBool(json["is_smoking"]) ?? false;
    this.is_drinking = convertBool(json["is_drinking"]) ?? false;

    //Slider Five
    this.type1 = json["type1"];
    this.type2 = json["type2"];

    //Slider Six
    this.bmr_result = json['bmr_result'];

    //Others
    this.date = json['date'];
    this.diet_category_id = json['diet_category_id'];
    this.user_id = json["user_id"];
    this.user_uid = json["user_uid"];
    this.n_token = json["n_token"];
    this.device_id = json["device_id"];
    this.tainer_notes = json["tainer_notes"];
  }

  Map<String, dynamic> toJsonPreamble(PreambleModel data) => {
    'user_id': data.user_id,
    "date": DateTime.now().toIso8601String(),
    "age": data.age,
    "gender": data.gender,
    'height': convertHeightToJson(value: data),
    'weight':getWeightToString(data.weightKg),
    "bmr_result": data.bmr_result,
  };

  String getWeightToString(int data){
    if(data == 0){
      return '60_kg';
    }else if(data != 0){
      String w = data.toString();
      return w+='_kg';
    }else{
      return '60_kg';
    }
  }

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

    "weightInKg": data.weightInKg,
    "weightKg": data.weightKg,
    'weight': getWeightToString(data.weightKg),
    "existing_disease": convertListToString(data.existing_disease),
    "is_smoking": data.is_smoking,
    "is_drinking": data.is_drinking,

    "type1": data.type1,
    "type2": data.type2,

    "uid": data.uid,
    "name": data.name,
    "email": data.email,
    "target_weight": data.target_weight.toString(), //data.target_weight,
    "target_duration": data.target_duration.toString(),
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

  //Checking where height is in cm or in ft :D
  bool isHeightInCm(String height){
    if(height.contains(RegExp('_cm'))){
      return true;
    }else if (height.contains(RegExp('_ft'))){
      return false;
    }else {
      return true;
    }
  }

  //get Height Value in ft or cm
  int getHeightValueInCm(String height){
    if(height.contains(RegExp('_cm'))){
      int d = int.parse(height.replaceAll(RegExp('_cm'), ''));
      return d == 0 ?160:d;
    }else{
      return 160;
    }
  }

  double getHeightValueInFt(String height){
    if(height.contains(RegExp('_ft'))){
      double d = double.parse(height.replaceAll(RegExp('_ft'), ''));
      return d == 0 ?5.0:d;
    }else{
      return 5.0;
    }
  }

  int getTargetWeight(String targetWeight){
    if(targetWeight.contains(RegExp('_kg'))){
      int d = int.parse(targetWeight.replaceAll(RegExp('_kg'), ''));
      return d == 0 ?40:d;
    }else{
      return 40;
    }
  }

  int getWeight(String weight){
    if(weight.contains(RegExp('_kg'))){
      int d = int.parse(weight.replaceAll(RegExp('_kg'), ''));
      return d == 0 ?60:d;
    }else{
      return 60;
    }
  }

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
    try {
      var ab = (value.split(','));
      print('something $ab');
      return ab;
    } on Exception catch (_) {
      return [];
    }
    //
    // print('something $value');
    // var ab = (value.split(','));
    // print('something $ab');
    // // List<String> v = json.decode(value).cast < List<String>();
    // return ab;
  }

  static bool convertBool(var value) {
    if (value == 'false') {
      return false;
    } else {
      return true;
    }
  }

}
