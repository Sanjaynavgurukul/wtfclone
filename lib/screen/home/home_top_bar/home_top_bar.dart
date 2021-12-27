import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtf/screen/home/home_top_bar/profile_with_notification.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      // color: Colors.amber,
      padding: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   'Vishal Nigam',
              //   style: TextStyle(fontSize: 19, color: Colors.white70),
              // ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Welcome to wtf'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: double.maxFinite,
            width: 1,
            color: Colors.white12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Joined ',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Row(
                children: [
                  Text('6 ',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  Text('Months ago',
                      style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
