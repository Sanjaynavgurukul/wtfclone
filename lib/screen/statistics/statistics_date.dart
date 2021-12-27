import 'package:flutter/material.dart';
import 'package:wtf/helper/Helper.dart';

class StatisticsDate extends StatelessWidget {
  const StatisticsDate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'STATISTICS',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.date_range,
                color: Colors.white54,
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                Helper.stringForDatetime2(DateTime.now().toIso8601String()),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
