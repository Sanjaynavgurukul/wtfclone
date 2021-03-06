// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'package:wtf/controller/gym_store.dart';
// import 'package:wtf/helper/AppPrefs.dart';
// import 'package:wtf/helper/Helper.dart';
// import 'package:wtf/helper/app_constants.dart';
// import 'package:wtf/helper/colors.dart';
// import 'package:wtf/helper/flash_helper.dart';
// import 'package:wtf/helper/navigation.dart';
// import 'package:wtf/helper/routes.dart';
// import 'package:wtf/helper/strings.dart';
// import 'package:wtf/main.dart';
// import 'package:wtf/model/my_workout_schedule_model.dart';
// import 'package:wtf/screen/schedule/arguments/ex_details_argument.dart';
// import 'package:wtf/screen/schedule/arguments/main_workout_argument.dart';
// import 'package:wtf/screen/schedule/timer_helper/exercise_timer_helper.dart';
// import 'package:wtf/widget/gradient_image_widget.dart';
// import 'package:wtf/widget/progress_loader.dart';
//
// class MainWorkout extends StatefulWidget {
//   static const routeName = '/mainWorkout';
//
//   const MainWorkout({Key key}) : super(key: key);
//
//   @override
//   _MainWorkoutState createState() => _MainWorkoutState();
// }
//
// class _MainWorkoutState extends State<MainWorkout> {
//   GymStore user;
//   bool trainerCalled = true;
//   bool workoutCalled = true;
//   bool callTimer = false;
//
//   StopWatchTimer _stopWatchTimer;
//
//   @override
//   void initState() {
//     super.initState();
//     _stopWatchTimer = StopWatchTimer(
//       presetMillisecond: exTimerHelper.convertMil(false),
//       mode: StopWatchMode.countUp,
//     );
//     if (globalTimerIsOn()) {
//       startTimer();
//     }
//   }
//
//   @override
//   void dispose() async {
//     super.dispose();
//     await _stopWatchTimer.dispose();
//   }
//
//   void startTimer() {
//     _stopWatchTimer.onExecute.add(StopWatchExecute.start);
//   }
//
//   void stopTimer() {
//     _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
//   }
//
//   void setExerciserOnStatus(bool status) {
//     locator<AppPrefs>().exerciseOn.setValue(status);
//   }
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     user = context.watch<GymStore>();
//     print('current check date -- ${user.workoutDate}');
//   }
//
//   // void callTrainer() {
//   //   print('called -----');
//   //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   //     if (trainerCalled) {
//   //       this.trainerCalled = false;
//   //       user.getScheduleTrainer();
//   //     }
//   //   });
//   // }
//
//   void callWorkouts(
//       {@required String date,
//         @required String subScriptionId,
//         @required String addonId}) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (workoutCalled) {
//         this.workoutCalled = false;
//         user.getScheduledWorkouts(
//             date: date, subscriptionId: subScriptionId, addonId: addonId);
//       }
//     });
//   }
//
//   void controlWorkout(MainWorkoutArgument args) {
//     String date = user.workoutDate;
//     String subId = args.data.uid;
//     String addonsId =
//     args.workoutType == 'General Training' ? null : args.data.addonId;
//
//     //Calling data :D
//     callWorkouts(date: date, subScriptionId: subId, addonId: addonsId);
//   }
//
//   bool allWorkoutCompleted() {
//     List<bool> data = [];
//     user.myWorkoutSchedule.data.forEach((element) {
//       if (element.exercises
//           .map((e) => e.eDuration != null && e.eDuration.isNotEmpty)
//           .toList()[0]) {
//         data.add(true);
//       } else {
//         data.add(false);
//       }
//     });
//     print('check list val --- ${data.toString()}');
//     if (data.contains(false)) {
//       return false;
//     } else {
//       return true;
//     }
//   }
//
//   void showSnack({@required String message}) {
//     FlashHelper.informationBar(
//       context,
//       message: '${message}',
//     );
//   }
//
//   void validateOnPress(String type) {
//     if (!allWorkoutCompleted()) {
//       print('sanjay here -- all workout is not completed');
//       if (globalTimerIsOn()) {
//         showSnack(
//             message: 'To end workout you have to complete all your exercises!');
//       } else {
//         startTimer();
//         locator<AppPrefs>().exerciseOn.setValue(true);
//         user.workoutNotification(
//           start: true,
//           header: type,
//         );
//         setState(() {});
//       }
//     } else {
//       print('sanjay here -- all workout is  completed');
//       if (globalTimerIsOn()) {
//         //todo here save Final Code :D
//         user.verifyCompletedWorkout(context: context).then((value) {
//           if (value != null) {
//             stopTimer();
//             locator<AppPrefs>().globalTimer.setValue(0);
//             locator<AppPrefs>().exerciseOn.setValue(false);
//             showSnack(message: 'Completed');
//             user.workoutNotification(start: false, header: '');
//             setState(() {});
//           } else {
//             showSnack(message: 'Workout already started!');
//           }
//         });
//       } else {
//         showSnack(message: 'All Workout Completed!');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final MainWorkoutArgument args =
//     ModalRoute.of(context).settings.arguments as MainWorkoutArgument;
//
//     if (args.data == null) {
//       return Center(
//         child: Text('Workout already started'),
//       );
//     } else {
//       return Consumer<GymStore>(builder: (context, user, child) {
//         if (user.currentTrainer == null || user.currentTrainer.data == null || user.myWorkoutSchedule == null || user.myWorkoutSchedule.data == null) {
//           return Center(
//             child: Loading()
//           );
//         } else {
//           if (args == null) {
//             return Center(child: Text('Something went wrong please try again later!'));
//           } else {
//             //call workout :d
//             //controlWorkout(args);
//             return Scaffold(
//               floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerFloat,
//               floatingActionButton: exTimerHelper.isSameTime(user.workoutDate) ? FloatingActionButton.extended(
//                 heroTag: 'startFlag',
//                 onPressed: () {
//                   print('cehck data date --  ${user.workoutDate}');
//                   if(user.workoutDate == Helper.formatDate2(
//                       DateTime.now().toIso8601String())){
//                     if(user.attendanceDetails != null &&
//                         user.attendanceDetails.data != null){
//                       validateOnPress(args.workoutType);
//                     }else{
//                       showSnack(message: 'Please mark your attendance first.');
//                       NavigationService.navigateTo(
//                           Routes.mainAttendance);
//                     }
//                   }else{
//                     showSnack(message: 'Only present day workout can be started.');
//                   }
//
//                   //TODO uncomment code change Here
//                   // validateOnPress(args.workoutType);
//                 },
//                 label: Text(
//                   globalTimerIsOn() ? 'End Workout' :allWorkoutCompleted()?'Completed': 'Start Workout',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 icon: globalTimerIsOn()
//                     ? Icon(Icons.pause_circle_filled)
//                     : Icon(Icons.play_circle_fill),
//               ):null,
//               body: DefaultTabController(
//                   length: 0,
//                   child: NestedScrollView(
//                       headerSliverBuilder:
//                           (BuildContext context, bool innerBoxIsScrolled) {
//                         return <Widget>[
//                           new SliverAppBar(
//                               title: Text(args.workoutType ?? 'No Name'),
//                               forceElevated: innerBoxIsScrolled,
//                               pinned: true,
//                               floating: true,
//                               bottom: PreferredSize(
//                                   preferredSize: Size(double.infinity, 100),
//                                   child: Padding(
//                                       child: ListTile(
//                                         title: Text('Current Trainer'),
//                                         subtitle: Column(
//                                           children: [
//                                             SizedBox(
//                                               height: 8,
//                                             ),
//                                             Text(
//                                                 '${user.currentTrainer.data.name ?? 'No Name'}'),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             Text(
//                                                 '${user.currentTrainer.data.description ?? ''}'),
//                                             SizedBox(
//                                               height: 4,
//                                             ),
//                                             RatingBar(
//                                               initialRating: double.parse(user
//                                                   .currentTrainer
//                                                   .data
//                                                   .rating ??
//                                                   '0.0'),
//                                               direction: Axis.horizontal,
//                                               allowHalfRating: true,
//                                               itemCount: 5,
//                                               itemSize: 16,
//                                               ignoreGestures: true,
//                                               ratingWidget: RatingWidget(
//                                                 full: Icon(
//                                                   Icons.star,
//                                                   color: AppConstants.bgColor,
//                                                 ),
//                                                 half: Icon(
//                                                   Icons.star_half,
//                                                   color: AppConstants.bgColor,
//                                                 ),
//                                                 empty: Icon(
//                                                   Icons.star_border_outlined,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                               itemPadding: EdgeInsets.symmetric(
//                                                   horizontal: 1.0),
//                                               onRatingUpdate: (rating) {
//                                                 print(rating);
//                                               },
//                                             ),
//                                           ],
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                         ),
//                                         leading: CircleAvatar(
//                                           radius: 30,
//                                           backgroundImage: NetworkImage(
//                                               '${user.currentTrainer.data.trainerProfile}' ??
//                                                   "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
//                                           backgroundColor: Colors.transparent,
//                                           child: Align(
//                                             alignment: Alignment.bottomRight,
//                                             child: Container(
//                                               width: 26,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(100)),
//                                                 color: AppColors.BACK_GROUND_BG,
//                                               ),
//                                               child: Image.asset(
//                                                 'assets/images/certified.png',
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         trailing: globalTimerIsOn() && exTimerHelper.isSameTime(user.workoutDate)
//                                             ? StreamBuilder<int>(
//                                           stream:
//                                           _stopWatchTimer.secondTime,
//                                           initialData: _stopWatchTimer
//                                               .secondTime.value,
//                                           builder: (context, snap) {
//                                             int value = snap.data;
//                                             exTimerHelper.setTimeInLocal(
//                                                 counter: value,
//                                                 isEx: false);
//                                             return  Text(
//                                               '${exTimerHelper.convertHour(value)}:${exTimerHelper.convertMin(value)}:${exTimerHelper.convertSec(value)}',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 30,
//                                                   fontWeight:
//                                                   FontWeight.w600),
//                                             );
//                                           },
//                                         )
//                                             : SizedBox(),
//                                       ),
//                                       padding: EdgeInsets.only(
//                                           left: 12,
//                                           right: 12,
//                                           top: 0,
//                                           bottom: 8))),
//                               backgroundColor: AppColors.BACK_GROUND_BG),
//                         ];
//                       },
//                       body: user.myWorkoutSchedule == null ||
//                           user.myWorkoutSchedule.data == null ||
//                           user.myWorkoutSchedule.data.length == 0
//                           ? Center(child: Text("no Workout available"))
//                           : ListView.builder(
//                           itemCount: user.myWorkoutSchedule.data.length,
//                           padding: EdgeInsets.only(bottom: 80),
//                           itemBuilder: (context, index) {
//                             WorkoutScheduleData item =
//                             user.myWorkoutSchedule.data[index];
//                             print('check list item image -- ${item.image}');
//
//                             return itermCard(item: item, index: index);
//                             // return WorkoutListItems(item);
//                           }))),
//             );
//           }
//         }
//       });
//     }
//   }
//
//   Widget itermCard(
//       {@required WorkoutScheduleData item, @required int index, String type}) {
//     bool isCompleted = item.exercises
//         .map((e) =>
//     e.eDuration != null && e.eDuration.isNotEmpty)
//         .toList()[0];
//     return Card(
//       color: Colors.transparent,
//       elevation: 0.0,
//       margin: const EdgeInsets.symmetric(
//         horizontal: 12.0,
//         vertical: 10.0,
//       ),
//       child: InkWell(
//         onTap: () {
//           //TODO code changed here if condition should be on true condition ;D
//           if(exTimerHelper.isSameTime(user.workoutDate)){
//             if (globalTimerIsOn()) {
//               if(!isCompleted){
//                 navigateToNext(item: item, index: index);
//               }else{
//                 showSnack(message: 'Workout Already Completed');
//               }
//             } else {
//               showSnack(message: 'Please Start Workout First');
//             }
//           }else{
//             showSnack(message: 'Only present day workout can be started.');
//           }
//         },
//         child: Stack(
//           children: [
//             SizedBox(
//               height: 200,
//               child: GradientImageWidget(
//                 borderRadius: BorderRadius.circular(8.0),
//                 network: item.image != null ? item.image : Images.workoutImage,
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.0),
//                 color: Colors.white,
//                 gradient: LinearGradient(
//                   begin: FractionalOffset.topCenter,
//                   end: FractionalOffset.bottomCenter,
//                   colors: const [
//                     Colors.transparent,
//                     Colors.red,
//                   ],
//                   stops: const [0.4, 1.0],
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 16.0,
//               left: 0.0,
//               right: 0.0,
//               child: Center(
//                 child: RichText(
//                   text: TextSpan(
//                     text: item.category + ' ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.0,
//                     ),
//                     children: [
//                       if (isCompleted)
//                         TextSpan(
//                           text: ' (Completed)',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 14.0,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             exTimerHelper.getInProgressItemUid(itemUid: item.category)
//                 ? Align(
//               alignment: Alignment.topRight,
//               child: Container(
//                   decoration: BoxDecoration(
//                       color: AppConstants.bgColor,
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(8))),
//                   padding: EdgeInsets.all(8),
//                   child: Text('In Progress')),
//             )
//                 : Container()
//           ],
//         ),
//       ),
//     );
//   }
//
//   void navigateToNext(
//       {@required WorkoutScheduleData item, @required int index}) {
//     NavigationService.pushName(Routes.workoutDetails,
//         argument: ExDetailsArgument(
//             data: item.exercises, coverImage: item.image, index: index));
//   }
//
//   bool globalTimerIsOn() {
//     bool isWorkoutOn = locator<AppPrefs>().exerciseOn.getValue();
//     return isWorkoutOn;
//   }
// }