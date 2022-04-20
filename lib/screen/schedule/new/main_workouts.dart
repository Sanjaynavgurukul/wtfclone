import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/screen/schedule/arguments/ex_details_argument.dart';
import 'package:wtf/screen/schedule/arguments/main_workout_argument.dart';
import 'package:wtf/screen/schedule/new/timer_helper/exercise_timer_helper.dart';
import 'package:wtf/widget/gradient_image_widget.dart';

class MainWorkout extends StatefulWidget {
  static const routeName = '/mainWorkout';

  const MainWorkout({Key key}) : super(key: key);

  @override
  _MainWorkoutState createState() => _MainWorkoutState();
}

class _MainWorkoutState extends State<MainWorkout> {
  GymStore user;
  bool trainerCalled = true;
  bool workoutCalled = true;
  bool callTimer = false;

  StopWatchTimer _stopWatchTimer;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: exTimerHelper.convertMil(false),
      mode: StopWatchMode.countUp,
    );

    if (validateGlobalTimer()) {
      startTimer();
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  void startTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void setExerciserOnStatus(bool status) {
    locator<AppPrefs>().exerciseOn.setValue(status);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  void callTrainer() {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (trainerCalled) {
        this.trainerCalled = false;
        user.getScheduleTrainer();
      }
    });
  }

  void callWorkouts(
      {@required String date,
      @required String subScriptionId,
      @required String addonId}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (workoutCalled) {
        this.workoutCalled = false;
        user.getScheduledWorkouts(
            date: date, subscriptionId: subScriptionId, addonId: addonId);
      }
    });
  }

  void controlWorkout(MainWorkoutArgument args) {
    String date = Helper.formatDate2(
      args.time.toIso8601String(),
    );
    String subId = args.data.uid;
    String addonsId =
        args.workoutType == 'General Training' ? null : args.data.addonId;

    //Calling data :D
    callWorkouts(date: date, subScriptionId: subId, addonId: addonsId);
  }

  @override
  Widget build(BuildContext context) {
    final MainWorkoutArgument args =
        ModalRoute.of(context).settings.arguments as MainWorkoutArgument;

    callTrainer();
    if (args.data == null) {
      return Center(
        child: Text('Something Went Wrong Please try again later'),
      );
    } else {
      return Consumer<GymStore>(builder: (context, user, child) {
        if (user.scheduleTrainer == null || user.scheduleTrainer.data == null) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          if (args == null) {
            return Center(child: Text('Something went Wrong'));
          } else {
            //call workout :d
            controlWorkout(args);

            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                heroTag: 'startFlag',
                onPressed: () {},
                label: Text(
                  validateGlobalTimer() ? 'End Workout' : 'Start Wworkout',
                  style: TextStyle(fontSize: 16),
                ),
                icon: Icon(Icons.add),
              ),
              body: DefaultTabController(
                  length: 0,
                  child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          new SliverAppBar(
                              title: Text(args.workoutType ?? 'No Name'),
                              forceElevated: innerBoxIsScrolled,
                              pinned: true,
                              floating: true,
                              actions: [
                                if (validateGlobalTimer())
                                  StreamBuilder<int>(
                                    stream: _stopWatchTimer.secondTime,
                                    initialData:
                                        _stopWatchTimer.secondTime.value,
                                    builder: (context, snap) {
                                      int value = snap.data;
                                      exTimerHelper.setTimeInLocal(
                                          counter: value, isEx: false);
                                      return Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          '${exTimerHelper.convertHour(value)}:${exTimerHelper.convertMin(value)}:${exTimerHelper.convertSec(value)}',
                                          style: TextStyle(
                                              color: AppConstants.bgColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      );
                                    },
                                  )
                                else
                                  Container(),
                              ],
                              bottom: PreferredSize(
                                  preferredSize: Size(double.infinity, 100),
                                  child: Padding(
                                      child: ListTile(
                                        title: Text('Current Trainer'),
                                        subtitle: Column(
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                '${user.scheduleTrainer.data.name ?? 'No Name'}'),
                                            Text(
                                                '${user.scheduleTrainer.data.description ?? ''}'),
                                            Text(
                                                '${user.scheduleTrainer.data.rating ?? ''}'),
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                        leading: Wrap(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  color: Colors.grey),
                                              width: 60,
                                              height: 60,
                                            ),
                                          ],
                                        ),
                                        trailing: Image.asset(
                                          'assets/images/certified.png',
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          top: 0,
                                          bottom: 8))),
                              backgroundColor: AppColors.BACK_GROUND_BG),
                        ];
                      },
                      body: user.myWorkoutSchedule == null ||
                              user.myWorkoutSchedule.data == null ||
                              user.myWorkoutSchedule.data.length == 0
                          ? Center(child: Text("no Workout available"))
                          : ListView.builder(
                              itemCount: user.myWorkoutSchedule.data.length,
                              padding: EdgeInsets.only(bottom: 80),
                              itemBuilder: (context, index) {
                                WorkoutScheduleData item =
                                    user.myWorkoutSchedule.data[index];
                                print('check list item image -- ${item.image}');
                                return itermCard(item: item);
                                // return WorkoutListItems(item);
                              }))),
            );
          }
        }
      });
    }
  }

  Widget itermCard({@required WorkoutScheduleData item}) {
    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      child: InkWell(
        onTap: () {
          if (validateGlobalTimer()) {
            navigateToNext(item: item);
          } else {
            // set up the button
            Widget okButton = InkWell(
              onTap: () {
                Navigator.pop(context);
                setExerciserOnStatus(true);
                startTimer();
                navigateToNext(item: item);
              },
              child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppConstants.bgColor),
                  child: Text("Start Workout",
                      style: TextStyle(color: Colors.white))),
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Warning!"),
              content: Text(
                "You haven\'t start workout!",
              ),
              actions: [
                okButton,
              ],
            );

            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }
        },
        child: Stack(
          children: [
            SizedBox(
              height: 200,
              child: GradientImageWidget(
                borderRadius: BorderRadius.circular(8.0),
                network: item.image != null ? item.image : Images.workoutImage,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: const [
                    Colors.transparent,
                    Colors.red,
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: item.category + ' ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    children: [
                      if (item.exercises
                          .map((e) =>
                              e.eDuration != null && e.eDuration.isNotEmpty)
                          .toList()[0])
                        TextSpan(
                          text: ' (Completed)',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            exTimerHelper.getInProgressItemUid(itemUid: item.category)?Align(
              alignment: Alignment.topRight,
              child: Container(
                  decoration: BoxDecoration(color: AppConstants.bgColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8))),
                  padding:EdgeInsets.all(8),
                  child: Text('In Progress')),
            ):Container()
          ],
        ),
      ),
    );
  }

  void navigateToNext({@required WorkoutScheduleData item}) {
    NavigationService.pushName(Routes.workoutDetails,
        argument:
            ExDetailsArgument(data: item.exercises, coverImage: item.image));
  }

  bool validateGlobalTimer() {
    bool isWorkoutOn = locator<AppPrefs>().exerciseOn.getValue();
    return isWorkoutOn;
  }
}
