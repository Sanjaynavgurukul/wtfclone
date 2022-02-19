import 'package:flutter/material.dart';

class DietLogModel{
  String user_id;
  String old_diet;
  String new_diet;

  //Default Constructor :D
  DietLogModel();

  DietLogModel.fromJson({@required Map<String ,dynamic> data}){
    old_diet = data['new_diet'];
    old_diet = data['old_id'];
  }

  Map<String, dynamic> toJson({@required DietLogModel data}){
    Map<String, dynamic> regionData = new Map<String, dynamic>();
    regionData['user_id'] = data.user_id;
    regionData['old_diet'] = data.old_diet;
    regionData['new_diet'] = data.new_diet;
    return regionData;
  }
}