import 'dart:convert';

EventSubmissions eventSubmissionsFromJson(String str) =>
    EventSubmissions.fromJson(json.decode(str));

String eventSubmissionsToJson(EventSubmissions data) =>
    json.encode(data.toJson());

class EventSubmissions {
  EventSubmissions({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  List<EventSubmissionData> data;
  String errorMessage;

  factory EventSubmissions.fromJson(Map<String, dynamic> json) =>
      EventSubmissions(
        status: json["status"],
        data: json.containsKey('data') && json['data'] != null
            ? List<EventSubmissionData>.from(
                json["data"].map((x) => EventSubmissionData.fromJson(x)))
            : [],
        errorMessage: json.containsKey('message') ? json['message'] : '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": errorMessage,
      };
}

class EventSubmissionData {
  EventSubmissionData({
    this.id,
    this.uid,
    this.name,
    this.date,
    this.mode,
    this.image,
    this.isPublic,
    this.description,
    this.price,
    this.status,
    this.dateAdded,
    this.lastUpdated,
    this.validFrom,
    this.validTo,
    this.gymId,
    this.timeFrom,
    this.timeTo,
    this.submissions,
    this.rewardsSubmissions,
    this.endDate,
    this.gymName,
    this.days,
  });

  int id;
  String uid;
  String name;
  String date;
  String mode;
  dynamic image;
  String isPublic;
  String description;
  String price;
  String status;
  String dateAdded;
  dynamic lastUpdated;
  String validFrom;
  String validTo;
  String gymId;
  String timeFrom;
  String timeTo;
  String submissions;
  int rewardsSubmissions;
  String endDate;
  String gymName;
  List<Day> days;

  factory EventSubmissionData.fromJson(Map<String, dynamic> json) =>
      EventSubmissionData(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        date: json["date"],
        mode: json["mode"],
        image: json["image"],
        isPublic: json["is_public"],
        description: json["description"],
        price: json["price"],
        status: json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        validFrom: json["valid_from"],
        validTo: json["valid_to"],
        gymId: json["gym_id"],
        timeFrom: json["time_from"],
        timeTo: json["time_to"],
        submissions: json["submissions"],
        rewardsSubmissions: json["rewards_submissions"],
        endDate: json["end_date"],
        gymName: json["gym_name"],
        days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
        "date": date,
        "mode": mode,
        "image": image,
        "is_public": isPublic,
        "description": description,
        "price": price,
        "status": status,
        "date_added": dateAdded,
        "last_updated": lastUpdated,
        "valid_from": validFrom,
        "valid_to": validTo,
        "gym_id": gymId,
        "time_from": timeFrom,
        "time_to": timeTo,
        "submissions": submissions,
        "rewards_submissions": rewardsSubmissions,
        "end_date": endDate,
        "gym_name": gymName,
        "days": List<dynamic>.from(days.map((x) => x.toJson())),
      };
}

class Day {
  Day({
    this.date,
    this.submissions,
  });

  String date;
  List<Submission> submissions;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        date: json["date"],
        submissions: json['submissions'] != null
            ? List<Submission>.from(
                json["submissions"].map((x) => Submission.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "submissions": List<dynamic>.from(submissions.map((x) => x.toJson())),
      };
}

class Submission {
  Submission({
    this.id,
    this.uid,
    this.eventId,
    this.userId,
    this.platform,
    this.link,
    this.coins,
    this.date,
    this.dateAdded,
    this.name,
    this.email,
    this.mobile,
  });

  int id;
  String uid;
  String eventId;
  String userId;
  String platform;
  String link;
  int coins;
  String date;
  String dateAdded;
  String name;
  String email;
  String mobile;

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        id: json["id"],
        uid: json["uid"],
        eventId: json["event_id"],
        userId: json["user_id"],
        platform: json["platform"],
        link: json["link"],
        coins: json["coins"],
        date: json["date"],
        dateAdded: json["date_added"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "event_id": eventId,
        "user_id": userId,
        "platform": platform,
        "link": link,
        "coins": coins,
        "date": date,
        "date_added": dateAdded,
        "name": name,
        "email": email,
        "mobile": mobile,
      };
}
