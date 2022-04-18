import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
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
import 'package:wtf/screen/schedule/new/timer_helper/global_timer_helper.dart';
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

  final watchUiStream = BehaviorSubject<int>();

  Function(int) get setWatchUiStream => watchUiStream.sink.add;

  Stream<int> get getWatchUiStream => watchUiStream.stream;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
    timerHelper.counter = timerHelper.getPreviousTimerFromLocal();
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
              floatingActionButton: FloatingActionButton.extended(
                heroTag: 'startFlag',
                onPressed: () {},
                label: Text(
                  displayTimer() ?'Stop' :'Completed',
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
                                displayTimer()
                                    ? StreamBuilder(
                                        stream: watchUiStream,
                                        initialData: timerHelper.counter,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<int> snapshot) {
                                          timerHelper.setTimeInLocal();

                                          hoursStr =timerHelper.convertHour(snapshot.data).toString();
                                          minutesStr =timerHelper.convertMin(snapshot.data).toString();
                                          secondsStr = timerHelper.convertSec(snapshot.data).toString();
                                          return Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 12),
                                            child: Text(
                                              "$hoursStr:$minutesStr:$secondsStr",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppConstants.bgColor
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container()
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
                              itemBuilder: (context, index) {
                                //Item
                                WorkoutScheduleData item =
                                    user.myWorkoutSchedule.data[index];
                                return itermCard(item:item);
                                // return WorkoutListItems(item);
                              }))),
            );
          }
        }
      });
    }
  }

  Widget itermCard({@required WorkoutScheduleData item}){
    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      child: InkWell(
        onTap: (){
          NavigationService.pushName(Routes.workoutDetails,argument: ExDetailsArgument(data: item.exercises));
        },
        child: Stack(
          children: [
            SizedBox(
              height: 200,
              child: GradientImageWidget(
                borderRadius: BorderRadius.circular(8.0),
                network: item.image != null
                    ? item.image
                    : Images.workoutImage,
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
            )
          ],
        ),
      ),
    );
  }

  bool displayTimer() {
    bool value = locator<AppPrefs>().exerciseOn.getValue();
    if(value && !callTimer){
      this.callTimer = true;
      timerHelper.timerStream = timerHelper.stopWatchStream();
      timerHelper.timerSubscription = timerHelper.timerStream.listen((int newTick) {
        setWatchUiStream(newTick);
      });
    }
    return value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timerHelper.setTimeInLocal();
    if(watchUiStream != null ) watchUiStream.close();
    if (timerHelper.timerSubscription != null) timerHelper.timerSubscription.cancel();
    if (timerHelper.streamController != null) timerHelper.streamController.close();
    super.dispose();
  }


}

class WorkoutListItems extends StatelessWidget {
  final WorkoutScheduleData schedule;

  const WorkoutListItems(this.schedule);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => InkWell(
        onTap: schedule.exercises.map((e) => e.status == 'done').toList()[0]
            ? null
            : () {
                //This is my Code

                if (store.workoutGlobalTimer == null) {
                  if (schedule.isCompleted ||
                      schedule.exercises
                          .map((e) =>
                      e.eDuration != null && e.eDuration.isNotEmpty)
                          .toList()[0]) {
                    FlashHelper.informationBar(context,
                        message: 'Workout already completed');
                  } else {
                    context.read<GymStore>().setSchedule(
                      schedule: schedule,
                    );
                    locator<AppPrefs>().activeScheduleData.setValue(
                      schedule,
                    );
                    NavigationService.navigateTo(Routes.exercise);
                  }
                } else {
                  FlashHelper.informationBar(
                    context,
                    message: 'Please start workout first',
                  );
                }
                // context.read<GymStore>().getWorkoutDetail(id: id).then((value) {
                //
                //   print(
                //       'From MySchedule ${context.read<GymStore>().workoutDetails.toJson()}');
                //
                // });
              },
        child: Card(
          color: Colors.transparent,
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          child: Stack(
            children: [
              SizedBox(
                height: 200,
                child: GradientImageWidget(
                  borderRadius: BorderRadius.circular(8.0),
                  network: schedule.image != null
                      ? schedule.image
                      : Images.workoutImage,
                ),
              ),
              // Container(
              //   height: 200.0,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16.0),
              //     color: Colors.white,
              //     gradient: LinearGradient(
              //       begin: FractionalOffset.topCenter,
              //       end: FractionalOffset.bottomCenter,
              //       colors: const [
              //         Colors.transparent,
              //         AppConstants.red,
              //       ],
              //       stops: const [0.6, 1.0],
              //     ),
              //     image: DecorationImage(
              //       image: NetworkImage(
              //         schedule.image != null
              //             ? schedule.image
              //             : 'https://image.shutterstock.com/image-photo/beautiful-caucasian-girl-mask-gloves-260nw-1762071794.jpg',
              //       ),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
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
                      text: schedule.category + ' ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      children: [
                        if (schedule.exercises
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
