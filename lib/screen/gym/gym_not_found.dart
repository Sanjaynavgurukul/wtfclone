import 'package:flutter/material.dart';

class GymNotFound extends StatelessWidget {
  static const routeName = '/gymNotFound';
  const GymNotFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Gym Not Found'),),
    );
  }
}
