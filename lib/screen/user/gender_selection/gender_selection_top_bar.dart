import 'package:flutter/material.dart';

class GenderSelectionTopBar extends StatelessWidget {
  const GenderSelectionTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Select Your Gender',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        iconSize: 30,
        onPressed: () {},
      ),
    );
  }
}