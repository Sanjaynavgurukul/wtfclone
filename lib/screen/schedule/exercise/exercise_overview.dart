import 'package:flutter/material.dart';
import 'package:wtf/screen/schedule/exercise/todays_workout.dart';
import 'package:wtf/screen/schedule/exercise/white_button.dart';

class ExerciseOverview extends StatelessWidget {
  const ExerciseOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1,
          color: Colors.white12,
          indent: 25,
          endIndent: 25,
        ),
        SizedBox(
          height: 20,
        ),
        TodaysWorkout(),
        WhiteButton(
          title: 'Start Exercise',
          hPadding: 50.0,
          vPadding: 15.0,
          textSize: 20.0,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
