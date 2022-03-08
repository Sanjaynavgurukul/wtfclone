class PreambleModel {
  String name;
  String gender;

  // String address;
  int age = 24; //24 is the default age value

  String bodyType;
  String height;
  String weight;
  String targetWeight;

  String goalWeight;
  List<String> existingDisease;
  bool isSmoking;
  bool isDrinking;

  String fitnessGoal;
  String dietPreference;

  // int inches;
  // String activeType;
  //
  // String type1;
  // String type2;

  PreambleModel(
      {this.targetWeight,
      this.weight,
      this.age, //
      this.name,
      this.height,
      this.bodyType,
      this.dietPreference,
      this.existingDisease,
      this.fitnessGoal,
      this.gender,
      this.goalWeight,
      this.isDrinking,
      this.isSmoking});

  factory PreambleModel.fromJson(Map<String, dynamic> json) => PreambleModel(
      targetWeight: json["targetWeight"],
      weight: json["weight"],
      age: json["age"],
      name: json["name"],
      height: json["height"],
      bodyType: json["bodyType"],
      dietPreference: json["dietPreference"],
      existingDisease: json["existingDisease"],
      fitnessGoal: json['fitnessGoal'],
      gender: json['gender'] ?? '',
      goalWeight: json['goalWeight'] ?? '',
      isDrinking: json['isDrinking'] ?? false,
      isSmoking: json['isSmoking'] ?? false);

  Map<String, dynamic> toJson(PreambleModel data) => {
    "targetWeight": data.targetWeight,
    "weight": data.weight,
    "age": data.age,
    "name": data.name,
    "height": data.height,
    "bodyType": data.bodyType,
    "dietPreference": data.dietPreference,
    "existingDisease": data.existingDisease,
    "fitnessGoal": data.fitnessGoal,
    "gender": data.gender,
    "goalWeight": data.goalWeight,
    "isDrinking": data.isDrinking,
    "isSmoking": data.isSmoking,
  };
}
