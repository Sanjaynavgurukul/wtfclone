import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/widget/slide_button.dart';

import 'CalorieCounterTextBox.dart';
import 'calorie_state.dart';

enum HeightUnit { ft, cm }

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
  FocusNode ageNode = FocusNode(),
      weightNode = FocusNode(),
      heightNode = FocusNode();
  Map<String, double> activity = {
    'Sedentary: little or no exercise': 1.2,
    'Light exercise or sports 1-2 days/week': 1.4,
    'Moderate exercise or sports 2-3 days/week': 1.6,
    'Hard exercise or sports 4-5 days/week': 1.75,
    'very hard exercise, physical job or sports 6-7 days/week': 2.0,
    'Professional athlete': 2.3,
  };
  CalorieState calorieState;
  double selectedVal;

  HeightUnit selectedUnit = HeightUnit.ft;
  TextEditingController heightController = TextEditingController();
  int ft = 0;
  int inches = 0;
  String cm;

  cmToInches(inchess) {
    ft = inchess ~/ 12;
    inches = inchess % 12;
    print('$ft feet and $inches inches');
  }

  inchesToCm() {
    int inchesTotal = (ft * 12) + inches;
    cm = (inchesTotal * 2.54).toStringAsFixed(2);
    heightController.text = cm;
  }

  void checkHeightUnit() {
    if (selectedUnit == HeightUnit.ft) {
      setState(() {
        int inchess = (double.parse(heightController.text) ~/ 2.54).toInt();
        cmToInches(inchess);
        heightController.text = '$ft\' $inches"';
      });
    } else if (selectedUnit == HeightUnit.cm) {
      setState(() {
        print(heightController.text);
        inchesToCm();
      });
    }
  }

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
      bottomNavigationBar: SlideButton(
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
            setState(() {
              selectedUnit = HeightUnit.cm;
              inchesToCm();
            });
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
                // CalorieCounterTextBox(
                //   controller: heightController,
                //   hint: '10cm',
                //   node: heightNode,
                //   action: TextInputAction.done,
                //   keyboardType: TextInputType.number,
                // ),
                Row(
                  children: [
                    Container(
                      width: 168,
                      child: TextFormField(
                        onTap: selectedUnit == HeightUnit.ft
                            ? () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 200,
                                        color: Colors.grey,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: CupertinoPicker(
                                                itemExtent: 32.0,
                                                onSelectedItemChanged:
                                                    (int index) {
                                                  print(index + 1);
                                                  setState(() {
                                                    ft = (index + 1);
                                                    heightController.text =
                                                        "$ft' $inches\"";
                                                  });
                                                },
                                                children:
                                                    List.generate(12, (index) {
                                                  return Center(
                                                    child: Text('${index + 1}'),
                                                  );
                                                }),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Text('ft',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        )))),
                                            Expanded(
                                              child: CupertinoPicker(
                                                itemExtent: 32.0,
                                                onSelectedItemChanged:
                                                    (int index) {
                                                  print(index);
                                                  setState(() {
                                                    inches = (index);
                                                    heightController.text =
                                                        "$ft' $inches\"";
                                                  });
                                                },
                                                children:
                                                    List.generate(12, (index) {
                                                  return Center(
                                                    child: Text('$index'),
                                                  );
                                                }),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                  child: Text('inches',
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ))),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }
                            : null,
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            hintText: selectedUnit == HeightUnit.ft
                                ? "__' __\""
                                : '__',
                            hintStyle: TextStyle(color: Colors.white),
                            // enabledBorder: UnderlineInputBorder(
                            //     borderSide: BorderSide(
                            //         color: AppConstants.primaryColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppConstants.primaryColor))),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                        ],
                      ),
                    ),
                    SizedBox(width: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (heightController.text.isEmpty) {
                              selectedUnit = HeightUnit.ft;
                            } else {
                              selectedUnit = HeightUnit.ft;
                              checkHeightUnit();
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: selectedUnit == HeightUnit.ft
                                  ? AppConstants.primaryColor
                                  : Colors.transparent,
                            ),
                            color: selectedUnit == HeightUnit.ft
                                ? AppConstants.primaryColor
                                : Colors.transparent,
                          ),
                          width: 31,
                          height: 31,
                          child: Center(
                              child:
                                  Text('ft', style: TextStyle(fontSize: 16))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (heightController.text.isEmpty) {
                              selectedUnit = HeightUnit.cm;
                            } else {
                              selectedUnit = HeightUnit.cm;
                              checkHeightUnit();
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: selectedUnit == HeightUnit.cm
                                  ? AppConstants.primaryColor
                                  : Colors.transparent,
                            ),
                            color: selectedUnit == HeightUnit.cm
                                ? AppConstants.primaryColor
                                : Colors.transparent,
                          ),
                          width: 31,
                          height: 31,
                          child: Center(
                              child:
                                  Text('cm', style: TextStyle(fontSize: 16))),
                        ),
                      ),
                    ),
                  ],
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
