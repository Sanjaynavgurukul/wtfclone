import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';

import '../main.dart';

class PreambleHelper {
  static bool hasPreamble() {
    return locator<AppPrefs>().memberAdded.getValue();
  }

  static Future<bool> showPreambleWarningDialog(
      {@required BuildContext context, bool fromPayment = false}) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Image.asset('assets/images/nutrition_2.png'),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              content: new Text(
                  "In order to give you the appropriate nutrition support , please provide your details by clicking here"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("Open"),
                  onPressed: () {
                    if (!fromPayment) {
                      Navigator.pop(context, true);
                      context.read<GymStore>().preambleFromLogin = false;
                      return NavigationService.pushName(Routes.userDetail);
                    }else{
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ));
  }
}
