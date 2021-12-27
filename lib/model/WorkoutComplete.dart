// To parse this JSON data, do
//
//     final workoutComplete = workoutCompleteFromJson(jsonString);

import 'dart:convert';

WorkoutComplete workoutCompleteFromJson(String str) =>
    WorkoutComplete.fromJson(json.decode(str));

String workoutCompleteToJson(WorkoutComplete data) =>
    json.encode(data.toJson());

class WorkoutComplete {
  WorkoutComplete({
    this.data,
    this.status,
  });

  WorkoutCompleteData data;
  bool status;

  factory WorkoutComplete.fromJson(Map<String, dynamic> json) =>
      WorkoutComplete(
        data: WorkoutCompleteData.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
      };
}

class WorkoutCompleteData {
  WorkoutCompleteData({
    this.eDuration,
    this.totalCaloriesBurn,
  });

  String eDuration;
  int totalCaloriesBurn;

  factory WorkoutCompleteData.fromJson(Map<String, dynamic> json) =>
      WorkoutCompleteData(
        eDuration: json["eDuration"],
        totalCaloriesBurn: json["totalCaloriesBurn"],
      );

  Map<String, dynamic> toJson() => {
        "eDuration": eDuration,
        "totalCaloriesBurn": totalCaloriesBurn,
      };
}
