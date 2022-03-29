import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/widget/slide_button.dart';

import 'bmr_state.dart';

class BMRCalculatorResult extends StatelessWidget {
  const BMRCalculatorResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'BMR Calculator',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SlideButton(
        text:'Continue',
        onTap:() async {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Image.asset(
            'assets/images/achieve.png',
            height: MediaQuery.of(context).size.height * .2,
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 2,
            color: Colors.white12,
            indent: 20,
            endIndent: 20,
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Your BMR Calculator results',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Consumer<BmrState>(
              builder: (context, data, _) {
                var result = data.bmrResult ?? '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$result Kcal/day',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: Fonts.ROBOTO,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // _text('Sedentary: little or no exercise'),
                    // _subText(
                    //   (double.parse(result) * 1.2).toString() + "Calories/day",
                    // ),
                    // _text('Exercise 1-3 times/week'),
                    // _subText(
                    //   (double.parse(result) * 1.4).toString() + "Calories/day",
                    // ),
                    // _text('Daily exercise or intense exercise 3-4 times/week'),
                    // _subText(
                    //   (double.parse(result) * 1.6).toString() + "Calories/day",
                    // ),
                    // _text('Very intense exercise daily, or physical job'),
                    // _subText(
                    //   (double.parse(result) * 2).toString() + "Calories/day",
                    // ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _text(text) => Padding(
        padding: EdgeInsets.only(left: 30, bottom: 5),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      );

  _subText(text) => Padding(
        padding: EdgeInsets.only(left: 30, bottom: 20),
        child: Text(
          text,
          style: TextStyle(color: Colors.red),
        ),
      );
}
