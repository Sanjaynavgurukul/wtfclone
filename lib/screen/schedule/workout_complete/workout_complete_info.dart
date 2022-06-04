import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/ui_helpers.dart';

class WorkoutCompleteInfo extends StatelessWidget {
  const WorkoutCompleteInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                //context.read<GymStore>().completedWorkout.data.eDuration ??
                    'N/A',
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              UIHelper.verticalSpace(8.0),
              Text(
                'Total Duration',
                style: TextStyle(color: Colors.white60, fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
          Container(
            height: 80,
            width: 1,
            color: Colors.white60,
          ),
          Column(
            children: [
              Text(
                //'${context.read<GymStore>().completedWorkout.data.totalCaloriesBurn}' ??
                    '',
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              UIHelper.verticalSpace(8.0),
              Text(
                'Tentative Calories Burnt',
                style: TextStyle(color: Colors.white60, fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ],
      ),
    );
  }
}
