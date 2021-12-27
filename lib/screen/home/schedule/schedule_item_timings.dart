import 'package:flutter/material.dart';

class ScheduleItemTimings extends StatelessWidget {
  const ScheduleItemTimings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Timings', style: TextStyle(fontSize: 12),),
        SizedBox(height: 10,),
        Text('09AM - 10AM', style: TextStyle(fontSize: 12),),
      ],
    );
  }
}
