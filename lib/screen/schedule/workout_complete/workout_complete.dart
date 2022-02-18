import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/schedule/workout_complete/rate_session.dart';
import 'package:wtf/screen/schedule/workout_complete/success_image.dart';
import 'package:wtf/screen/schedule/workout_complete/workout_complete_buttons.dart';
import 'package:wtf/screen/schedule/workout_complete/workout_complete_info.dart';

import '../../../main.dart';

class WorkoutComplete extends StatefulWidget {
  const WorkoutComplete({Key key}) : super(key: key);

  @override
  State<WorkoutComplete> createState() => _WorkoutCompleteState();
}

class _WorkoutCompleteState extends State<WorkoutComplete> {
  GymStore store;
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      bottomNavigationBar: WorkoutCompleteButtons(),
      body: Consumer<GymStore>(
        builder: (context, store, child) => Column(
          children: [
            // SizedBox(height: kToolbarHeight,),
            SuccessImage(),
            Text(
              locator<AppPrefs>().selectedMySchedule.getValue(),
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'WORKOUT COMPLETED',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white70,
              ),
            ),
            UIHelper.verticalSpace(20.0),
            WorkoutCompleteInfo(),
            UIHelper.verticalSpace(30.0),
            RateSession(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    store.selectedWorkoutSchedule = null;
    super.dispose();
  }
}
