import 'package:flutter/material.dart';

class PreambleModel {
  String gender = 'Male';
  int age = 24;

  String user_id;

  String bodyType;

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
  List<String> existingDisease = [];
  bool isSmoking = false;
  bool isDrinking = false;

  String fitnessGoal;
  String dietPreference;

  DateTime date;
  String bmr_result;
  PreambleModel();

  PreambleModel.fromJson(Map<String, dynamic> json){
    this.gender = json["gender"];
    this.user_id = json["user_id"];
    this.age = json["age"] ?? 24;
    this.date = json['date'];
    this.bmr_result = json['bmr_result'];
    this.bodyType = json["bodyType"];

    this.heightInCm = json["heightInCm"] ?? true;
    // this.heightCm = json["heightCm"] ?? 160;
    // this.heightFeet = json["heightFeet"] ?? 5.0;
    this.heightCm = convertHeightFromJson(value: json['height']);
    this.heightFeet = convertHeightFromJson(value: json['height']);

    this.weightInKg = json["weightInKg"] ?? true;
    // this.weightKg = json["weightKg"];
    // this.weightInLbs = json["weightInLbs"];
    this.weightKg = convertWeightFromJson(value: json['weight']);
    this.weightInLbs = convertWeightFromJson(value: json['weight']);

    this.targetWeightInKg = json["targetWeightInKg"] ?? true;
    this.targetWeight = json["targetWeight"];
    this.targetWeightInLbs = json["targetWeightInLbs"];

    this.gainingWeight = json["gainingWeight"] ?? true;
    this.goalWeight = json["goalWeight"] ?? 0.25;
    this.existingDisease = json["existingDisease"] ?? [];
    this.isSmoking = json["isSmoking"] ?? false;
    this.isDrinking = json["isDrinking"] ?? false;

    this.fitnessGoal = json["fitnessGoal"];
    this.dietPreference = json["dietPreference"];
  }

  Map<String, dynamic> toJson(PreambleModel data, {@required String userId}) =>
      {
        "gender": data.gender,
        "age": data.age,
        'user_id': userId,
        "bodyType": data.bodyType,

        "heightInCm": data.heightInCm,
        "heightCm": data.heightCm,
        "heightFeet": data.heightFeet,
        'height': convertHeightToJson(value:data),

        "date": DateTime.now().toIso8601String(),
        "bmr_result": data.bmr_result,

        "weightInKg": data.weightInKg,
        "weightKg": data.weightKg,
        "weightInLbs": data.weightInLbs,
        'weight':convertWeightToJson(value: data),

        "targetWeightInKg": data.targetWeightInKg,
        "targetWeight": data.targetWeight,
        "targetWeightInLbs": data.targetWeightInLbs,
        "gainingWeight": data.gainingWeight,

        "goalWeight": data.goalWeight,
        "existingDisease": data.existingDisease,
        "isSmoking": data.isSmoking,
        "isDrinking": data.isDrinking,

        "fitnessGoal": data.fitnessGoal,
        "dietPreference": data.dietPreference,
      };


  String convertHeightToJson({PreambleModel value}){
      if(value.heightInCm){
        String d = value.heightCm.toString();
        d+='_cm';
        return d;
      }else{
        String d = value.heightFeet.toString();
        d+='_ft';
        return d;
      }
  }

  dynamic convertHeightFromJson({String value}){
    bool isCm = value.contains(RegExp('_cm'));

    if(isCm){
      int d = int.parse(value.replaceAll(RegExp('_cm'), ''));
      return d;
    }else{
      double d = double.parse(value.replaceAll(RegExp('_ft'), ''));
      return d;
    }
  }

  String convertWeightToJson({PreambleModel value}){
    if(value.weightInKg){
      String d = value.weightKg.toString();
      d+='_kg';
      return d;
    }else{
      String d = value.weightInLbs.toString();
      d+='_lbs';
      return d;
    }
  }

  int convertWeightFromJson({String value}){
    bool isKg = value.contains(RegExp('_kg'));

    if(isKg){
      int d = int.parse(value.replaceAll(RegExp('_kg'), ''));
      return d;
    }else{
      int d = int.parse(value.replaceAll(RegExp('_lbs'), ''));
      return d;
    }
  }

}
