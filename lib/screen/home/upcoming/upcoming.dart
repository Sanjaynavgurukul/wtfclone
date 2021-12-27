import 'package:flutter/material.dart';
import 'package:wtf/screen/home/upcoming/upcoming_item.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Upcoming Events',
            style: TextStyle(fontSize: 22),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          height: 170,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 10.0),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => UpcomingItem(),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
