import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/screen/statistics/statistics_date.dart';
import 'package:wtf/screen/statistics/statistics_statistics.dart';

import 'chart.dart';
import 'more_categories.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'My Statistics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 25,
          ),
          StatisticsDate(),
          StatisticsStatistics(),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Chart(),
          SizedBox(
            height: 40,
          ),
          MoreCategories(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
