import 'package:flutter/material.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';

class ExerciseStartInfo extends StatelessWidget {
  final Exercise data;
  const ExerciseStartInfo({Key key,@required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getText('Workout'),
                SizedBox(
                  height: 10,
                ),
                _getSubtext(
                    data.woName ?? 'N/A'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getText('Reps'),
                SizedBox(
                  height: 10,
                ),
                _getSubtext(
                    data.reps ?? 'N/A'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getText('Sets'),
                SizedBox(
                  height: 10,
                ),
                _getSubtext(
                    data.sets ?? 'N/A'),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getText(text) => Flexible(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      );

  _getSubtext(text) => Flexible(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
}
