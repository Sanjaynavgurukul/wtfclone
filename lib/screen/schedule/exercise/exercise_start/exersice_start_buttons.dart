import 'package:flutter/material.dart';

import '../white_button.dart';

class ExerciseStartButtons extends StatelessWidget {
  const ExerciseStartButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          WhiteButton(
            title: 'Start Exersise',
            vPadding: 10.0,
            hPadding: 15.0,
            textSize: 18.0,
          ),
          Spacer(),
          WhiteButton(
            title: 'Start Exersise',
            vPadding: 10.0,
            hPadding: 15.0,
            textSize: 18.0,
          ),
        ],
      ),
    );
  }
}
