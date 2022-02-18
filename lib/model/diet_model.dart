import 'package:flutter/foundation.dart';

class DietModel {
  String uid;
  String name;
  String description;
  String status;
  String date_added;
  String last_updated;
  String type1;
  String type2;
  String type3;
  String type1_name;
  String type2_name;
  String type3_name;
  DietDayModel day;

  //Default Constructor :D
  DietModel();

  DietModel.fromJson({@required Map<String, dynamic> data}) {
    uid = data["uid"];
    name = data["name"];
    description = data["description"];
    status = data["status"];
    date_added = data["date_added"];
    last_updated = data["last_updated"];
    type1 = data["type1"];
    type1_name = data["type1_name"];
    type2 = data["type2"];
    type2_name = data["type2_name"];
    type3 = data["type3"];
    type3_name = data["type3_name"];
    day = DietDayModel.fromJson(data: data);
  }
}

class DietDayModel {
  List<DayWise> list;

  //Default constructor :d
  DietDayModel();

  DietDayModel.fromJson({@required Map<String, dynamic> data}) {
    print('class DietDayModel ---  $data');
    print('class DietDayModel ---  ${data['type2_name']}');
    for (String name in dayNames) {
      // DayWise d = DayWise.fromJson(data: data[name], dayName: name)??new DayWise();
      print('Day name ---- $name');
      print('Day name data ---- ${data[name]}');
      DayWise d =
          DayWise.fromJson(data: data[name], dayName: name) ?? new DayWise();
      print('Day name data after convert ---- ${d.meal}');
      // list.add(d);
    }
  }

  List<String> dayNames = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
}

class DayWise {
  String dayLabel;
  List<MealSlot> meal;

  //Default constructor :D
  DayWise();

  DayWise.fromJson(
      {@required Map<String, dynamic> data, @required String dayName}) {
    print('class DayWise ---  $data');
    for (String val in value()) {
      dayLabel = dayName;
      // meal = MealSlot.fromJson(data: data[val]);
      //day is sunday
      // meal = MealSlot.fromJson(data: data[val]);
      meal =
          (data[val] as List).map((p) => MealSlot.fromJson(data: p)).toList();
      // meal = MealSlot.fromJson(data: data[val]);
    }
  }

  List<String> value() =>
      ['breakfast', 'lunch', 'dinner', 'snacks', 'mmsnacks'];
}

class MealSlot {
  int id;
  String uid;
  String name;
  String category;
  String description;
  String last_updated;
  String date_added;
  String status;
  String co_image;

  //Default constructor :D
  MealSlot();

  MealSlot.fromJson({@required Map<String, dynamic> data}) {
    id = data['id'];
    uid = data['uid'];
    name = data['name'];
    category = data['category'];
    description = data['description'];
    last_updated = data['last_updated'];
    date_added = data['date_added'];
    status = data['status'];
    co_image = data['co_image'];
  }
}
