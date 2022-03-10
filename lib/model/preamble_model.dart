class PreambleModel {
  String gender = 'Male';
  int age = 24;

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

  PreambleModel();

  PreambleModel.fromJson(Map<String, dynamic> json){
    this.gender =  json["gender"];
    this.age =  json["age"]??24;


    this.bodyType =  json["bodyType"];
    this.heightInCm =  json["heightInCm"]??true;
    this.heightCm =  json["heightCm"]??160;
    this.heightFeet =  json["heightFeet"]??5.0;

    this.weightInKg =  json["weightInKg"]??true;
    this.weight =  json["weight"];
    this.weightInLbs =  json["weightInLbs"];

    this.targetWeightInKg =  json["targetWeightInKg"]??true;
    this.targetWeight =  json["targetWeight"];
    this.targetWeightInLbs =  json["targetWeightInLbs"];

    this.gainingWeight =  json["gainingWeight"]??true;
    this.goalWeight =  json["goalWeight"]??0.25;
    this.existingDisease =  json["existingDisease"]??[];
    this.isSmoking =  json["isSmoking"]??false;
    this.isDrinking =  json["isDrinking"]??false;

    this.fitnessGoal =  json["fitnessGoal"];
    this.dietPreference =  json["dietPreference"];
  }

  Map<String, dynamic> toJson(PreambleModel data) => {
  "gender": data.gender,
  "age": data.age,

  "bodyType": data.bodyType,
  "heightInCm": data.heightInCm,
  "heightCm": data.heightCm,
  "heightFeet": data.heightFeet,

  "weightInKg": data.weightInKg,
  "weight": data.weight,
  "weightInLbs": data.weightInLbs,

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
}
