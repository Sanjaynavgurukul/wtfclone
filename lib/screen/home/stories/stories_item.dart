import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoriesItem extends StatelessWidget {
  const StoriesItem({
    Key key,
    this.image,
    this.name,
    this.showBorder = false,
  }) : super(key: key);
  final String image, name;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: showBorder ? Colors.red : Colors.transparent,
                ),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                foregroundImage: AssetImage('assets/images/workout.png'),
                radius: 38.0,
              ),
            ),
            if (name.isNotEmpty)
              Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
