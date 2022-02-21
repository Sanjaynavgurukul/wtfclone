import 'package:flutter/foundation.dart';
import 'dart:convert';

class CategoryDietModel {
  String categoryLabel;
  List<DietModel> products;

  CategoryDietModel({@required this.products, @required this.categoryLabel});
}

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
  WeeklyDietModel day;

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
    day = WeeklyDietModel.fromJson(data: data);
  }
}

class WeeklyDietModel {
  List<DayWise> list;

  //Default constructor :d
  WeeklyDietModel();

  WeeklyDietModel.fromJson({@required Map<String, dynamic> data}) {
    List<DynamicModel> l = dayNames
        .map((e) => DynamicModel(value: data[e], listLabel: e))
        .toList();
    list = l
        .map((e) => DayWise.fromJson(data: e.value, label: e.listLabel))
        .toList();
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

class DynamicModel {
  dynamic value;
  String listLabel;

  DynamicModel({this.value, this.listLabel});
}

class DayWise {
  String dayLabel;
  List<MealSlot> meal = [];

  //Default constructor :D
  DayWise();

  DayWise.fromJson(
      {@required Map<String, dynamic> data, @required String label}) {
    print('label is here --- $label');
    dayLabel = label;
    for (String val in value) {
      List<MealSlot> m =
          ((data[val] as List).map((i) => MealSlot.fromJson(data: i)).toList());
      meal.addAll(m);
    }
  }

  List<String> value = ['breakfast', 'lunch', 'dinner', 'snacks', 'mmsnacks'];
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
    print('code inside meal slot ---- $data');
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
