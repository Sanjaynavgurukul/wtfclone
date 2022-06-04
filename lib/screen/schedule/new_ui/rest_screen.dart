import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/screen/schedule/timer_helper/exercise_timer_helper.dart';

class RestScreen extends StatefulWidget {
  static const String routeName = '/restScreen';
  const RestScreen({Key key}) : super(key: key);

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  StopWatchTimer _stopWatchTimer3;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void back(){
    startTimer();
    Future.delayed(const Duration(seconds: 30), () {
     if(mounted)
        Navigator.pop(context);
    });
  }

  @override
  void dispose() async {
    super.dispose();
    if (_stopWatchTimer3 != null) await _stopWatchTimer3.dispose();
  }

  void startTimer() {
    _stopWatchTimer3.onExecute.add(StopWatchExecute.start);
  }

  void stopTimer() {
    _stopWatchTimer3.onExecute.add(StopWatchExecute.stop);
  }

  @override
  Widget build(BuildContext context) {
    _stopWatchTimer3 = StopWatchTimer(
      presetMillisecond: 30000,
      mode: StopWatchMode.countDown,
    );
    back();
    return Scaffold(
      body: Column(
        children: [
          // Load a Lottie file from your assets
          Lottie.asset('assets/lottie/stay_loader.json'),
          SizedBox(height:40),
          Text('Breathe',style:TextStyle(fontSize: 30)),
          SizedBox(height:30),
          StreamBuilder<int>(
            stream: _stopWatchTimer3.secondTime,
            initialData: 0,
            builder: (context, snap) {
              int value = snap.data;
              return Text(
                '${exTimerHelper.convertSec(value)}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600),
              );
            },
          ),
          SizedBox(height:8),
          Text('Sec',style:TextStyle(fontSize: 14)),
          SizedBox(height:30),
          InkWell(
            onTap:(){
              Navigator.pop(context);
            },
            child: Container(margin: EdgeInsets.only(left: 24,right:24),
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(minWidth: 200,),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.all(Radius.circular(100)),
                color:AppConstants.bgColor
              ),
              child: Text('Resume',style:TextStyle(fontSize: 16)),
            ),
          )
        ],
      )
    );
  }
}
