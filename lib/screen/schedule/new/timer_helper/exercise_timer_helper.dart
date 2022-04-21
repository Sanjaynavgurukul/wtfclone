import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';

class ExerciseTimerHelper {
  final List<ExShareModel> globalList = [];
  String convertHour(int time) {
    String hour = ((time / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    return hour;
  }

  String convertMin(int time) {

    String min = ((time / 60) % 60).floor().toString().padLeft(2, '0');
    return min;
  }

  String convertSec(int time) {
    // String sec = (time % 60).floor().toString();
    String sec = (time % 60).floor().toString().padLeft(2,'0');
    return sec;
  }

  int getTimer(bool isEx) {
    if(isEx){
      return locator<AppPrefs>().startExTimer.getValue();
    }else{
      return locator<AppPrefs>().globalTimer.getValue();
    }
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
            hours: int.parse(convertHour(counter)),
            seconds: int.parse(convertSec(counter)),
            minutes: int.parse(convertMin(counter))))
        .millisecondsSinceEpoch;

    if (isEx) {
      locator<AppPrefs>().startExTimer.setValue(currentDate);
    } else {
      locator<AppPrefs>().globalTimer.setValue(currentDate);
    }
  }

  int getPreviousTimerFromLocal(bool isEx) {
    DateTime date1 = DateTime.now();
    DateTime date2;
    if (getTimer(isEx) == 0) {
      return 0;
    } else {
      date2 = DateTime.fromMillisecondsSinceEpoch(getTimer(isEx));
      return date1.difference(date2).inSeconds;
    }
  }

  int convertMil(bool isEx) {
    print('check null * ---');
    int d1 = getPreviousTimerFromLocal(isEx) * 1000;
    print('check null * --- $d1');
    return d1;
  }

  bool getInProgressItemUid({@required String itemUid}){
    String value = locator<AppPrefs>().inProgressEx.getValue();
    return value == itemUid;
  }

  void setExTimeToZero()async{
    await locator<AppPrefs>().startExTimer.setValue(0);
  }

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