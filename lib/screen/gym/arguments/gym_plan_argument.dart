import 'package:flutter/material.dart';

class GymPlanArgument{
  final Map<String,dynamic> data;
  final bool isDynamicLink;

  //Default Constructor :D
  GymPlanArgument({@required this.data,this.isDynamicLink = false});
}