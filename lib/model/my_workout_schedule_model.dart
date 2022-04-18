// To parse this JSON data, do
//
//     final mySchedule = myScheduleFromJson(jsonString);

import 'dart:convert';

MyWorkoutSchedule myScheduleFromJson(String str) =>
    MyWorkoutSchedule.fromJson(json.decode(str));

String myScheduleToJson(MyWorkoutSchedule data) => json.encode(data.toJson());

class WorkoutVerification {
  String status;
  String uid;
  var eCalories;
  var eDuration;

  WorkoutVerification({
    this.status,
    this.uid,
    this.eCalories,
    this.eDuration,
  });

  factory WorkoutVerification.fromJson(Map<String, dynamic> json) =>
      WorkoutVerification(
        status: json['status'],
        uid: json['uid'],
        eCalories: json['e_calories'],
        eDuration: json['e_duration'],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "uid": uid,
        "e_calories": eCalories,
        "e_duration": eDuration,
      };
}

class MyWorkoutSchedule {
  MyWorkoutSchedule({
    this.status,
    this.data,
    this.workoutVerification,
  });

  bool status;
  WorkoutVerification workoutVerification;
  List<WorkoutScheduleData> data;

  factory MyWorkoutSchedule.fromJson(Map<String, dynamic> json) =>
      MyWorkoutSchedule(
        status: json["status"],
        workoutVerification: json['workout_verification'] != null
            ? WorkoutVerification.fromJson(json['workout_verification'])
            : null,
        data: json['data'] != null
            ? List<WorkoutScheduleData>.from(
                json["data"].map((x) => WorkoutScheduleData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "workout_verification":
            workoutVerification != null ? workoutVerification.toJson() : null,
      };
}

class WorkoutScheduleData {
  WorkoutScheduleData({
    this.category,
    this.exercises,
    this.image,
    this.description,
    this.isCompleted,
  });

  String category;
  String description;
  String image;
  List<Exercise> exercises;
  bool isCompleted;

  factory WorkoutScheduleData.fromJson(Map<String, dynamic> json) {
    List<Exercise> temp = [];
    List<Exercise> temp2 = [];
    if (json['exercises'] != null) {
      for (int i = 0; i < json['exercises'].length; i++) {
        if (json['exercises'][i]['e_duration'] == null ||
            json['exercises'][i]['e_duration'].isEmpty) {
          temp.add(Exercise.fromJson(json['exercises'][i]));
        } else {
          temp2.add(Exercise.fromJson(json['exercises'][i]));
        }
      }
    }
    temp.addAll(temp2);
    return WorkoutScheduleData(
      category: json["category"],
      exercises: json['exercises'] != null ? temp : [],
      image: json.containsKey('category_image') ? json['category_image'] : null,
      isCompleted: json['isCompleted'] ?? false,
      description: json.containsKey('description')
          ? json['description']
          : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
    );
  }
  factory WorkoutScheduleData.isEmpty() => WorkoutScheduleData();

  Map<String, dynamic> toJson() => {
        "category": category,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
        "image": image,
        "description": description,
        "isCompleted": isCompleted,
      };
}

class Exercise {
  Exercise({
    this.id,
    this.uid,
    this.workoutId,
    this.userId,
    this.description,
    this.status,
    this.dateAdded,
    this.date,
    this.reps,
    this.eDuration,
    this.eCalories,
    this.woName,
    this.category,
    this.video,
    this.type,
    this.lastUpdated,
    this.sets,
    this.workoutMappingUid,
    this.isCompleted = false,
    this.isStarted = false,
    this.setsCompleted = 0,
    this.setData,
  });

  int id;
  String uid;
  String workoutId;
  String userId;
  String description;
  String status;
  String dateAdded;
  String date;
  String reps;
  String sets;
  String workoutMappingUid;
  String eDuration;
  dynamic eCalories;
  String woName;
  String category;
  String video;
  String type;
  String lastUpdated;
  bool isStarted;
  bool isCompleted;
  int setsCompleted;
  var setData;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        uid: json["uid"],
        workoutId: json["workout_id"],
        userId: json["user_id"],
        description: json["description"],
        status: json["status"],
        dateAdded: json["date_added"],
        date: json["date"],
        reps: json["reps"],
        eDuration: json["e_duration"],
        eCalories: json["e_calories"],
        woName: json["wo_name"],
        category: json["category"],
        video: json["video"],
        type: json["type"],
        lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
        sets: json.containsKey('sets') ? json['sets'] : '0',
        workoutMappingUid: json['workoutmapping_uid'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
        isStarted: json['isStarted'] ?? false,
        setsCompleted: json['setsCompleted'] ?? 0,
        setData: json['setData'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "workout_id": workoutId,
        "user_id": userId,
        "description": description,
        "status": status,
        "date_added": dateAdded,
        "date": date,
        "reps": reps,
        "e_duration": eDuration,
        "e_calories": eCalories,
        "wo_name": woName,
        "category": category,
        "video": video,
        "type": type,
        "last_updated": lastUpdated == null ? null : lastUpdated,
        "sets": sets,
        "workoutmapping_uid": workoutMappingUid,
        "isCompleted": isCompleted,
        "isStarted": isStarted,
        "setsCompleted": setsCompleted,
        "setData": setData,
      };
}
