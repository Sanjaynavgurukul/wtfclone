import 'package:flutter/material.dart';
import 'package:wtf/helper/routes.dart';
// import 'package:wtf/utils/utils.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff333333),
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Schedule :',
                  style: TextStyle(color: Colors.red, fontSize: 22),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Gym Workout',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        Text(
                          ' Tue, 10 Jul 7:00 PM',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        )
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Get Directions',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'WTF the gold gym',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.white70,
                    ),
                    Text('Sec-12, Dwarka (New Delhi)',
                        style: TextStyle(
                          color: Colors.white70,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            color: Colors.black,
            child: Text(
              'Tap on UNLOCK SESSION button within gym premises to activate your session',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.qrScanner);
                },
                child: Text(
                  'Unlock\nSession',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              //ElevatedButton(
              //  onPressed: () {},
              //  child: Text(
              //    'Unlock\nSession',
              //    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              //  ),
              //  style: ElevatedButton.styleFrom(
              //      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              //      // primary: Utils.red,
              //      shape: RoundedRectangleBorder(
              //          borderRadius: BorderRadius.circular(20))),
              //),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
