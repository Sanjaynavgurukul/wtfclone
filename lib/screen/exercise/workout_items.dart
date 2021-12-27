import 'package:flutter/material.dart';

class WorkoutItems extends StatelessWidget {
  const WorkoutItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Walking knee hugs',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: Text(
                  'Start now',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '20 reps',
              style: TextStyle(fontSize: 12, color: Colors.white24),
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              '20 reps',
              style: TextStyle(color: Colors.white24),
            ),
            SizedBox(
              width: 50,
            ),
            InkWell(
              child: Icon(Icons.play_arrow, size: 35),
              onTap: () {},
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
