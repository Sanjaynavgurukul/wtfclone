import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/main.dart';

class ExerciseTimerHelper {
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
    if (!isEx) {
      return locator<AppPrefs>().globalTimer.getValue() ?? 0;
    } else {
      print(
          'check get exTime ---- ${locator<AppPrefs>().exerciseTimer.getValue() ?? 0}');
      return locator<AppPrefs>().exerciseTimer.getValue() ?? 0;
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
      locator<AppPrefs>().exerciseTimer.setValue(currentDate);
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

  void setExTimerToZero({bool isGlobal = true}) {
    print('zero method called---');
    if (isGlobal) {
      locator<AppPrefs>().globalTimer.setValue(0);
    } else {
      locator<AppPrefs>().exerciseTimer.setValue(0);
    }
    print(
        'zero method called--- ${locator<AppPrefs>().exerciseTimer.getValue()}');
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