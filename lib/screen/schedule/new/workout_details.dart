import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/screen/schedule/arguments/ex_details_argument.dart';
import 'package:wtf/screen/schedule/arguments/ex_play_details_argument.dart';
import 'package:wtf/screen/schedule/exercise/exercise_start/exercise_start.dart';
import 'package:wtf/screen/schedule/new/timer_helper/exercise_timer_helper.dart';
import 'package:wtf/screen/schedule/new/timer_helper/global_timer_helper.dart';

class WorkoutDetails extends StatefulWidget {
  static const routeName = '/workoutDetails';

  const WorkoutDetails({Key key}) : super(key: key);

  @override
  _WorkoutDetailsState createState() => _WorkoutDetailsState();
}

// class _WorkoutDetailsState extends State<WorkoutDetails> {
//
//   StopWatchTimer _stopWatchTimer;
//
//   @override
//   void initState() {
//     super.initState();
//     _stopWatchTimer = StopWatchTimer(
//       presetMillisecond: exTimerHelper.convertMil(true),
//       mode: StopWatchMode.countUp,
//     );
//   }
//
//   @override
//   void dispose() async {
//     super.dispose();
//     await _stopWatchTimer.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CountUp Sample'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(bottom: 0),
//               child: StreamBuilder<int>(
//                 stream: _stopWatchTimer.secondTime,
//                 initialData: _stopWatchTimer.secondTime.value,
//                 builder: (context, snap) {
//                   final value = snap.data;
//                   print('Listen every second. $value');
//                   exTimerHelper.setTimeInLocal(isEx: true, counter: snap.data);
//                   return Column(
//                     children: <Widget>[
//                       Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 4),
//                                 child: Text(
//                                   'second',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontFamily: 'Helvetica',
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                 const EdgeInsets.symmetric(horizontal: 4),
//                                 child: Text(
//                                   '${timerHelper.convertHour(value)}:${timerHelper.convertMin(value)}:${timerHelper.convertSec(value)}',
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     fontFamily: 'Helvetica',
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//             /// Button
//             Padding(
//               padding: const EdgeInsets.all(2),
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4),
//                           child: RaisedButton(
//                             padding: const EdgeInsets.all(4),
//                             color: Colors.lightBlue,
//                             shape: const StadiumBorder(),
//                             onPressed: () async {
//                               _stopWatchTimer.onExecute
//                                   .add(StopWatchExecute.start);
//                             },
//                             child: const Text(
//                               'Start',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4),
//                           child: RaisedButton(
//                             padding: const EdgeInsets.all(4),
//                             color: Colors.green,
//                             shape: const StadiumBorder(),
//                             onPressed: () async {
//                               _stopWatchTimer.onExecute
//                                   .add(StopWatchExecute.stop);
//                             },
//                             child: const Text(
//                               'Stop',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
//
//
//

class _WorkoutDetailsState extends State<WorkoutDetails> {
  GymStore user;
  StopWatchTimer _stopWatchTimer;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer(
      presetMillisecond: exTimerHelper.convertMil(true),
      mode: StopWatchMode.countUp,
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ExDetailsArgument args =
        ModalRoute.of(context).settings.arguments as ExDetailsArgument;
    if (args == null) {
      return Center(
        child: Text('Something Went Wrong Please try again later!'),
      );
    } else {
      var exList = args.data;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.BACK_GROUND_BG,
          title: Text('Exercise'),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 160),
            child: Container(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: 200,
          height: 54,
          alignment: Alignment.center,
          child: Text(
            'End Exercise',
            style: TextStyle(fontSize: 20),
          ),
          decoration: BoxDecoration(
              color: AppConstants.bgColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1, color: AppConstants.bgColor)),
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(top: 16, bottom: 76),
            itemCount: exList.length,
            itemBuilder: (context, index) {
              Exercise item = exList[index];
              bool displayTimer = displayCountDown(itemUid: item.uid);
              bool completed = item.status == 'done';
              if (displayTimer) {
                _stopWatchTimer.onExecute.add(StopWatchExecute.start);
              }
              return ListTile(
                dense: true,
                leading: Icon(
                  Icons.check_circle,
                  color:
                      completed ? Colors.green : Colors.grey.withOpacity(0.5),
                ),
                title: Text(
                  item.woName ?? 'No Name',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Reps : ${item.reps}   Sets : ${item.sets}'),
                trailing: InkWell(
                  onTap: () {
                    NavigationService.pushName(Routes.exStartScreen,argument: ExPlayDetailsArgument(data: item));
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => ExerciseStart(
                    //       data: item,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            width: 1,
                            color: displayTimer
                                ? AppConstants.bgColor
                                : Colors.white)),
                    child: displayTimer && !completed
                        ? StreamBuilder<int>(
                            stream: _stopWatchTimer.secondTime,
                            initialData: _stopWatchTimer.secondTime.value,
                            builder: (context, snap) {
                              final value = snap.data;
                              print('Listen every second. $value');
                              exTimerHelper.setTimeInLocal(
                                  isEx: true, counter: snap.data);
                              return Text(
                                '${timerHelper.convertHour(value)}:${timerHelper.convertMin(value)}:${timerHelper.convertSec(value)}',
                              );
                            },
                          )
                        : Text(completed ? 'Completed' : 'Start'),
                  ),
                ),
              );
            }),
      );
    }
  }

  bool displayCountDown({@required String itemUid}) {
    String value = locator<AppPrefs>().exerciseUid.getValue();
    if (value != null && value == itemUid) {
      return true;
    } else {
      return false;
    }
  }
}
