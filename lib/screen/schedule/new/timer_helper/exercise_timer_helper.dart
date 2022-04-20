import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';

class ExerciseTimerHelper {
  final List<ExShareModel> globalList = [];
  int convertHour(int time) {
    String hour = ((time / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    return int.parse(hour);
  }

  int convertMin(int time) {
    String min = ((time / 60) % 60).floor().toString().padLeft(2, '0');

    return int.parse(min);
  }

  int convertSec(int time) {
    String sec = (time % 60).floor().toString().padLeft(2, '0');
    return int.parse(sec);
  }

  int getTimer(bool isEx) {
    if(isEx){
      locator<AppPrefs>().startExTimer.getValue();
    }else{
      locator<AppPrefs>().globalTimer.getValue();
    }
  }

  void setDataToLocal(ExShareModel model) {
    // String en = encode(data);
    // locator<AppPrefs>().exerciseData.setValue(en);
  }

  String encode(List<ExShareModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => ExShareModel().toJson(music))
        .toList(),
  );

  List<ExShareModel> getExList(){
    String data = locator<AppPrefs>().exerciseData.getValue();
    if (data.isNotEmpty || data != null) {
      var list = (json.decode(data) as List<dynamic>)
          .map<ExShareModel>((item) => ExShareModel.fromJson(item))
          .toList();

      if(list.isNotEmpty || list != null){
        return list;
      }else{
        return [];
      }
    }else{
      return [];
    }
  }

  ExShareModel getCurrentExFromLocalList({String itemUid}) {
    var list = getExList();
    //getting current item by uid
    if(list.isNotEmpty || list != null){
      var data = list.where((element) => element.itemUid == itemUid).toList();
      if(data.isNotEmpty || data != null){
        return data[0];
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

  void setTimeInLocal({@required int counter, bool isEx}) {
    int currentDate = DateTime.now()
        .subtract(Duration(
            hours: convertHour(counter),
            seconds: convertSec(counter),
            minutes: convertMin(counter)))
        .millisecondsSinceEpoch;

    if (isEx) {
      locator<AppPrefs>().startExTimer.setValue(currentDate);
    } else {
      locator<AppPrefs>().globalTimer.setValue(currentDate);
    }
  }

  int getPreviousTimerFromLocal(bool isEx) {
    DateTime date1 = DateTime.now();
    // DateTime date2 = DateTime.now().add(Duration(seconds: getGlobalTime()));
    DateTime date2;
    if (getTimer(isEx) == 0) {
      date2 = DateTime.now();
    } else {
      date2 = DateTime.fromMillisecondsSinceEpoch(getTimer(isEx));
    }

    final datedifferent = date1.difference(date2).inSeconds;
    print("something $datedifferent");

    return datedifferent;
  }

  int convertMil(bool isEx) {
    return getPreviousTimerFromLocal(isEx) * 1000;
  }



  bool getInProgressItemUid({@required String itemUid}){
    String value = locator<AppPrefs>().inProgressEx.getValue();
    return value == itemUid;
  }

// void setTimeInLocal({@required bool isEx,@required int counter}) {
//   int currentDate = DateTime.now()
//       .subtract(Duration(
//       hours: convertHour(counter),
//       seconds: convertSec(counter),
//       minutes: convertMin(counter)))
//       .millisecondsSinceEpoch;
//   if(!isEx){
//     locator<AppPrefs>().globalTimer.setValue(currentDate);
//   }else{
//     locator<AppPrefs>().exerciseTimer.setValue(currentDate);
//   }
// }
}

final exTimerHelper = ExerciseTimerHelper();


class ExShareModel{
  String itemUid;
  int sets;
  int timer;

  ExShareModel({this.itemUid,this.sets,this.timer});

  factory ExShareModel.fromJson(Map<String, dynamic> json) =>ExShareModel(
    timer: json["timer"],
    sets:json["sets"],
    itemUid: json["itemUid"]
  );

  Map<String, dynamic> toJson(ExShareModel data)=>{
    "timer": data.timer,
    "sets": data.sets,
    "itemUid": data.itemUid,
  };


}