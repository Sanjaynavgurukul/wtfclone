import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/main.dart';

class ExerciseTimerHelper{

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

  int getTimer(bool isEx){
    if(!isEx){
      return locator<AppPrefs>().globalTimer.getValue()??0;
    }else{
      return locator<AppPrefs>().exerciseTimer.getValue()??0;
    }
  }

  int getPreviousTimerFromLocal(bool isEx) {
    DateTime date1 = DateTime.now();
    // DateTime date2 = DateTime.now().add(Duration(seconds: getGlobalTime()));
    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(getTimer(isEx));
    final datedifferent = date1.difference(date2).inSeconds;
    print("something $datedifferent");

    return datedifferent;
  }

  int convertMil(bool isEx){
    return getPreviousTimerFromLocal(isEx)*1000;
  }

  void setExTimerToZero(){
    print('zero method called---');
    locator<AppPrefs>().exerciseTimer.setValue(0);
    print('zero method called--- ${locator<AppPrefs>().exerciseTimer.getValue()}');
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