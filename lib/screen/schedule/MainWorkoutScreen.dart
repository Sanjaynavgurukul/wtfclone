import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/screen/test.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../main.dart';

class MainWorkoutScreen extends StatefulWidget {
  @override
  _MainWorkoutScreenState createState() => _MainWorkoutScreenState();
}

class _MainWorkoutScreenState extends State<MainWorkoutScreen> {
  UserStore userStore;

  GymStore store;

  @override
  Widget build(BuildContext context) {
    userStore = context.watch<UserStore>();
    store = context.watch<GymStore>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(
            locator<AppPrefs>().selectedMyScheduleName.getValue().capitalize(),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: Consumer<GymStore>(
          builder: (context, store, child) => store.selectedWorkoutSchedule ==
                      null ||
                  (store.myWorkoutSchedule != null &&
                      store.myWorkoutSchedule.data.isNotEmpty)
              ? store.myWorkoutSchedule != null &&
                      store.myWorkoutSchedule.data.length > 0
                  ? CustomButton(
                      textColor: Colors.white,
                      bgColor: AppConstants.primaryColor,
                      text: store.workoutGlobalTimer != null
                          ? 'Stop'
                          : store.myWorkoutSchedule != null &&
                                  store.myWorkoutSchedule.data != null &&
                                  store.myWorkoutSchedule.data
                                      .map((e) =>
                                          e.isCompleted ||
                                          e.exercises
                                              .map((e) =>
                                                  e.eDuration != null &&
                                                  e.eDuration.isNotEmpty)
                                              .toList()[0])
                                      .toList()
                                      .isNotEmpty &&
                                  store.myWorkoutSchedule.data
                                      .map((e) =>
                                          e.isCompleted ||
                                          e.exercises
                                              .map((e) =>
                                                  e.eDuration != null &&
                                                  e.eDuration.isNotEmpty)
                                              .toList()[0])
                                      .toList()[0] &&
                                  store.selectedSchedule.workoutStatus
                              ? 'Completed'
                              : store.myWorkoutSchedule != null &&
                                      store.myWorkoutSchedule
                                              .workoutVerification !=
                                          null
                                  ? 'Resume'
                                  : 'Start',
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      onTap: () async {
                        print('dadad');
                        if (store.workoutGlobalTimer == null) {
                          if (locator<AppPrefs>()
                                  .selectedWorkoutDate
                                  .getValue() ==
                              Helper.formatDate2(
                                  DateTime.now().toIso8601String())) {
                            if (store.attendanceDetails != null &&
                                store.attendanceDetails.data != null) {
                              if (store.myWorkoutSchedule != null &&
                                  store.myWorkoutSchedule.data != null &&
                                  store.myWorkoutSchedule.data
                                      .map((e) =>
                                          e.isCompleted ||
                                          e.exercises
                                              .map(
                                                  (e) => e.eDuration.isNotEmpty)
                                              .toList()[0])
                                      .toList()
                                      .isNotEmpty &&
                                  store.myWorkoutSchedule.data
                                      .map((e) =>
                                          e.isCompleted ||
                                          e.exercises
                                              .map(
                                                  (e) => e.eDuration.isNotEmpty)
                                              .toList()[0])
                                      .toList()[0] &&
                                  store.selectedSchedule.workoutStatus) {
                                FlashHelper.informationBar(context,
                                    message: 'Workout Already completed');
                              } else {
                                if (store.myWorkoutSchedule
                                            .workoutVerification ==
                                        null ||
                                    store.myWorkoutSchedule.workoutVerification
                                            .eDuration ==
                                        null ||
                                    store.myWorkoutSchedule.workoutVerification
                                            .eDuration ==
                                        'NaN:NaN:NaN') {
                                  store.manageGlobalTimer(
                                    context: context,
                                    mode: 'start',
                                  );
                                } else {
                                  FlashHelper.informationBar(context,
                                      message: 'Workout Already completed');
                                }
                              }
                            } else {
                              FlashHelper.informationBar(
                                context,
                                message: 'Please mark your attendance first.',
                              );
                              NavigationService.navigateTo(
                                  Routes.mainAttendance);
                            }
                          } else {
                            FlashHelper.informationBar(
                              context,
                              message:
                                  'Only present day sessions can be started.',
                            );
                          }
                        } else {
                          if (store.workoutGlobalTimer.stopwatch.isRunning) {
                            store.manageGlobalTimer(
                              context: context,
                              mode: 'stop',
                              showCal: true,
                            );
                          }
                        }
                      },
                      radius: 12.0,
                    )
                  : CustomButton(
                      textColor: Colors.white,
                      bgColor: AppConstants.primaryColor,
                      text: 'Please ask trainer to assign workouts',
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      onTap: () async {
                        print('dadad');
                      },
                      radius: 12.0,
                    )
              : Container(
                  height: 3.0,
                  color: Colors.red,
                ),
        ),
        body: Consumer<GymStore>(
          builder: (context, store, child) => IntrinsicHeight(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UIHelper.verticalSpace(12.0),
                  if (store.currentTrainer != null &&
                      store.currentTrainer.data != null)
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 16.0,
                          ),
                          color: AppConstants.primaryColor.withOpacity(0.4),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 36.0,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                backgroundImage:
                                    store.currentTrainer.data.trainerProfile !=
                                            null
                                        ? NetworkImage(
                                            store.currentTrainer.data
                                                .trainerProfile,
                                          )
                                        : null,
                              ),
                              UIHelper.horizontalSpace(12.0),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Trainer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  UIHelper.verticalSpace(10.0),
                                  Text(
                                    store.currentTrainer.data.trainerName ?? '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  UIHelper.verticalSpace(6.0),
                                  if (store.currentTrainer.data.rating != '0')
                                    Text(
                                      store.currentTrainer.data.rating + " ✩" ??
                                          '',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  UIHelper.verticalSpace(8.0),
                                  if (store.myWorkoutSchedule != null &&
                                      store.myWorkoutSchedule
                                              .workoutVerification !=
                                          null &&
                                      !store.myWorkoutSchedule
                                          .workoutVerification.eDuration
                                          .contains('NaN'))
                                    RichText(
                                      text: TextSpan(
                                        text: 'Total Duration - ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: store.myWorkoutSchedule
                                                .workoutVerification.eDuration
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  UIHelper.verticalSpace(4.0),
                                  if (store.myWorkoutSchedule != null &&
                                      store.myWorkoutSchedule
                                              .workoutVerification !=
                                          null &&
                                      !store.myWorkoutSchedule
                                          .workoutVerification.eDuration
                                          .contains('NaN'))
                                    RichText(
                                      text: TextSpan(
                                        text: 'Total Calories Burned - ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: store.myWorkoutSchedule
                                                .workoutVerification.eCalories
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        AnimatedPositioned(
                          top: 12.0,
                          right: 24.0,
                          child: Image.asset('assets/images/certified.png'),
                          duration: Duration(milliseconds: 650),
                        )
                      ],
                    ),
                  UIHelper.verticalSpace(12.0),
                  if (store.workoutGlobalTimer != null)
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Current Active Workout',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                            UIHelper.verticalSpace(12.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    store.selectedWorkoutSchedule?.image != null
                                        ? store.selectedWorkoutSchedule.image
                                        : 'https://image.shutterstock.com/image-photo/beautiful-caucasian-girl-mask-gloves-260nw-1762071794.jpg',
                                  ),
                                  radius: 30.0,
                                ),
                                UIHelper.horizontalSpace(12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // store.selectedWorkoutSchedule?.category ??
                                      'Started',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    UIHelper.verticalSpace(12.0),
                                    Row(
                                      children: [
                                        Text(
                                          'Time Elapsed: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        if (store.workoutGlobalTimer != null)
                                          TimerText(
                                            dependencies:
                                                store.workoutGlobalTimer,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (store.myWorkoutSchedule != null)
                    SizedBox(
                      height: 20,
                    ),
                  Consumer<GymStore>(
                    builder: (context, store, child) =>
                        store.myWorkoutSchedule != null
                            ? store.myWorkoutSchedule.data.length > 0
                                ? Wrap(
                                    children: store.myWorkoutSchedule.data
                                        .map(
                                          (e) => WorkoutListItems(e),
                                        )
                                        .toList(),
                                  )
                                : IntrinsicHeight(
                                    child: Container(
                                      height: 350.0,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'No Schedules!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: Loading(),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                if (store.workoutGlobalTimer != null) {
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

// class ListItems extends StatelessWidget {
//   final WorkoutScheduleData schedule;
//
//   const ListItems(this.schedule);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<GymStore>(
//       builder: (context, store, child) => InkWell(
//         onTap: schedule.exercises.map((e) => e.status == 'done').toList()[0]
//             ? null
//             : () async {
//                 if (store.selectedWorkoutSchedule != null) {
//                   await context
//                       .read<GymStore>()
//                       .setSchedule(schedule: schedule);
//                   locator<AppPrefs>().activeScheduleData.setValue(schedule);
//                   NavigationService.navigateTo(Routes.exercise);
//                 } else {
//                   FlashHelper.informationBar(
//                     context,
//                     message: 'Please start workout first',
//                   );
//                 }
//                 // context.read<GymStore>().getWorkoutDetail(id: id).then((value) {
//                 //
//                 //   print(
//                 //       'From MySchedule ${context.read<GymStore>().workoutDetails.toJson()}');
//                 //
//                 // });
//               },
//         child: Card(
//           color: Colors.transparent,
//           elevation: 0.0,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Flexible(
//                 flex: 4,
//                 child: Stack(
//                   children: [
//                     SizedBox(
//                       height: 200,
//                       child: GradientImageWidget(
//                         borderRadius: BorderRadius.circular(8.0),
//                         network: schedule.image,
//                       ),
//                     ),
//                     // Container(
//                     //   height: 200.0,
//                     //   decoration: BoxDecoration(
//                     //     borderRadius: BorderRadius.circular(16.0),
//                     //     color: Colors.white,
//                     //     gradient: LinearGradient(
//                     //       begin: FractionalOffset.topCenter,
//                     //       end: FractionalOffset.bottomCenter,
//                     //       colors: const [
//                     //         Colors.transparent,
//                     //         AppConstants.red,
//                     //       ],
//                     //       stops: const [0.6, 1.0],
//                     //     ),
//                     //     image: DecorationImage(
//                     //       image: NetworkImage(
//                     //         schedule.image != null
//                     //             ? schedule.image
//                     //             : 'https://image.shutterstock.com/image-photo/beautiful-caucasian-girl-mask-gloves-260nw-1762071794.jpg',
//                     //       ),
//                     //       fit: BoxFit.cover,
//                     //     ),
//                     //   ),
//                     // ),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16.0),
//                         color: Colors.white,
//                         gradient: LinearGradient(
//                           begin: FractionalOffset.topCenter,
//                           end: FractionalOffset.bottomCenter,
//                           colors: const [
//                             Colors.transparent,
//                             Colors.red,
//                           ],
//                           stops: const [0.4, 1.0],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 16.0,
//                       left: 0.0,
//                       right: 0.0,
//                       child: Center(
//                         child: Text(
//                           schedule.category,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.0,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
