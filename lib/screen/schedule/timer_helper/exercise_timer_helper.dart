import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wtf/100ms/common/util/utility_components.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/model/new_schedule_model.dart';

class ExerciseTimerHelper {
  String convertHour(int time) {
    String hour = ((time / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    return hour;
  }
  String convertDay(int time) {
    String hour = ((time / (60 * 60 * 24)) % 60).floor().toString().padLeft(2, '0');
    return hour;
  }

  String convertMin(int time) {
    String min = ((time / 60) % 60).floor().toString().padLeft(2, '0');
    return min;
  }

  String convertSec(int time) {
    // String sec = (time % 60).floor().toString();
    String sec = (time % 60).floor().toString().padLeft(2, '0');
    return sec;
  }

  int getTimer(bool isEx) {
    if (isEx) {
      print(
          'check data from local exTimer ${locator<AppPrefs>().startExTimer.getValue()}');
      return locator<AppPrefs>().startExTimer.getValue();
    } else {
      return locator<AppPrefs>().globalTimer.getValue();
    }
  }

  String getLiveClassDuration() {
    int prefDate = locator<AppPrefs>().liveClassTimerDate.getValue();
    var localDate = DateTime.fromMillisecondsSinceEpoch(prefDate);
    var nowDtae = DateTime.now();
    var differentInSecond = nowDtae.difference(localDate).inSeconds;
    String hour = convertHour(differentInSecond);
    String min = convertMin(differentInSecond);
    String sec = convertSec(differentInSecond);
    return '$hour:$min:$sec';
  }

  bool isSameTime(String sheduleTime) {
    String tDate = Helper.formatDate2(DateTime.now().toIso8601String());
    print('isSame date printed --$sheduleTime  ${tDate == sheduleTime}');
    return tDate == sheduleTime;
  }

  bool isPreviousDate() {
    bool isWorkoutOn = locator<AppPrefs>().exerciseOn.getValue();
    if (isWorkoutOn) {
      var format = new DateFormat('dd-MMM-yyyy');
      print('workout timer status -- workout is on');
      int wTimerDate = locator<AppPrefs>().globalTimer.getValue();
      print('workout timer status --- date value $wTimerDate');
      var date = new DateTime.fromMillisecondsSinceEpoch(wTimerDate);
      String pFormatDate = format.format(date);
      print('workout timer status --- date value pDate $pFormatDate');

      DateTime cDate = DateTime.now();
      String cFormatDate = format.format(cDate);
      print('workout timer status --- date value tDate $cFormatDate');

      if (cFormatDate != pFormatDate) {
        locator<AppPrefs>().exerciseUid.setValue('');
        locator<AppPrefs>().globalTimer.setValue(0);
        locator<AppPrefs>().startExTimer.setValue(0);
        locator<AppPrefs>().exercisePause.setValue(false);
        locator<AppPrefs>().exerciseOn.setValue(false);
        return true;
      } else {
        return false;
      }
    } else {
      //Workout not on
      print('workout timer status -- workout is not on');
      return false;
    }

    // int previousDateExerciseCheck = locator<AppPrefs>().startExTimer.getValue();
    // String exUidExists = locator<AppPrefs>().exerciseUid.getValue();
    // bool isWorkoutOn = locator<AppPrefs>().exerciseOn.getValue();
    // if(exUidExists.isNotEmpty && exUidExists != null || isWorkoutOn){
    //   String tDate = Helper.formatDate2(
    //       DateTime.now().toIso8601String());
    //   //
    //   // String pDate = Helper.formatDate2(
    //   //     DateTime.fromMillisecondsSinceEpoch(previousDateExerciseCheck).toIso8601String());
    //    print('convert pDate ${previousDateExerciseCheck} -- $isWorkoutOn');
    //   // print('check date tDate --- $tDate');
    //   // print('check date pDate --- $pDate');
    //   if(!isWorkoutOn){
    //     print('check date same --');
    //     return false;
    //   }else{
    //     print('check date not same --');
    //     locator<AppPrefs>().exerciseUid.setValue('');
    //     locator<AppPrefs>().startExTimer.setValue(0);
    //     locator<AppPrefs>().exercisePause.setValue(false);
    //     locator<AppPrefs>().exerciseOn.setValue(false);
    //     return true;
    //   }
    // }else{
    //   print('check date null condition --');
    //   return false;
    // }
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

  bool getInProgressItemUid({@required String itemUid}) {
    String value = locator<AppPrefs>().inProgressEx.getValue();
    return value == itemUid;
  }

  void setExTimeToZero() async {
    await locator<AppPrefs>().startExTimer.setValue(0);
  }

  //New Methods :D

  ///This method is for calculate total time different between two date and return in seconds
  int getTimeDiff({int time = 0,bool wantInSec = false}) {
    if (time == 0 || time == null) {
      print('check diff sec null');
      return 0;
    } else {
      DateTime date1 = DateTime.now();
      DateTime date2 = DateTime.fromMillisecondsSinceEpoch(time);

      int sec = date1.difference(date2).inSeconds;
      print('check diff sec $sec');
      if(wantInSec){
        return sec;
      }else{
        return sec * 1000;
      }
    }
  }


}

final exTimerHelper = ExerciseTimerHelper();
