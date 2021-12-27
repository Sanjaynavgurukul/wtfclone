import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtf/helper/app_constants.dart';

class StatisticsItem extends StatelessWidget {
  const StatisticsItem({Key key, this.showGradient, this.text, this.subText})
      : super(key: key);
  final showGradient, text, subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: Get.width * 0.22,
      decoration: BoxDecoration(
          color: showGradient ? null : Color(0xff131313),
          borderRadius: BorderRadius.circular(10),
          gradient: showGradient
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff131313),
                    Color(0xff131313),
                    Color(0xff710b0b),
                    Color(0xff710b0b),
                    // Colors.red.withOpacity(0.2)
                  ],
                )
              : null),
      child: Column(
        children: [
          Spacer(),
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppConstants.customStyle(
              color: Colors.white,
              size: 12.0,
            ),
          ),
          Spacer(
            flex: 3,
          ),
          Text(
            subText,
            style: AppConstants.customStyle(
              color: Colors.white,
              size: 14.0,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
