import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/widget/slide_button.dart';

import 'CalorieCounterTextBox.dart';
import 'calorie_state.dart';

class CaloriesCounter extends StatefulWidget {
  const CaloriesCounter({Key key}) : super(key: key);

  @override
  _CaloriesCounterState createState() => _CaloriesCounterState();
}

class _CaloriesCounterState extends State<CaloriesCounter> {
  String gender = '';
  List genders = ['Male', 'Female'];
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  FocusNode ageNode = FocusNode(),
      weightNode = FocusNode(),
      heightNode = FocusNode();
  Map<String, double> activity = {
    'Sedentary: little or no exercise': 1.2,
    'Exercise 3-4 times/week': 0.2,
    'Daily exercise or intense exercise 6-7 times/week': 0.6,
    'Very intense exercise daily, or physical job': 1.1
  };
  CalorieState calorieState;
  double selectedVal;
  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    calorieState = context.watch<CalorieState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Calories Counter',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        height: 80.0,
        child: SlideButton(
          'Calculate',
          () {
            if (ageController.text.isEmpty ||
                weightController.text.isEmpty ||
                heightController.text.isEmpty ||
                calorieState.gender.isEmpty ||
                selectedVal == null) {
              FlashHelper.informationBar(context,
                  message: 'Please provide all details');
              /* -------------------------------------------------------------------------- */
              /*                                 show error                                 */
              /* -------------------------------------------------------------------------- */
            } else {
              if (calorieState.gender == genders[0]) {
                Provider.of<CalorieState>(context, listen: false).bmrForMen(
                    age: num.parse(ageController.text),
                    height: num.parse(heightController.text),
                    weight: num.parse(weightController.text),
                    val: selectedVal,
                    context: context);
              } else {
                Provider.of<CalorieState>(context, listen: false).bmrForWoMen(
                    age: num.parse(ageController.text),
                    height: num.parse(heightController.text),
                    weight: num.parse(weightController.text),
                    val: selectedVal,
                    context: context);
              }
            }
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use our exercise calorie calculator to see how much activity you need to do to burn off those calories! Or find out how many calories you could burn by doing your favourite activities.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    launch(AppConstants.calorieCalculatorReference);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Reference: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        AppConstants.calculatorReferenceText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _text('How much do you weigh?'),
                SizedBox(
                  height: 5,
                ),
                CalorieCounterTextBox(
                  controller: weightController,
                  hint: 'Kilograms',
                  node: weightNode,
                  node2: ageNode,
                  action: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),

                SizedBox(
                  height: 30,
                ),
                _text('What\'s your age?'),
                SizedBox(
                  height: 5,
                ),
                CalorieCounterTextBox(
                  controller: ageController,
                  hint: '15',
                  node: ageNode,
                  node2: heightNode,
                  action: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 30,
                ),
                _text('Height'),
                SizedBox(
                  height: 5,
                ),
                CalorieCounterTextBox(
                  controller: heightController,
                  hint: '10cm',
                  node: heightNode,
                  action: TextInputAction.done,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 30,
                ),
                _text('Gender'),
                Row(
                  children: [
                    _text('Male'),
                    Radio(
                      value: genders[0],
                      groupValue: gender,
                      fillColor: MaterialStateProperty.all<Color>(Colors.white),
                      onChanged: (str) {
                        setState(() {
                          gender = str;
                          calorieState.gender = gender;
                        });
                      },
                    ),
                    _text('Female'),
                    Radio(
                      value: genders[1],
                      groupValue: gender,
                      fillColor: MaterialStateProperty.all<Color>(Colors.white),
                      onChanged: (str) {
                        setState(() {
                          gender = str;
                          calorieState.gender = gender;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                _text(
                  'How much calories would you like to burn off?',
                ), // drop down
                SizedBox(
                  height: 10.0,
                ),
                DropdownButton<double>(
                  hint: new Text(
                    "Select an activity level",
                    style: AppConstants.customStyle(
                      color: Colors.white,
                      size: 14.0,
                    ),
                  ),
                  style: AppConstants.customStyle(
                    color: Colors.white,
                    size: 14.0,
                  ),
                  value: selectedVal,
                  isExpanded: true,
                  items: activity
                      .map(
                        (description, value) {
                          return MapEntry(
                            description,
                            DropdownMenuItem<double>(
                              value: value,
                              child: Text(
                                description,
                                style: AppConstants.customStyle(
                                  color: Colors.white,
                                  size: 14.0,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      .values
                      .toList(),
                  onChanged: (double val) {
                    setState(() {
                      selectedVal = val;
                      activity.forEach(
                        (key, value) {
                          if (val == value) {
                            calorieState.selectedExerciseType = key;
                          }
                        },
                      );
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _text(text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
      );
}
