import 'package:flutter/material.dart';

class ScheduleItemInfo extends StatelessWidget {
  const ScheduleItemInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Kunal Dudeja', style: TextStyle(fontSize: 18),),
        SizedBox(height: 5,),
        Text('Beginner', style: TextStyle(fontSize: 16, color: Colors.white70),),
        SizedBox(height: 5,),
        Row(
          children: [
            Icon(Icons.person, size: 12, color: Colors.white54,),
            SizedBox(width: 5,),
            Text('Male', style: TextStyle(fontSize: 12, color: Colors.white54),),
            SizedBox(width: 5,),
            Text('( 28yrs )', style: TextStyle(fontSize: 12, color: Colors.white54),),
          ],
        )
      ],
    );
  }
}
