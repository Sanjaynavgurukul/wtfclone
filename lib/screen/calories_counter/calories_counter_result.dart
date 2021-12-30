import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/calories_counter/calorie_state.dart';
import 'package:wtf/widget/slide_button.dart';

class CaloriesCounterResult extends StatefulWidget {
  const CaloriesCounterResult({Key key}) : super(key: key);

  @override
  _CaloriesCounterResultState createState() => _CaloriesCounterResultState();
}

class _CaloriesCounterResultState extends State<CaloriesCounterResult> {
  Map<String, double> dataMap = {"Carbs": 60, "Fats": 28, "Protein": 12};
  CalorieState calorieState;
  @override
  Widget build(BuildContext context) {
    calorieState = context.watch<CalorieState>();
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Calories Counter',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        height: 80.0,
        child: SlideButton(
          'Continue',
          () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 12.0,
          ),
          UIHelper.horizontalSpace(8.0),
          Image.asset(
            'assets/images/achieve.png',
            height: MediaQuery.of(context).size.height * .2,
          ),
          Divider(
            thickness: 2,
            color: Colors.white12,
            indent: 20,
            endIndent: 20,
            height: 20,
          ),
          Center(
            child: Text(
              'Your Calorie Calculator results',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Center(
            child: Consumer<CalorieState>(
              builder: (context, data, _) {
                var result = data.clrResult ?? '';
                return Column(
                  children: [
                    Text(
                      '$result Calories/day',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: Fonts.ROBOTO,
                          fontWeight: FontWeight.normal),
                    ),
                    // _text('Carbs'),
                    // _subText('${double.parse(result).round() * .60}', 'kcal'),
                    // _text('Fats'),
                    // _subText('${double.parse(result).round() * .275}', 'kcal'),
                    // _text('Protiens'),
                    // _subText('${double.parse(result).round() * .125}', 'kcal'),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // PieChart(
                    //   dataMap: dataMap,
                    //   centerTextStyle: AppConstants.customStyle(
                    //     color: Colors.white,
                    //     size: 14.0,
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),

          // _text('Maintain weight'),
          // _subText('2.78 Calories/day', '100'),
          // _text('Mild weight loss  (0.5 lb/week)'),
          // _subText('2.78 Calories/day', '100'),
          // _text('Weight loss (1 lb/week)'),
          // _subText('2.78 Calories/day', '100'),
          // _text('Extreme weight loss (2 lb/week)'),
          // _subText('2.78 Calories/day', '100'),
        ],
      ),
    );
  }

  _text(text) => Padding(
        padding: EdgeInsets.only(left: 30, bottom: 5),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  _subText(text, perc) => Padding(
        padding: EdgeInsets.only(left: 30, bottom: 20),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '($perc%)',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
}
