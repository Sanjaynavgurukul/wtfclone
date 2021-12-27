// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  Stats({
    this.status,
    this.data,
  });

  bool status;
  StatsData data;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        status: json["status"],
        data: json.containsKey('data')
            ? StatsData.fromJson(json["data"])
            : StatsData(
                bmrCal: [],
                bodyfatCal: [],
                caloriesCal: [],
                weekcalories: [],
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class StatsData {
  StatsData({
    this.bodyfatCal,
    this.caloriesCal,
    this.bmrCal,
    this.weekcalories,
  });

  List<BodyfatCal> bodyfatCal;
  List<Cal> caloriesCal;
  List<Cal> bmrCal;
  List<Weekcalory> weekcalories;

  factory StatsData.fromJson(Map<String, dynamic> json) => StatsData(
        bodyfatCal: List<BodyfatCal>.from(
            json["bodyfat_cal"].map((x) => BodyfatCal.fromJson(x))),
        caloriesCal:
            List<Cal>.from(json["calories_cal"].map((x) => Cal.fromJson(x))),
        bmrCal: List<Cal>.from(json["bmr_cal"].map((x) => Cal.fromJson(x))),
        weekcalories: List<Weekcalory>.from(
            json["weekcalories"].map((x) => Weekcalory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bodyfat_cal": List<dynamic>.from(bodyfatCal.map((x) => x.toJson())),
        "calories_cal": List<dynamic>.from(caloriesCal.map((x) => x.toJson())),
        "bmr_cal": List<dynamic>.from(bmrCal.map((x) => x.toJson())),
        "weekcalories": List<dynamic>.from(weekcalories.map((x) => x.toJson())),
      };
}

class Cal {
  Cal({
    this.uid,
    this.userId,
    this.date,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.bmrResult,
    this.status,
    this.dateAdded,
    this.result,
    this.type,
  });

  String uid;
  String userId;
  DateTime date;
  String age;
  String gender;
  String height;
  String weight;
  String bmrResult;
  String status;
  String dateAdded;
  String result;
  String type;

  factory Cal.fromJson(Map<String, dynamic> json) => Cal(
        uid: json["uid"],
        userId: json["user_id"],
        date: DateTime.parse(json["date"]),
        age: json["age"],
        gender: json["gender"],
        height: json["height"],
        weight: json["weight"],
        bmrResult: json["bmr_result"] == null ? null : json["bmr_result"],
        status: json["status"],
        dateAdded: json["date_added"],
        result: json["result"] == null ? null : json["result"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "user_id": userId,
        "date": date.toIso8601String(),
        "age": age,
        "gender": gender,
        "height": height,
        "weight": weight,
        "bmr_result": bmrResult == null ? null : bmrResult,
        "status": status,
        "date_added": dateAdded,
        "result": result == null ? null : result,
        "type": type == null ? null : type,
      };
}

class BodyfatCal {
  BodyfatCal({
    this.uid,
    this.weight,
    this.height,
    this.age,
    this.bmiResult,
    this.bodyFatResult,
    this.userId,
    this.date,
    this.dateAdded,
  });

  String uid;
  int weight;
  int height;
  int age;
  double bmiResult;
  double bodyFatResult;
  String userId;
  DateTime date;
  String dateAdded;

  factory BodyfatCal.fromJson(Map<String, dynamic> json) => BodyfatCal(
        uid: json["uid"],
        weight: json["weight"],
        height: json["height"],
        age: json["age"],
        bmiResult: json["bmi_result"].toDouble(),
        bodyFatResult: json["body_fat_result"].toDouble(),
        userId: json["user_id"],
        date: DateTime.parse(json["date"]),
        dateAdded: json["date_added"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "weight": weight,
        "height": height,
        "age": age,
        "bmi_result": bmiResult,
        "body_fat_result": bodyFatResult,
        "user_id": userId,
        "date": date.toIso8601String(),
        "date_added": dateAdded,
      };
}

class Weekcalory {
  Weekcalory({
    this.eCalories,
    this.date,
  });

  String eCalories;
  String date;

  factory Weekcalory.fromJson(Map<String, dynamic> json) => Weekcalory(
        eCalories: json['e_calories'].toString(),
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "e_calories": eCalories,
        "date": date,
      };
}
