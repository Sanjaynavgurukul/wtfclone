import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtf/screen/exercise/workout_items.dart';

class TodaysWorkout extends StatelessWidget {
  const TodaysWorkout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Today\'s Workouts :',
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.white70,
                  )),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: Get.height * 0.4,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) => WorkoutItems()),
          ),
        ],
      ),
    );
  }
}
