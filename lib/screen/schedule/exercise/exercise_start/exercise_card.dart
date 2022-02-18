import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: Get.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
                // color: Utils.red,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(20)),
                ),
                child: Icon(
                  Icons.headset,
                  size: 40,
                )),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff1a1a1a),
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Squats',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'Set 2 of 4',
                    style: TextStyle(color: Colors.white54),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text('8-12 Reps',
                        style: TextStyle(color: Colors.white70)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
