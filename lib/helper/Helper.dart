import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';

import 'Toast.dart';

class Helper {
  static const String googleMapKey = 'AIzaSyCyEYyFZfeeLHpDuyfXCBjpDZf8IfqPYk0';
  static const String razorPayKey = 'rzp_live_NhCDSCOuXIM3Ml';
  // static const String razorPayKey = 'rzp_live_NhCDSCOuXIM3Ml';
  // static const String razorPayKey = 'rzp_test_sF7YXRcvBFlZKt';
  static const String googleClientId =
      '1064407958488-e3kmf6ff8fn2g2sl81rhit24v50s6km6.apps.googleusercontent.com';
  static const String googleClientSecret =
      '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';
  static showToast({BuildContext context, String text}) {
    return Toast(
            textColor: Colors.white,
            bgColor: Colors.red,
            textFontSize: 16.0,
            text: text)
        .showDialog(context);
  }

  static bool isTokenValid() {
    try {
      // bool isTokenExpired = JwtDecoder.isExpired(token);
      // if (isTokenExpired) {
      //   updateToken(null);
      // return false;
      // }
      return true;
    } catch (e) {
      return false;
    }
  }

  static showErrorToast({BuildContext context, String text}) {
    return Toast(
            textColor: Colors.white,
            bgColor: Colors.red,
            textFontSize: 16.0,
            text: text)
        .showDialog(context);
  }

  static showInfoToast({BuildContext context, String text}) {
    return Toast(
            textColor: Colors.white,
            bgColor: Colors.grey.withOpacity(0.5),
            textFontSize: 16.0,
            text: text)
        .showDialog(context);
  }

  static String formattedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        getParsedTime(min.toString()) + " : " + getParsedTime(sec.toString());

    return parsedTime;
  }

  static getDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String getTimeWithAmPm(String time, String dateTime) {
    return '${int.parse(time.split(':')[0]) > 13 ? int.parse(time.split(':')[0]) - 12 : int.parse(time.split(':')[0])}:${time.split(':')[1]} ${TimeOfDay.fromDateTime(DateTime.parse(dateTime)).periodOffset == 0 ? 'am' : 'pm'}';
  }

  static String stringForDatetime(String dt) {
    var dtInLocal = DateTime.parse(dt);
    //DateTime.fromMillisecondsSinceEpoch( 1490489845  * 1000).toLocal(); //year:  1490489845 //>day: 1556152819  //month:  1553561845  //<day: 1556174419
    var now = DateTime.now().toLocal();
    var dateString = " ";

    var diff = now.difference(dtInLocal);

    if (now.day == dtInLocal.day) {
      // creates format like: 12:35 PM,
      var todayFormat = DateFormat("h:mm a");
      dateString += todayFormat.format(dtInLocal);
    } else if ((diff.inDays) == 1 ||
        (diff.inSeconds < 86400 && now.day != dtInLocal.day)) {
      var yesterdayFormat = DateFormat("MMM d, h:mm a");
//      dateString += "Yesterday, " + yesterdayFormat.format(dtInLocal);
      dateString += yesterdayFormat.format(dtInLocal);
    } else if (now.year == dtInLocal.year && diff.inDays > 30) {
      var monthFormat = DateFormat("MMM d, h:mm a");
      dateString += monthFormat.format(dtInLocal);
    } else {
      var yearFormat = DateFormat("MMM d y");
      dateString += yearFormat.format(dtInLocal);
    }

    return dateString;
  }

  static String stringForDatetime2(String dt) {
    if (dt == null) {
      return 'N/A';
    }
    var dtInLocal = DateTime.parse(dt);
    //DateTime.fromMillisecondsSinceEpoch( 1490489845  * 1000).toLocal(); //year:  1490489845 //>day: 1556152819  //month:  1553561845  //<day: 1556174419
    var dateString = " ";

    var yearFormat = DateFormat("MMM d, y");
    dateString += yearFormat.format(dtInLocal);

    return dateString;
  }

  static String convertDate(String dt) {
    if (dt == null) {
      return 'N/A';
    }
    var dtInLocal = DateTime.parse(dt);
    //DateTime.fromMillisecondsSinceEpoch( 1490489845  * 1000).toLocal(); //year:  1490489845 //>day: 1556152819  //month:  1553561845  //<day: 1556174419
    var dateString = " ";

    var yearFormat = DateFormat("dd-MM-yyyy");
    dateString += yearFormat.format(dtInLocal);

    return dateString;
  }


  static String stringWeekDay(String dt) {
    var dtInLocal = DateTime.parse(dt);
    //DateTime.fromMillisecondsSinceEpoch( 1490489845  * 1000).toLocal(); //year:  1490489845 //>day: 1556152819  //month:  1553561845  //<day: 1556174419
    var dateString = " ";

    var yearFormat = DateFormat("EEEE d MMM, y");
    dateString += yearFormat.format(dtInLocal);

    return dateString;
  }

  static String stringForDatetime3(String dt) {
    if (dt == null) {
      return 'N/A';
    }
    var dtInLocal = DateTime.parse(dt);
    //DateTime.fromMillisecondsSinceEpoch( 1490489845  * 1000).toLocal(); //year:  1490489845 //>day: 1556152819  //month:  1553561845  //<day: 1556174419
    var dateString = " ";

    var yearFormat = DateFormat("dd-MM-yyyy");
    dateString += yearFormat.format(dtInLocal);

    return dateString;
  }

  static Future<bool> onWillPop(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            // title: new Text('Are you sure?'),
            backgroundColor: AppColors.BACK_GROUND_BG,
            content: new Text(
              "EXIT APP",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  "NO",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              new FlatButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                color: AppConstants.primaryColor,
                child: new Text(
                  "YES",
                  style: TextStyle(
                    color: AppConstants.white,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  static String formatDate(String dt) {
    var dtInLocal = DateTime.parse(dt);
    var format = DateFormat("yyyy-MM-dd");
    // var format = DateFormat("d/MM/y");
//    var format = DateFormat.YEAR_NUM_MONTH_DAY;

    return format.format(dtInLocal);
  }

  static String formatDate2(String dt) {
    var dtInLocal = DateTime.parse(dt);
    var format = DateFormat("dd-MM-yyyy");
    // var format = DateFormat("d/MM/y");
//    var format = DateFormat.YEAR_NUM_MONTH_DAY;

    return format.format(dtInLocal);
  }

  static String stringForDatetimeDT(DateTime dt) {
    var dtInLocal = dt.toLocal();
    print('DATE: $dtInLocal');
    //DateTime.fromMillisecondsSinceEpoch( 1490489845  * 1000).toLocal(); //year:  1490489845 //>day: 1556152819  //month:  1553561845  //<day: 1556174419
    var now = DateTime.now().toLocal();
    var dateString = " ";

    var diff = now.difference(dtInLocal);

    if (now.day == dtInLocal.day) {
      // creates format like: 12:35 PM,
//      var todayFormat = DateFormat("h:mm a");
      dateString += 'Today';
    } else if ((diff.inDays) == 1 ||
        (diff.inSeconds < 86400 && now.day != dtInLocal.day)) {
      var yesterdayFormat = DateFormat("MMM d");
      dateString += yesterdayFormat.format(dtInLocal);
    } else if (now.year == dtInLocal.year && diff.inDays > 1) {
      var monthFormat = DateFormat("MMM d");
      dateString += monthFormat.format(dtInLocal);
    } else {
      var yearFormat = DateFormat("MMM d y");
      dateString += yearFormat.format(dtInLocal);
    }

    return dateString;
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
}
