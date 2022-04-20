import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:video_player/video_player.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/screen/schedule/arguments/ex_play_details_argument.dart';
import 'package:wtf/screen/schedule/exercise/exercise_start/exercise_result.dart';
import 'package:wtf/screen/schedule/exercise/exercise_start/exercise_start_info.dart';
import 'package:wtf/screen/schedule/exercise/exercise_video.dart';
import 'package:wtf/screen/schedule/new/timer_helper/exercise_timer_helper.dart';
import 'package:wtf/screen/schedule/new/timer_helper/global_timer_helper.dart';

class ExStartScreen extends StatefulWidget {
  static const routeName = '/exStartScreen';

  const ExStartScreen({Key key}) : super(key: key);

  @override
  _ExStartScreenState createState() => _ExStartScreenState();
}

class _ExStartScreenState extends State<ExStartScreen> {
  GymStore user;
  StopWatchTimer _stopWatchTimer;
  VideoPlayerController _controller;
  bool workoutPaused = false;
  int exSet = 1;

  final setCount = BehaviorSubject<int>();

  Function(int) get setSetsCount => setCount.sink.add;

  Stream<int> get getSetsCount => setCount.stream;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: exTimerHelper.convertMil(true),
      mode: StopWatchMode.countUp,
    );
    this.exSet = getSetsFromLocal;
    this.workoutPaused = isExPaused();
    if (workoutPaused) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  @override
  void dispose() async {
    super.dispose();
    // stopTimer();
    await _stopWatchTimer.dispose();
    _controller.dispose();
    setCount.close();
  }

  void playVideo({@required String videoUrl}) {
    print('This is video URl -- $videoUrl');
    _controller = VideoPlayerController.network(
      '$videoUrl',
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) {
      _controller.play();
      _controller.addListener(() {});
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      if (mounted) setState(() {});
    });
  }

  void startTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void setSetsInLocal(int sets) {
    print('setting reps --- $sets');
    locator<AppPrefs>().exerciseSet.setValue(sets);
    print('setting reps --- from pref ${locator<AppPrefs>().exerciseSet.getValue()}');
  }

  int getSetsFromLocal = locator<AppPrefs>().exerciseSet.getValue();

  bool validateSetRep({@required String set}) {
    // locator<AppPrefs>().exerciseSet.setValue(1);
    int i = int.parse(set ?? '0');
    print('check current count --- $i $exSet');
    if (exSet < i) {
      return true;
    } else {
      return false;
    }
  }

  bool isExPaused() {
    return locator<AppPrefs>().exercisePause.getValue();
  }

  void setExPause(bool pause) {
    if (pause) {
      stopTimer();
    } else {
      startTimer();
    }
    locator<AppPrefs>().exercisePause.setValue(pause);
  }

  void endExercise({@required Exercise item,})async{
    showLoadingDialog(context);
    print('End Exercise ----');
    bool saved = await user.updateScheduleExercise(itemUid: item.uid,exTime: exTimerHelper.getPreviousTimerFromLocal(true).toString());
    if(saved){
      stopTimer();
      locator<AppPrefs>().startExTimer.setValue(0);
      locator<AppPrefs>().exerciseUid.setValue('');
      locator<AppPrefs>().exerciseSet.setValue(1);
      locator<AppPrefs>().exercisePause.setValue(false);
      await user.getScheduledWorkouts(date: user.workoutDate,addonId: user.workoutAddonId,subscriptionId: user.workoutSubscriptionId);
      Navigator.pop(context);
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
      FlashHelper.informationBar(context,
          message: 'Something Went Wrong!!');
    }
  }

  static Future<void> showLoadingDialog(
      BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                  backgroundColor: Colors.black45,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CupertinoActivityIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    final ExPlayDetailsArgument args =
    ModalRoute.of(context).settings.arguments as ExPlayDetailsArgument;
    if (args == null || args.data == null) {
      return Center(
        child: Text('Something went wrong pleas try again later!'),
      );
    } else {
      //Argument Data :D
      Exercise data = args.data;

      //Load Video :D
      print('check data : ${data.video}  ${data.woName}');
      playVideo(videoUrl: data.video);

      return Consumer<GymStore>(
          builder: (context, store, child) => WillPopScope(
            onWillPop: () async {
              return true;
              // if (localTimer != null && localTimer.stopwatch.isRunning) {
              //   FlashHelper.informationBar(context,
              //       message: 'Please complete Exercise first.');
              //   return false;
              // } else {
              //   return true;
              // }
            },
            child: SafeArea(
              child: Scaffold(
                bottomNavigationBar: Material(
                  elevation: 12.0,
                  child: IntrinsicHeight(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                        left: 16.0,
                        right: 16.0,
                        top: 12.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ExerciseStartInfo(
                            data: data,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          StreamBuilder<int>(
                            stream: _stopWatchTimer.secondTime,
                            initialData: _stopWatchTimer.secondTime.value,
                            builder: (context, snap) {
                              final value = snap.data;
                              print('Listen every second. $value');
                              exTimerHelper.setTimeInLocal(
                                  isEx: true, counter: snap.data);
                              return ExerciseResult(
                                // h: h,
                                h: timerHelper.convertHour(value),
                                m: timerHelper.convertMin(value),
                                s: timerHelper.convertSec(value),
                              );
                              // return Text(
                              //   '${timerHelper.convertHour(value)}:${timerHelper.convertMin(value)}:${timerHelper.convertSec(value)}',
                              // );
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          StreamBuilder(
                            stream: setCount,
                            initialData: exSet,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              return InkWell(
                                onTap: () {
                                  if (!workoutPaused) {
                                    workoutPaused = true;
                                    setExPause(workoutPaused);

                                    if (validateSetRep(set: data.sets)) {
                                      exSet += 1;
                                      setSetsCount(exSet);
                                      setSetsInLocal(exSet);
                                      // this.workoutPaused = !workoutPaused;
                                      // setExPause(workoutPaused);
                                    } else {

                                      endExercise(item: data);
                                    }
                                  } else {
                                    workoutPaused = false;
                                    setExPause(workoutPaused);
                                    setSetsCount(exSet);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 54,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      color: AppConstants.bgColor),
                                  child: workoutPaused
                                      ? Text('Resume')
                                      : Text(
                                      'End set ${snapshot.data} of ${data.sets}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ExerciseStartButtons(),
                      SizedBox(
                        height: 15,
                      ),
                      ExerciseVideo(
                        controller: _controller,
                        onPausePlay: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      UIHelper.verticalSpace(30.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        child: Html(
                          data: data.description ?? ' - - -',
                          // padding: EdgeInsets.all(8.0),
                          // customRender: (node, children) {
                          //   if (node is dom.Element) {
                          //     switch (node.localName) {
                          //       case "custom_tag": // using this, you can handle custom tags in your HTML
                          //         return Column(children: children);
                          //     }
                          //   }
                          // },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      );
    }
  }

}