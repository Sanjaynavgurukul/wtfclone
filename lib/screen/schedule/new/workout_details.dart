import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
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

class _WorkoutDetailsState extends State<WorkoutDetails> {
  GymStore user;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
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
      print('cover Image --- ${args.coverImage}');
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.BACK_GROUND_BG,
          title: Text('Exercise'),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 200),
            child: Container(
              child: Image.network(
                '${args.coverImage}',
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                      child: Text(
                        "Failed",
                      ));
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
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: ()=>Navigator.pop(context),
          child: Container(
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
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(top: 16, bottom: 76),
            itemCount: exList.length,
            itemBuilder: (context, index) {
              Exercise item = exList[index];
              bool displayTimer = displayCountDown(itemUid: item.uid);
              bool completed = item.status == 'done';
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
                    if(!completed) {
                      // if(displayTimer){
                        exTimerHelper.setExUid(itemUid: item.uid);
                        NavigationService.pushName(Routes.exStartScreen,argument: ExPlayDetailsArgument(data: item,timeCount: exTimerHelper.convertMil(true))).then((value){
                          setState(() {

                          });
                        });
                      // }else{
                      //   FlashHelper.informationBar(
                      //     context,
                      //     message: 'Already Running another exercise please complete then start this one!',
                      //   );
                      // }
                    }else{
                      FlashHelper.informationBar(
                        context,
                        message: 'Exercise Already Completed',
                      );
                    }
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
                        ? Text('Resume')
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
