import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseResult extends StatelessWidget {
  ExerciseResult({Key key, this.h = '00', this.m = '00', this.s = '00'}) : super(key: key);
  String h, m, s;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Column(
          //   children: [
          //     _getText('Hours'),
          //     SizedBox(
          //       height: 10,
          //     ),
          //     _getSubtext(h.toString(), 'h'),
          //   ],
          // ),
          Column(
            children: [
              _getText('Hour'),
              SizedBox(
                height: 10,
              ),
              _getSubtext(h.toString(), 'h'),
            ],
          ),
          Column(
            children: [
              _getText('Minutes'),
              SizedBox(
                height: 10,
              ),
              _getSubtext(m.toString(), 'm'),
            ],
          ),
          Column(
            children: [
              _getText(
                'Seconds',
              ),
              SizedBox(
                height: 10,
              ),
              _getSubtext(s.toString(), 's'),
            ],
          )
        ],
      ),
    );
  }

  _getText(text) => Container(
        width: Get.width * 0.2,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      );

  _getSubtext(text, subtext) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          Text(
            subtext,
            style: TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      );
}
