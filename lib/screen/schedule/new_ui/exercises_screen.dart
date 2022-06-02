import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/new_schedule_model.dart';
import 'package:wtf/screen/common_widgets/common_banner.dart';
import 'package:wtf/screen/new_qr/argument/qr_argument.dart';
import 'package:wtf/screen/new_qr/qr_scanner.dart';
import 'package:wtf/screen/schedule/new_ui/argument/ex_detail_argument.dart';
import 'package:wtf/screen/schedule/timer_helper/exercise_timer_helper.dart';
import 'package:wtf/widget/progress_loader.dart';

class ExercisesScreen extends StatefulWidget {
  static const String routeName = '/exercisesScreen';

  const ExercisesScreen({Key key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  double recommendedCircleHeight = 80.00;

  static const double EMPTY_SPACE = 10.0;
  ScrollController _scrollController;
  bool isScrolledToTop = true;
  bool callMethod = true;
  bool scheduleLogCallMethod = true;
  GymStore user;
  StopWatchTimer _stopWatchTimer;
  DateTime _selectedDate = DateTime.now();

  final dataStream = BehaviorSubject<String>();

  final timerStream = BehaviorSubject<int>();

  Function(String) get setSetsCount => dataStream.sink.add;

  Stream<String> get getSetsCount => dataStream.stream;

  Function(int) get setTimerStream => timerStream.sink.add;

  Stream<int> get getTimerStream => timerStream.stream;

  @override
  void dispose() async {
    super.dispose();
    _scrollController.dispose();
    dataStream.close();
    timerStream.close();
    if (_stopWatchTimer != null) await _stopWatchTimer.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
    // var date =
    // Helper.formatDate2(DateTime.now().toIso8601String());
    // if(user.workoutDate.isEmpty || user.workoutDate == null){
    //   user.workoutDate = date;
    // }
  }

  void startTimer({int time}) {
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond:
          exTimerHelper.getTimeDiff(time: time),
      mode: StopWatchMode.countUp,
    );

    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void callData(String date) {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        user.getNewScheduleData();
        getLogData();
      }
    });
  }

  String getFormatDate() {
    final DateTime now = DateTime.now();
    String value = Helper.formatDate2(now.toIso8601String());
    return value;
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      //call setState only when values are about to change
      if (!isScrolledToTop) {
        setState(() {
          //reach the top
          isScrolledToTop = true;
        });
      }
    } else {
      //call setState only when values are about to change
      if (_scrollController.offset > EMPTY_SPACE && isScrolledToTop) {
        setState(() {
          //not the top
          isScrolledToTop = false;
        });
      }
    }
  }

  Widget getTimerWidget() {
    int d = user.scheduleLocalModel == null || user.scheduleLocalModel.is_started == null? 0:user.scheduleLocalModel.is_started;
    bool timeStarted = d == 1??false;
    //print('Is Started or not $timeStarted');
    return !timeStarted
        ? SizedBox(height: 0)
        : Container(
            constraints: BoxConstraints(minWidth: 100),
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100))),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.secondTime,
              initialData: 0,
              builder: (context, snap) {
                int value = snap.data;
                exTimerHelper.setTimeInLocal(counter: value, isEx: false);
                return Text(
                  '${exTimerHelper.convertHour(value)}:${exTimerHelper.convertMin(value)}:${exTimerHelper.convertSec(value)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                );
              },
            ),
          );
  }

  String getTodayDate() {
    return Helper.formatDate2(DateTime.now().toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(builder: (context, user, snapshot) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: isScrolledToTop ? 0 : 4,
            backgroundColor:
                isScrolledToTop ? Colors.transparent : AppColors.BACK_GROUND_BG,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text('Exercise'),
          ),
          body: Container(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Stack(
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
                          child: CommonBanner(bannerType: 'explore',height: 300,fraction: 1,),
                        ),
                        Positioned(
                          right: 0,
                          child: SafeArea(
                            child:  StreamBuilder(
                              stream: timerStream,
                              initialData: 0,
                              builder:
                                  (BuildContext context, AsyncSnapshot<int> snapshot) {
                                if(snapshot.data != 0){
                                  print('check global date timer ${user.scheduleLocalModel.global_time}');
                                  startTimer(time:user.scheduleLocalModel.global_time);
                                 return getTimerWidget();
                                }else{
                                  return SizedBox(height:0);
                                }

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.white,
                    selectedTextColor: Colors.black,
                    onDateChange: (dates) {
                      // New date selected
                      // setState(() {
                      //   _selectedDate = dates;
                      // });
                      // //_selectedDate = dates;
                      // var date =
                      // Helper.formatDate2(_selectedDate.toIso8601String());
                      // user.workoutDate = date;
                      //onRefreshPage();
                      this.callMethod = true;
                      String date = Helper.formatDate2(dates.toIso8601String());
                      dataStream.add(date);
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  StreamBuilder(
                    stream: dataStream,
                    initialData: getTodayDate(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      user.workoutDate = snapshot.data;
                      //Calling data
                      callData(snapshot.data);

                      print(
                          'check stream datya --- ${snapshot.data} ${user.workoutDate}');
                      if (user.newScheduleModel == null) {
                        return Center(
                          child: Loading(),
                        );
                      } else {
                        if (user.newScheduleModel.status == false) {
                          return Center(
                            child: Text('No Data Found'),
                          );
                        } else {
                          return Column(
                            children: [
                              ///this is start workout button :D
                              user.newScheduleModel.status != false
                                  ? InkWell(
                                      onTap: () =>
                                          takeActionOnStartWorkoutButton(),
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16),
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color: AppConstants.bgColor),
                                        child: Text(
                                          'Start Workout',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    ),
                              SizedBox(
                                height: 26,
                              ),
                              if (user.newScheduleModel.newScheduleCat !=
                                      null &&
                                  user.newScheduleModel.newScheduleCat
                                      .isNotEmpty)
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(
                                            'Today\'s Schedule',
                                            style: TextStyle(fontSize: 18),
                                          )),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.only(right: 16),
                                          child: Row(
                                            children: user
                                                .newScheduleModel.newScheduleCat
                                                .map((e) =>
                                                    scheduleExerciseItem(e))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(
                                  child: Text('No Exercise Found'),
                                ),

                              if (user.newScheduleModel.newScheduleData
                                      .isNotEmpty &&
                                  user.newScheduleModel.newScheduleData !=
                                      null &&
                                  user.newScheduleModel != null)
                                Container(
                                  child: Column(
                                    children: user
                                        .newScheduleModel.newScheduleData
                                        .map((e) => itemA(e))
                                        .toList(),
                                  ),
                                )
                              else
                                Container(
                                  child: Text('No Exercise Found'),
                                ),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ));
    });
  }

  Widget scheduleExerciseItem(NewScheduleCat item) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              width: recommendedCircleHeight,
              height: recommendedCircleHeight,
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE00303), Color(0xff485AFE)])),
              child: Container(
                  margin: EdgeInsets.all(2), child: networkImage(item.image))),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(top: 2, bottom: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE00303), Color(0xff485AFE)]),
                  border:
                      Border.all(width: 3, color: AppColors.BACK_GROUND_BG)),
              child: Text('${item.name}'),
            ),
          )
        ],
      ),
    );
  }

  Widget networkImage(String imageUrl, {double radius = 100}) {
    print('chech image url ---2 $imageUrl');
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: Colors.grey.shade200),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius), // Image border
        child: Image.network(
          '$imageUrl',
          fit: BoxFit.fill,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(100), // Image border
              child: Image.network(
                  'https://advancepetproduct.com/wp-content/uploads/2019/04/no-image.png',
                  fit: BoxFit.fill),
            );
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itemA(NewScheduleData item) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //     padding: EdgeInsets.only(left: 26),
          //     child: Text('Set',
          //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Column(
              children:
                  item.exercises.map((e) => itemCardXyz(item: e)).toList())
        ]);
  }

  Widget itemCardXyz({NewScheduleDataExercises item}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 24, right: 20),
              child: Text('Set ${item.set_no}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))),
          Column(
            children: item.exercises.map((e) {
              ScheduleLocalModelData d = getSingleDataByUid();
              return itemCard(item: e, data: d);
            }).toList(),
          )
        ]);
  }

  Widget itemCard(
      {bool selected = false,
      NewScheduleDataExercisesData item,
      ScheduleLocalModelData data}) {
    print('chech image url --- ${item}');
    return InkWell(
      onTap: () => takeItemNavigationAction(item: item, data: data),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 18),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(
                width: selected ? 1 : 0,
                color: !selected ? Colors.transparent : Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.green,
                ),
                height: 80,
                child: networkImage(item.category_image, radius: 8),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getPercentageView(),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text('${data.setCompleted}/${item.sets}'),
                      padding:
                          EdgeInsets.only(left: 6, right: 6, top: 1, bottom: 1),
                    ),
                    ListTile(
                      contentPadding:
                          EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                      title: Text('${item.wo_name}'),
                      trailing: data.isCompleted
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: Text("Resume"),
                            ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Set : ${item.sets}'),
                          Text('Reps : ${item.reps}')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ScheduleLocalModelData getSingleDataByUid() {
    return new ScheduleLocalModelData();
  }

  void takeActionOnStartWorkoutButton() async {
    if (user.attendanceDetails != null && user.attendanceDetails.data != null) {
      log('exerciseScreen attendance already marked on start workout button clicked :D----');
      logOnStartExercise();
    } else {
      log('exerciseScreen attendance not marked on start workout button clicked :( ----');
      bool status = await startWorkoutWarning();
      if (status) {
        navigateToQrScanner();
      } else {
        log('exerciseScreen user denied take further action :(');
      }
    }
  }

  Future<bool> startWorkoutWarning(
      {String heading = 'Some heading',
      String message = 'Some description here please'}) {
    return showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              Text(
                "$heading",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 15),
              Text("$message", style: TextStyle(color: Colors.black)),
              SizedBox(height: 20),
              Divider(
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getPercentageView() {
    return Container(
      width: 34,
      height: 4,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(100))),
    );
  }

  void takeItemNavigationAction(
      {NewScheduleDataExercisesData item, ScheduleLocalModelData data}) {
    if (user.attendanceDetails != null && user.attendanceDetails.data != null) {
      log('exerciseScreen attendance already marked ----');
      NavigationService.pushName(Routes.exerciseDetailScreen,
          argument: ExerciseDetailArgument(mainData: item, localData: data));
    } else {
      log('exerciseScreen attendance not marked opening qr code ----');
      navigateToQrScanner();
    }
  }

  void navigateToQrScanner() {
    NavigationService.pushName(Routes.qrScanner,
        argument: QrArgument(qrNavigation: QRNavigation.NAVIGATE_POP)).then((value){
          if(user.attendanceDetails != null && user.attendanceDetails.data != null){
            logOnStartExercise();
          }
    });
  }

  void logOnStartExercise() {
    log('exerciseScreen logOnStartExercise method called ---');
    Map<String, dynamic> data = {
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "date": "${getFormatDate()}",
      "exercises": "",
      "is_started": 1,
      'global_time': "${DateTime.now().millisecondsSinceEpoch}",
    };
    user.getMyScheduleLogs(callKey: 'is_started', body: data).then((value) => getLogData());
  }

  void getLogData() {
    Map<String, dynamic> data = {
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "date": "${getFormatDate()}",
    };
    user.getMyScheduleLogs(callKey: 'is_get', body: data).then((value) {
      print('check timer data --- called');
      //Control Timer Widget
      if(value != null){
        print('check timer data --- ${user.scheduleLocalModel.is_started}');
        timerStream.add(user.scheduleLocalModel.is_started);
      }else{
        print('check timer data --- null');
      }
    });
  }

}
