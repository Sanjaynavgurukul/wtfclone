import 'package:flutter/material.dart';

class BodyCalculatorTopBar extends StatelessWidget {
  const BodyCalculatorTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff151718),
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          size: 50,
          color: Colors.white54,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
