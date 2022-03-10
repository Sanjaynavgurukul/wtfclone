import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';

class Slide3 extends StatefulWidget {
  @override
  State<Slide3> createState() => _Slide3State();
}

class _Slide3State extends State<Slide3> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, user, snapshot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("What is your Age ?",
              style: TextStyle(fontSize: 22.0, color: Colors.white)),
          SizedBox(height: 10),

          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              AppConstants.confidentialInfo,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
              maxLines: 5,
              softWrap: true,
              //textAlign: TextAlign.center,
            ),
          ),
          UIHelper.verticalSpace(50.0),
          // TextField(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Age',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                color: AppConstants.primaryColor,
                height: 1,
                width: 100,
              ),
              SizedBox(height: 10.0),
              Container(
                child: Center(
                  child: Age(),
                ),
              ),
            ],
          )
          // Age(),
        ],
      );
    });
  }
}

class Age extends StatefulWidget {
  Age({Key key}) : super(key: key);

  @override
  _AgeState createState() => _AgeState();
}

class _AgeState extends State<Age> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, user, snapshot) {
      return Container();
      // return SingleChildScrollView(
      //   child: Column(
      //     children: <Widget>[
      //       SizedBox(height: 6),
      //       NumberPicker(
      //         textStyle: TextStyle(
      //           fontSize: 25,
      //           color: Colors.white,
      //         ),
      //         selectedTextStyle: TextStyle(
      //           fontSize: 45,
      //           color: AppConstants.white,
      //           fontWeight: FontWeight.bold,
      //         ),
      //         decoration: BoxDecoration(
      //           color: AppConstants.primaryColor.withOpacity(0.6),
      //         ),
      //         itemHeight: 60,
      //         value: user.age,
      //         minValue: 1,
      //         maxValue: 100,
      //         step: 1,
      //         haptics: true,
      //         onChanged: (value) {
      //           setState(() {
      //             user.setValue(age: value);
      //           });
      //         },
      //       ),
      //       SizedBox(height: 5),
      //     ],
      //   ),
      // );
    });
  }
}