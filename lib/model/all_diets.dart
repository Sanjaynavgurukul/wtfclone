import 'dart:convert';

AllDiets dietMappingsFromJson(String str) =>
    AllDiets.fromJson(json.decode(str));

String dietMappingsToJson(AllDiets data) => json.encode(data.toJson());

class AllDiets {
  AllDiets({
    this.status,
    this.data,
  });

  bool status;
  List<DietData> data;

  factory AllDiets.fromJson(Map<String, dynamic> json) => AllDiets(
        status: json["status"],
        data: json.containsKey('data')
            ? List<DietData>.from(json["data"].map((x) => DietData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data != null
            ? List<dynamic>.from(data.map((x) => x.toJson()))
            : null,
      };
}

class DietData {
  DietData({
    this.uid,
    this.description,
    this.dietId,
    this.memberId,
    this.status,
    this.dateAdded,
    this.intake,
    this.expCal,
    this.date,
    this.name,
    this.category,
    this.image,
    this.addedBy,
    // this.dateTime,
  });

  String uid;
  dynamic description;
  String dietId;
  String memberId;
  String status;
  String dateAdded;
  String category;
  String name;
  String date;
  String intake;
  String expCal;
  String addedBy;
  String image;

  factory DietData.fromJson(Map<String, dynamic> json) => DietData(
      uid: json["uid"],
      description: json["description"],
      dietId: json["diet_id"],
      memberId: json["member_id"],
      status: json["status"],
      dateAdded: json["date_added"],
      intake: json["intake"],
      expCal: json["exp_cal"],
      date: json['date'],
      category: json['category'],
      name: json['name'],
      addedBy: json['added_by'],
      image: json['co_image']);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "description": description,
        "diet_id": dietId,
        "member_id": memberId,
        "status": status,
        "date_added": dateAdded,
        "intake": intake,
        "exp_cal": expCal,
        "date": date,
        "category": category,
        "name": name,
        "co_image": image,
        "added_by": addedBy,
      };
}
