
class WorkoutDetailModel {
  WorkoutDetailModel({
    this.status,
    this.data,
  });

  bool status;
  WorkoutData data;

  factory WorkoutDetailModel.fromJson(Map<String, dynamic> json) => WorkoutDetailModel(
    status: json["status"],
    data: json.containsKey('data') ? WorkoutData.fromJson(json["data"]) : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class WorkoutData {
  WorkoutData({
    this.uid,
    this.woName,
    this.category,
    this.description,
    this.type,
    this.video,
    this.dateAdded,
    this.lastUpdated,
    this.status,
    this.eDuration,
  });

  String uid;
  String woName;
  String category;
  String description;
  String type;
  String video;
  String dateAdded;
  String lastUpdated;
  String status;
  dynamic eDuration;

  factory WorkoutData.fromJson(Map<String, dynamic> json) => WorkoutData(
    uid: json["uid"],
    woName: json["wo_name"],
    category: json["category"],
    description: json["description"],
    type: json["type"],
    video: json["video"],
    dateAdded: json["date_added"],
    lastUpdated: json["last_updated"],
    status: json["status"],
    eDuration: json["e_duration"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "wo_name": woName,
    "category": category,
    "description": description,
    "type": type,
    "video": video,
    "date_added": dateAdded,
    "last_updated": lastUpdated,
    "status": status,
    "e_duration": eDuration,
  };
}
