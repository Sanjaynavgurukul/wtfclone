import 'package:flutter/cupertino.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';

class ExDetailsArgument{
  final List<Exercise> data;
  final String coverImage;
  final int index;
  ExDetailsArgument({@required this.data,@required this.coverImage,this.index});
}