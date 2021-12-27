import 'package:fluttertoast/fluttertoast.dart';

class CommonFunction {
  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  static DateTime timeStampConvert(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  }

  //  DateFormat('yyyy-MM-dd').format(CommonFunction.timeStampConvert(int.parse(item.date))
  //                                           ),

  //  DateFormat('hh:mm').format(
  //                                           DateFormat('hh:mm')
  //                                               .parse(item.endTime)),
}
