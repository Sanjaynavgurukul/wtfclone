import 'package:flutter/material.dart';

import 'discover_item.dart';

class Discover extends StatelessWidget {
  const Discover({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Discover',
            style: TextStyle(fontSize: 22),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Explore Gyms & Fitness near you',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 10.0),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => DiscoverItem(),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
