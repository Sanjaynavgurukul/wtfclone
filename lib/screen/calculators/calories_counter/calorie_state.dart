import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/widget/processing_dialog.dart';

class CalorieState extends ChangeNotifier {
  String text = 'hello';
  String clrResult;
  int protein;
  int fat, carbs;
  String selectedExerciseType = '';
  String gender = '';

  num weight;
  num height;
  num age;
  num val;

  bmrForMen({BuildContext context, num weight, num height, num age, num val}) {
    this.weight = weight;
    this.height = height;
    this.age = age;
    this.val = val;
    // (10 * weight / 1kg + 6.25 * height / 1cm - 5 * age / 1 year + 5) kcal / day

    clrResult = ((10 * weight + 6.25 * height - 5 * age + 5) * val).toString();
    log('calorie cal result: ${clrResult}');
    notifyListeners();
    saveProgress(context: context);
  }

  bmrForWoMen(
      {BuildContext context, num weight, num height, num age, num val}) {
    this.weight = weight;
    this.height = height;
    this.age = age;
    this.val = val;
    clrResult =
        ((10 * weight + (6.25 * height) - 5 * age - 161) * val).toString();
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
      "gender": gender,
      "height": height,
      "weight": weight,
      "result": clrResult,
      "type": selectedExerciseType,
    };
    bool isSaved = await RestDatasource().saveCalorieProgress(body: body);
    Navigator.pop(context);
    if (isSaved) {
      // FlashHelper.successBar(context, message: 'Calorie result Saved');
      context.read<GymStore>().init(context: context);
      NavigationService.navigateTo(Routes.calorieCounterResult);
    } else {
      FlashHelper.errorBar(context, message: 'Please try again!');
    }
  }
}
