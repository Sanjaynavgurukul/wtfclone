import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

class StatisticsBar extends StatelessWidget {
  const StatisticsBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'My Statistics',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
    );
  }
}
