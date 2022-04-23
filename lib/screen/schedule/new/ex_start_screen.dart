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

class ExStartScreen extends StatefulWidget {
  static const routeName = '/exStartScreen';

  const ExStartScreen({Key key}) : super(key: key);

  @override
  _ExStartScreenState createState() => _ExStartScreenState();
}

class _ExStartScreenState extends State<ExStartScreen> {
  GymStore user;
  StopWatchTimer _stopWatchTimer;
  bool workoutPaused = false;
  int exSet = 1;
  bool endingProcess = false;
  int preTimerFromLocal = 0;

  final setCount = BehaviorSubject<int>();

  Function(int) get setSetsCount => setCount.sink.add;

  Stream<int> get getSetsCount => setCount.stream;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
    //Set Pre Data Sets :D
    this.exSet = getSetsFromLocal;
    this.workoutPaused = isExPaused();
    preTimerFromLocal = exTimerHelper.convertMil(true);
    setPreData(preTimerFromLocal);

    if(!workoutPaused && !endingProcess)
      startTimer();
    else{
      stopTimer();
    }
  }

  void setPreData(int time){
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: time,
      mode: StopWatchMode.countUp,
    );
  }

  @override
  void dispose() async {
    super.dispose();
    stopTimer();
    await _stopWatchTimer.dispose();
    setCount.close();
  }

  void startTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void setSetsInLocal(int sets) {
    locator<AppPrefs>().exerciseSet.setValue(sets);
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
    this.endingProcess = true;
    stopTimer();
    setState(() {

    });
    showLoadingDialog(context);
    print('End Exercise ----');
    bool saved = await user.updateScheduleExercise(itemUid: item.uid,exTime: exTimerHelper.getPreviousTimerFromLocal(true).toString());
    if(saved){
      print('End Exercise ---- saved timer');
      exTimerHelper.setExTimeToZero();
      print('End Exercise ---- saved timer zero ${locator<AppPrefs>().startExTimer.getValue()}');
      locator<AppPrefs>().exerciseUid.setValue('');
      print('End Exercise ---- saved exercise uid empty ${locator<AppPrefs>().exerciseUid.getValue()}');
      locator<AppPrefs>().exerciseSet.setValue(1);
      print('End Exercise ---- saved exercise sets empty ${locator<AppPrefs>().exerciseSet.getValue()}');
      locator<AppPrefs>().exercisePause.setValue(false);
      print('End Exercise ---- saved exercise paused to false  ${locator<AppPrefs>().exercisePause.getValue()}');
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
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
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
                              if(!endingProcess) exTimerHelper.setTimeInLocal(
                                  isEx: true, counter: snap.data);
                              print('Check Tiemr after save --- ${locator<AppPrefs>().startExTimer.getValue()}');
                              return ExerciseResult(
                                // h: h,
                                h: exTimerHelper.convertHour(value),
                                m: exTimerHelper.convertMin(value),
                                s: exTimerHelper.convertSec(value),
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
                      VideoPlayerScreen(url: data.video,isPlaying:(val){}),

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

class VideoPlayerScreen extends StatefulWidget {
   VideoPlayerScreen({Key key,@required this.url,this.isPlaying,this.enableVolume = true,this.onVolume}) : super(key: key);
  final String url;
   bool enableVolume;
  final Function(bool) isPlaying;
  final Function(bool) onVolume;


  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url??"https://d1gzvbhpg92x41.cloudfront.net/workout_upload/TBLzo5i6OrtXo/1650287910669-cominghh_soon_-_42890%20%28Original%29.mp4",
      videoPlayerOptions: VideoPlayerOptions(
      ),
    )..initialize().then((_) {
      _controller.play();
      _controller.setVolume(widget.enableVolume?1.0:0.0);
      _controller.addListener(() {
        print('check playing or not --- ${_controller.value.isPlaying}');
        widget.isPlaying(_controller.value.isPlaying);
      });
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      if (mounted) setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          },
          child: VideoPlayer(
            _controller,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(onPressed: (){
            if(_controller.value.volume != 0.0){
              setState(() {
                _controller.setVolume(0.0);
                widget.onVolume(false);
              });
            }else{
              setState(() {
                _controller.setVolume(1.0);
                widget.onVolume(true);
              });
            }
          }, icon: Icon(_controller.value.volume == 0.0?Icons.volume_off_sharp:Icons.volume_up)),
        ),
      ],
    );
    // return  ExerciseVideo(
    //   controller: _controller,
    //
    //   onPausePlay: () {
    //     setState(() {
    //       if( _controller.value.isPlaying){
    //         _controller.pause();
    //       }else{
    //         _controller.play();
    //       }
    //
    //     });
    //   },
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
