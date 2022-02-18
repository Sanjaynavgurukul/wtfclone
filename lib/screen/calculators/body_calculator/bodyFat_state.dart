import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/widget/processing_dialog.dart';

class BodyState extends ChangeNotifier {
  String text = 'hello';
  double bmiResult;
  double bodyFat;
  String gender = '';

  num weight;
  num height;
  num age;
  num neck;
  num waist;
  num hip;

  bmi({BuildContext context, num weight, num height}) {
    this.weight = weight;
    this.height = height;
    notifyListeners();
    bmiResult = (weight / (height * height * 0.0001));
    // bmiResult = weight / height * height;
    print("bmiResult$bmiResult");
  }

  bodyFatMen({
    BuildContext context,
    num weight,
    num height,
    num age,
    num waist,
    num neck,
  }) {
    this.weight = weight;
    this.height = height;
    this.age = age;
    this.neck = (neck * 2.54);
    this.waist = (waist * 2.54);
    print('neck: ${this.neck}   waist: ${this.waist} ');
    bodyFat = 495 /
            (1.0324 -
                0.19077 * log(this.waist - this.neck) / ln10 +
                0.15456 * log(this.height) / ln10) -
        450;
    // bodyFat =
    //     86.010 * log(waist - neck) / ln10 - 70.041 * log(height) / ln10 + 36.76;
    // bodyFat = (-44.988 +
    //     (0.503 * age) +
    //     (3.172 * bmiResult) -
    //     (0.026 * bmiResult * bmiResult) -
    //     (0.02 * bmiResult * age) +
    //     (0.00021 * bmiResult * bmiResult * age));
    print("bodyFatResult$bodyFat");
    notifyListeners();
    saveProgress(context: context);
  }

  bodyFatWoMen(
      {BuildContext context,
      num weight,
      num height,
      num age,
      num waist,
      num neck,
      num hip}) {
    this.weight = weight;
    this.height = height;
    this.age = age;
    this.neck = neck;
    this.waist = waist;
    this.hip = hip;
    bodyFat = 495 /
            (1.29579 -
                0.35004 * log(waist + hip - neck) / ln10 +
                0.22100 * log(height) / ln10) -
        450;
    // bodyFat = (-44.988 +
    //     (0.503 * age) +
    //     (10.689 * 1) +
    //     (3.172 * bmiResult) -
    //     (0.026 * bmiResult * bmiResult) +
    //     (0.181 * bmiResult * 1) -
    //     (0.02 * bmiResult * age) -
    //     (0.005 * bmiResult * bmiResult * 1) +
    //     (0.00021 * bmiResult * bmiResult * age));
    notifyListeners();
    saveProgress(context: context);
  }

  Future<void> saveProgress({BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "date": DateTime.now().toIso8601String(),
      "age": age,
      "height": height,
      "weight": weight,
      "bmi_result": bmiResult,
      "body_fat_result": bodyFat
    };
    bool isSaved = await RestDatasource().saveBodyFatProgress(body: body);
    Navigator.pop(context);
    if (isSaved) {
      // FlashHelper.successBar(context, message: 'Body Fat result Saved');
      context.read<GymStore>().init(context: context);
      NavigationService.navigateTo(Routes.bodyFatCalResult);
    } else {
      FlashHelper.errorBar(context, message: 'Please try again!');
    }
  }
}
