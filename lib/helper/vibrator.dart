import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class Vibrator{
  static vibrateCustomTime({int durationInMiliSecond = 500}){
    Vibration.vibrate(duration: durationInMiliSecond);
  }
}