import 'package:flutter/material.dart';
import 'package:wtf/model/my_schedule_model.dart';

class MainWorkoutArgument{
  final MyScheduleAddonData data;
  final String workoutType;
  final DateTime time;

  //Constructor :D
  MainWorkoutArgument({@required this.data,@required this.workoutType,@required this.time});

}