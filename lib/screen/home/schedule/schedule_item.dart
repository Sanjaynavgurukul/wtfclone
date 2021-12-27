import 'package:flutter/material.dart';
import 'package:wtf/screen/home/schedule/schedule_item_info.dart';
import 'package:wtf/screen/home/schedule/schedule_item_timings.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(
                'https://th.bing.com/th/id/OIP.PpYXlfJuX93_WNnm12m8SgHaJ4?w=145&h=193&c=7&r=0&o=5&dpr=1.25&pid=1.7'),
            radius: 40,
          ),
          Spacer(),
          ScheduleItemInfo(),
          Spacer(flex: 2,),
          VerticalDivider(color: Colors.white12, thickness: 1.5,),
          ScheduleItemTimings(),
          Spacer(flex: 2,),
        ],
      ),
    );
  }
}
