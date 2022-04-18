import 'dart:async';

import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/main.dart';

class GlobalTimerHelper{
  int _counter = 0;
  
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

  void setTimeInLocal() {
    int currentDate = DateTime.now()
        .subtract(Duration(
        hours: timerHelper.convertHour(_counter),
        seconds: timerHelper.convertSec(_counter),
        minutes: timerHelper.convertMin(_counter)))
        .millisecondsSinceEpoch;
    locator<AppPrefs>().globalTimer.setValue(currentDate);
  }

  int getGlobalTime() {
    return locator<AppPrefs>().globalTimer.getValue();
  }

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
  }

  int getPreviousTimerFromLocal() {
    DateTime date1 = DateTime.now();
    // DateTime date2 = DateTime.now().add(Duration(seconds: getGlobalTime()));
    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(timerHelper.getGlobalTime());
    final datedifferent = date1.difference(date2).inSeconds;
    print("something $datedifferent");

    return datedifferent;
  }

  //Watch Global Timer :D
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  StreamController<int> streamController;
  bool flag = true;

  Stream<int> stopWatchStream() {
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        timerHelper.counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      timerHelper.counter++;
      streamController.add(timerHelper.counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

}
final timerHelper = GlobalTimerHelper();