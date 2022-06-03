import 'package:wtf/model/new_schedule_model.dart';

class ExerciseDetailArgument{
  NewScheduleDataExercisesData mainData;
  ScheduleLocalModelData localData;
  String localUid;

  //Default Constructor :D
  ExerciseDetailArgument({this.localData,this.mainData,this.localUid});
}