class NewScheduleModel {
  //Default Constructor D:
  NewScheduleModel({this.status, this.newScheduleCat, this.newScheduleData});

  bool status;
  List<NewScheduleData> newScheduleData;
  List<NewScheduleCat> newScheduleCat;

  factory NewScheduleModel.fromJson(Map<String, dynamic> json) =>
      NewScheduleModel(
        status: json["status"],
        newScheduleData: json.containsKey('data')
            ? List<NewScheduleData>.from(
                json["data"].map((x) => NewScheduleData.fromJson(x)))
            : [],
        newScheduleCat: json.containsKey('categories')
            ? List<NewScheduleCat>.from(
                json["categories"].map((x) => NewScheduleCat.fromJson(x)))
            : [],
      );
}

class NewScheduleCat {
  NewScheduleCat({this.name, this.image});

  String name;
  String image;

  factory NewScheduleCat.fromJson(Map<String, dynamic> json) => NewScheduleCat(
        name: json["name"],
        image: json["image"],
      );
}

class NewScheduleData {
  String type;
  String date;

  List<NewScheduleDataExercises> exercises;

  NewScheduleData({this.exercises, this.date, this.type});

  factory NewScheduleData.fromJson(Map<String, dynamic> json) =>
      NewScheduleData(
        type: json["type"],
        date: json["date"],
        exercises: json.containsKey('exercises')
            ? List<NewScheduleDataExercises>.from(json["exercises"]
                .map((x) => NewScheduleDataExercises.fromJson(x)))
            : [],
      );
}

class NewScheduleDataExercises {
  int set_no;
  List<NewScheduleDataExercisesData> exercises;

  NewScheduleDataExercises({this.set_no, this.exercises});

  factory NewScheduleDataExercises.fromJson(Map<String, dynamic> json) =>
      NewScheduleDataExercises(
        set_no: json["set_no"],
        exercises: json.containsKey('exercises')
            ? List<NewScheduleDataExercisesData>.from(json["exercises"]
                .map((x) => NewScheduleDataExercisesData.fromJson(x)))
            : [],
      );
}

class NewScheduleDataExercisesData {
  NewScheduleDataExercisesData(
      {this.user_id,
      this.uid,
      this.added_by,
      this.addon_id,
      this.category_id,
      this.category_image,
      this.category_name,
      this.date,
      this.date_added,
      this.day,
      this.description,
      this.e_calories,
      this.e_duration,
      this.ex_no,
      this.ex_seq,
      this.gym_id,
      this.is_pt,
      this.package_id,
      this.reps,
      this.sets,
      this.status,
      this.t_duration,
      this.video,
      this.wo_name,
      this.workout_id});

  String uid;
  String category_name; //null": "Chest",
  String category_id; //null": "SCk4hG6DISBDB",
  String workout_id; //null": "OIiiQLfaPVILU",
  String user_id; //null": "4q60Mk7GJhyx9",
  String description; //null"
  String status; //null": "expire",
  String date_added; //null": "1653296278859",
  String date; //null": "23-05-2022",
  String reps; //null": "20,15,10",
  String e_duration; //null": "",
  String e_calories; //null": "0",
  String sets; //null": "4",
  int is_pt; //null": 0,
  String addon_id; //null": "",
  String added_by; //null": "WaJ7DhoCJDu4F",
  String gym_id; //null": "GLKdIYAWDS2Q8",
  String t_duration; //null": "",
  String package_id; //null": "GJvY8ilW7TPEO",
  int ex_seq; //null": 1,
  String day; //null": "day1",
  int ex_no; //null": 1,
  String wo_name; //null": "Incline Bench Press",
  String video; //null":
  String category_image; //null":

  static String getStringData(String e) {
    if (e == null || e.isEmpty)
      return '';
    else
      return e;
  }

  static int getIntData(int d) {
    print('check int data new schedule --- ${d} ${d.runtimeType}');
    if (d == null)
      return 0;
    else
      return d;
  }

  factory NewScheduleDataExercisesData.fromJson(Map<String, dynamic> json) {
    print('check NewScheduleDataExercises data : ${json}');
    print('check NewScheduleDataExercises data 2 : ${json["category_image"]}');
    return NewScheduleDataExercisesData(
      uid: json["uid"],
      category_name: getStringData(json["category_name"]),
      category_id: getStringData(json["category_id"]),
      workout_id: getStringData(json["workout_id"]),
      user_id: getStringData(json["user_id"]),
      description: getStringData(json["description"]),
      status: getStringData(json["status"]),
      date_added: getStringData(json["date_added"]),
      date: getStringData(json["date"]),
      reps: getStringData(json["reps"]),
      e_duration: getStringData(json["e_duration"]),
      e_calories: getStringData(json["e_calories"]),
      sets: getStringData(json["sets"]),
      is_pt: getIntData(json["is_pt"]),
      addon_id: getStringData(json["addon_id"]),
      added_by: getStringData(json["adde_d_by"]),
      gym_id: getStringData(json["gym_id"]),
      t_duration: getStringData(json["t_duration"]),
      package_id: getStringData(json["package_id"]),
      ex_seq: getIntData(json["ex_seq"]),
      day: getStringData(json["day"]),
      ex_no: getIntData(json["ex_no"]),
      wo_name: getStringData(json["wo_name"]),
      video: getStringData(json["video"]),
      category_image: json["category_image"],
    );
  }
}
