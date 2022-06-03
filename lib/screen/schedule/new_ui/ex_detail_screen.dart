import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/db/db_provider.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/model/new_schedule_model.dart';
import 'package:wtf/screen/schedule/new/ex_start_screen.dart';
import 'package:wtf/screen/schedule/new_ui/argument/ex_detail_argument.dart';
import 'package:wtf/screen/schedule/timer_helper/exercise_timer_helper.dart';
import 'package:wtf/widget/progress_loader.dart';

class ExerciseDetailScreen extends StatefulWidget {
  static const String routeName = '/exerciseDetailScreen';

  const ExerciseDetailScreen({Key key}) : super(key: key);

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  NewScheduleDataExercisesData data;
  ScheduleLocalModelData localData;
  String localUid = '';
  GymStore user;
  StopWatchTimer _stopWatchTimer;
  bool isFreshPage = true;

  final timerStream2 = BehaviorSubject<int>();
  final upChangeStream = BehaviorSubject<bool>();

  Function(int) get setTimerStream2 => timerStream2.sink.add;

  Stream<int> get getTimerStream2 => timerStream2.stream;

  Function(bool) get setUpChangeStream => upChangeStream.sink.add;

  Stream<bool> get getUpChangeStream => upChangeStream.stream;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    timerStream2.close();
    upChangeStream.close();
    if (_stopWatchTimer != null) await _stopWatchTimer.dispose();
  }

  Widget getTimerWidget() {
    return Container(
      constraints: BoxConstraints(minWidth: 100),
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100), bottomLeft: Radius.circular(100))),
      child: StreamBuilder<int>(
        stream: _stopWatchTimer.secondTime,
        initialData: 0,
        builder: (context, snap) {
          int value = snap.data;
          exTimerHelper.setTimeInLocal(counter: value, isEx: false);
          return Text(
            '${exTimerHelper.convertHour(value)}:${exTimerHelper.convertMin(value)}:${exTimerHelper.convertSec(value)}',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseDetailArgument args =
        ModalRoute.of(context).settings.arguments as ExerciseDetailArgument;

    data = args.mainData;
    localData = args.localData;
    localUid = args.localUid;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        bottomNavigationBar: StreamBuilder(
          stream: upChangeStream,
          initialData: true,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Container(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(width: 1, color: Colors.white)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.call),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Call Trainer',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        onPressFirstTime();
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            border: Border.all(width: 1, color: Colors.white),
                            color: AppConstants.bgColor),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${getLabel()}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        body: args == null
            ? Center(
                child: Loading(),
              )
            : args.mainData == null
                ? Center(
                    child: Text('No Data Found'),
                  )
                : SingleChildScrollView(
                    child: StreamBuilder(
                      stream: upChangeStream,
                      initialData: true,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 300,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                        Colors.grey,
                                        Colors.transparent,
                                      ])),
                                  child: VideoPlayerScreen(
                                    url: '${args.mainData.video}',
                                    isPlaying: (val) {},
                                    isEx: true,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: SafeArea(
                                    child: StreamBuilder(
                                      stream: timerStream2,
                                      initialData: 0,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<int> snapshot) {
                                        if (snapshot.data != 0) {
                                          if (!localData.isPause)
                                            startTimer(
                                                sec: localData.seconds,
                                                startTime: localData.startTime);
                                          else
                                            stopTimer();
                                          return getTimerWidget();
                                        } else {
                                          return SizedBox(height: 0);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ///Exercise name :D
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: ListTile(
                                        title: Text(
                                      '${data.wo_name}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 26),
                                    )),
                                  ),
                                ),

                                ///Exercise other details
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 30,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            gradient:
                                                LinearGradient(colors: <Color>[
                                              AppColors.BACK_GROUND_BG,
                                              Colors.grey,
                                              AppColors.BACK_GROUND_BG,
                                            ]),
                                          ),
                                          child: Text(
                                              'Sets ${localData.setCompleted}/${convertStringToIntList(reps: data.reps).length}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(height: 12),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                                constraints: BoxConstraints(
                                                    minHeight: 60),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      end: Alignment.topCenter,
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      colors: <Color>[
                                                        AppColors
                                                            .BACK_GROUND_BG,
                                                        Colors.blue,
                                                        AppColors
                                                            .BACK_GROUND_BG,
                                                      ]),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        '${convertStringToIntList(reps: data.reps)[localData.setCompleted == 0 ? localData.setCompleted : localData.setCompleted - 1]}',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text('Reps',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                                constraints: BoxConstraints(
                                                    minHeight: 60),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      end: Alignment.topCenter,
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      colors: <Color>[
                                                        AppColors
                                                            .BACK_GROUND_BG,
                                                        Colors.blue,
                                                        AppColors
                                                            .BACK_GROUND_BG,
                                                      ]),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text: '30',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20)),
                                                          TextSpan(
                                                            text: ' sec',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text('Rest',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Html(
                                  data: args.mainData.description ?? ' - - -',
                                  style: {
                                    // some other granular customizations are also possible
                                    "tr": Style(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                    "th": Style(
                                      padding: EdgeInsets.all(6),
                                      backgroundColor: Colors.grey,
                                    ),
                                    "td": Style(
                                      padding: EdgeInsets.all(6),
                                      alignment: Alignment.topLeft,
                                    ),
                                    // text that renders h1 elements will be red
                                    "h1": Style(color: Colors.red),
                                    "h3": Style(color: Colors.red),
                                    "h4": Style(color: Colors.red),
                                  }),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                          ],
                        );
                      },
                    ),
                  ));
  }

  bool hasCommaInReps({@required String reps}) {
    if (reps.isEmpty || reps == null)
      return false;
    else {
      return reps.contains(',');
    }
  }

  void onPressFirstTime() {
    String label = getLabel();
    if (label == 'START') {
      localData.startTime = DateTime.now().millisecondsSinceEpoch;
      localData.isPause = false;
      localData.itemUid = data.uid;
      localData.setCompleted += 1;
      timerStream2.add(1);
      upChangeStream.add(true);
      Map<String, dynamic> map = ScheduleLocalModelData().toJson(localData);
      updateLogs(map);
    }
    if (label == 'STOP') {
      print('check length  ${localData.setCompleted}  ${convertStringToIntList(reps:data.reps).length}');
      if(localData.setCompleted == convertStringToIntList(reps:data.reps).length){
        print('check length hit');
        localData.isCompleted = true;
      }

      localData.seconds +=
          exTimerHelper.getTimeDiff(time: localData.startTime, wantInSec: true);
      localData.isPause = true;
      localData.startTime = 0;
      timerStream2.add(1);
      upChangeStream.add(true);
      Map<String, dynamic> map = ScheduleLocalModelData().toJson(localData);
      updateLogs(map);
      if(localData.isCompleted){
        Navigator.pop(context);
      }else{
        navToRestPage();
      }
    } else if (label == 'CONTINUE') {
      print('checking seconds ---- ${localData.seconds}');
      localData.startTime = DateTime.now().subtract(Duration(seconds: localData.seconds)).millisecondsSinceEpoch;
      localData.isPause = false;
      localData.setCompleted += 1;
      timerStream2.add(1);
      upChangeStream.add(true);
      Map<String, dynamic> map = ScheduleLocalModelData().toJson(localData);
      updateLogs(map);
    }else{
      print('Already Completed :D');
    }
  }

  void updateLogs(Map<String, dynamic> data) {
    Map<String,dynamic> map = {
      'uid': localUid,
      "user_id":locator<AppPrefs>().memberId.getValue(),
      "date":Helper.formatDate2(DateTime.now().toIso8601String()),
      "exercise":data
    };
    user.getMyScheduleLogs(callKey: 'is_update', body: map);
  }

  void navToRestPage() {
    print('Rest Time _______________________');
    NavigationService.pushName(Routes.restScreen);
  }

  List<String> convertStringToIntList({@required String reps}) {
    bool hasComma = hasCommaInReps(reps: reps);

    if (hasComma) {
      List<String> dataList = reps.split(',');
      dataList.remove('');
      return dataList;
    } else {
      if (reps.isEmpty || reps == null)
        return [];
      else
        return [reps];
    }
  }

  Map<String, dynamic> convertModelToData() {
    Map<String, dynamic> map = {};
    return map;
  }

  String getLabel() {
    if (localData.isCompleted) {
      return 'COMPLETED';
    }else{
      if (localData.setCompleted == 0 && localData.isPause) {
        return 'START';
      } else if (localData.setCompleted != 0 && !localData.isPause) {
        return 'STOP';
      } else if (localData.setCompleted != 0 && localData.isPause) {
        return 'CONTINUE';
      } else {
        return 'START';
      }
    }
  }

  void startTimer({int sec, int startTime}) {
    int milSec = 0;
    int getDifInMilSec = exTimerHelper.getTimeDiff(time: startTime);
    print('checking data time dif ---- ${getDifInMilSec} $startTime');
    int finalSec = getDifInMilSec + sec;
    milSec = finalSec;
    print('checking data time ---- ${milSec}');
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: milSec,
      mode: StopWatchMode.countUp,
    );

    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }
}
