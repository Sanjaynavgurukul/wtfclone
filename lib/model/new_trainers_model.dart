class NewTrainersModel {
  NewTrainersModel({
    this.status,
    this.data,
  });

  bool status;
  List<TrainerData> data;

  factory NewTrainersModel.fromJson(Map<String, dynamic> json) =>
      NewTrainersModel(
        status: json["status"],
        data: List<TrainerData>.from(
            json["data"].map((x) => TrainerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TrainerData {
  TrainerData({
    this.uid,
    this.name,
    this.gymId,
    this.userId,
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
    this.trainerProfile,
    this.trainerId,
  });

  String uid;
  String name;
  String gymId;
  String trainerId;
  String userId;
  String address1;
  String address2;
  String city;
  String state;
  String pin;
  String country;
  String trainerProfile;
  String dateOnboarding;
  dynamic aadharCard;
  dynamic panCard;
  String status;
  String dateAdded;
  String lastUpdated;
  String trainerCategoryId;

  factory TrainerData.fromJson(Map<String, dynamic> json) => TrainerData(
        uid: json["uid"],
        name: json["name"],
        gymId: json["gym_id"],
        userId: json["user_id"],
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
        trainerProfile: json['trainer_profile'],
        trainerId: json['trainer_uid'],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "gym_id": gymId,
        "user_id": userId,
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
        "trainer_profile": trainerProfile,
        "trainer_uid": trainerId,
      };
}
