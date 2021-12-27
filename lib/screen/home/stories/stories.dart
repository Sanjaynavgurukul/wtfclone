import 'package:flutter/material.dart';
import 'package:wtf/screen/home/stories/stories_item.dart';

class Stories extends StatelessWidget {
  const Stories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Center(
        child: ListView.builder(
          primary: false,
          itemBuilder: (context, index) => StoriesItem(
            name: '',
            image:
                'https://th.bing.com/th/id/OIP.PpYXlfJuX93_WNnm12m8SgHaJ4?w=145&h=193&c=7&r=0&o=5&dpr=1.25&pid=1.7',
            showBorder: index == 0,
          ),
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
