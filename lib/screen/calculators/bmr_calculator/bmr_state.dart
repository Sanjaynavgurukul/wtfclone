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

class BmrState extends ChangeNotifier {
  String text = 'hello';
  String bmrResult;
  String gender = '';

  num weight;
  num height;
  num age;

  bmrForMen(
      {BuildContext context,
      num weight,
      num height,
      num age,
      bool openBmtResult = true}) {
    this.weight = weight;
    this.height = height;
    this.age = age;

    bmrResult = (10 * weight / 1 + 6.25 * height / 1 - 5 * age / 1 + 5)
        .toStringAsFixed(2);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    if (openBmtResult) {
      saveProgress(context: context);
    }
  }

  bmrForWoMen(
      {BuildContext context,
      num weight,
      num height,
      num age,
      bool openBmtResult = true}) {
    this.weight = weight;
    this.height = height;
    this.age = age;
    bmrResult = (10 * weight / 1 + 6.25 * height / 1 - 5 * age / 1 - 161)
        .toStringAsFixed(2);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    if (openBmtResult) {
      saveProgress(
        context: context,
      );
    }
  }

  Future<void> saveProgress(
      {BuildContext context}) async {
    print('check save bmr method called ---');
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
      "bmr_result": bmrResult,
    };
    bool isSaved = await RestDatasource().saveBmrProgress(body: body);
    if (isSaved) {
      // FlashHelper.successBar(context, message: 'BMR result Saved');
      //context.read<GymStore>().init(context: context);
        context.read<GymStore>().init(context: context);
        NavigationService.navigateTo(Routes.bmrCalculatorResult);

    } else {
      FlashHelper.errorBar(context, message: 'Please try again!');
    }
  }
}
