class PreambleModel {
  String name;
  String gender = 'Male';

  // String address;
  int age = 24; //24 is the default age value

  String bodyType;

  bool heightInCm = true;
  int heightCm = 160;
  double heightFeet = 5.0;

  bool weightInKg = true;
  int weight;
  int weightInLbs;

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
  String otherDietPreference;

  // int inches;
  // String activeType;
  //
  // String type1;
  // String type2;

  PreambleModel();

  // PreambleModel.fromJson(Map<String, dynamic> json){
  //   this.targetWeight =  json["targetWeight"];
  //   this.weight =  json["weight"];
  //   this.age = json["age"];
  //   this.name = json["name"];
  //   this.heightInCm = json["heightInCm"];
  //   this.heightInFeet = json["heightInFeet"];
  //   this.bodyType = json["bodyType"];
  //   this.dietPreference = json["dietPreference"];
  //   this.existingDisease = json["existingDisease"];
  //   this.fitnessGoal =json['fitnessGoal'];
  //   this.gender =json['gender'] ?? '';
  //   this.goalWeight = json['goalWeight'] ?? '';
  //   this.isDrinking = json['isDrinking'] ?? false;
  //   this.isSmoking = json['isSmoking'] ?? false;
  // }

  // Map<String, dynamic> toJson(PreambleModel data) => {
  //   "targetWeight": data.targetWeight,
  //   "weight": data.weight,
  //   "age": data.age,
  //   "name": data.name,
  //   "heightInCm": data.heightInCm,
  //   "heightInFeet": data.heightInFeet,
  //   "bodyType": data.bodyType,
  //   "dietPreference": data.dietPreference,
  //   "existingDisease": data.existingDisease,
  //   "fitnessGoal": data.fitnessGoal,
  //   "gender": data.gender,
  //   "goalWeight": data.goalWeight,
  //   "isDrinking": data.isDrinking,
  //   "isSmoking": data.isSmoking,
  // };
}
