import 'package:flutter/material.dart';

class RedBar extends StatelessWidget {
  const RedBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'My Statistics',
        style: TextStyle(fontSize: 22),
      ),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
    );
  }
}
