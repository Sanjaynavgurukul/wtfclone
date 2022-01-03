import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/screen/bmr_calculator/bmr_state.dart';
import 'package:wtf/widget/slide_button.dart';

import '../calories_counter/CalorieCounterTextBox.dart';

class BMRCalculator extends StatefulWidget {
  const BMRCalculator({Key key}) : super(key: key);

  @override
  _BMRCalculatorState createState() => _BMRCalculatorState();
}

class _BMRCalculatorState extends State<BMRCalculator> {
  String gender = '';
  List genders = ['Male', 'Female', 'Other'];
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  BmrState bmrState;
  FocusNode ageNode = FocusNode(),
      weightNode = FocusNode(),
      heightNode = FocusNode();
  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bmrState = Provider.of<BmrState>(context);
    return Builder(
      builder: (context) => Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(
            'BMR Calculator',
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
                bmrState.gender.isEmpty) {
              FlashHelper.informationBar(context,
                  message: 'Please provide all details');
              /* -------------------------------------------------------------------------- */
              /*                                 show error                                 */
              /* -------------------------------------------------------------------------- */
            } else {
              if (gender == genders[0] || gender == genders[2]) {
                Provider.of<BmrState>(context, listen: false).bmrForMen(
                  age: num.parse(ageController.text),
                  height: num.parse(heightController.text),
                  weight: num.parse(weightController.text),
                  context: context,
                );
              } else {
                Provider.of<BmrState>(context, listen: false).bmrForWoMen(
                  age: num.parse(ageController.text),
                  height: num.parse(heightController.text),
                  weight: num.parse(weightController.text),
                  context: context,
                );
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Basal Metabolic Rate (BMR) Calculator estimates your basal metabolic rate—the amount of energy expended while at rest in a neutrally temperate environment, and in a post-absorptive state (meaning that the digestive system is inactive .',
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
                      launch(AppConstants.bmrCalculatorReference);
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
                  _text('What\'s your age?'),
                  SizedBox(
                    height: 5,
                  ),
                  CalorieCounterTextBox(
                    controller: ageController,
                    hint: '15',
                    node: ageNode,
                    keyboardType: TextInputType.number,
                    action: TextInputAction.next,
                    node2: heightNode,
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
                    keyboardType: TextInputType.number,
                    action: TextInputAction.next,
                    node2: weightNode,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _text('Weight'),
                  SizedBox(
                    height: 5,
                  ),
                  CalorieCounterTextBox(
                    controller: weightController,
                    hint: 'kg',
                    node: weightNode,
                    keyboardType: TextInputType.number,
                    action: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _text('Gender'),
                  Row(
                    children: [
                      _text('Male'),
                      Radio(
                          value: genders[0],
                          groupValue: gender,
                          fillColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          onChanged: (str) {
                            setState(() {
                              gender = str;
                              bmrState.gender = gender;
                            });
                          }),
                      _text('Female'),
                      Radio(
                        value: genders[1],
                        groupValue: gender,
                        fillColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        onChanged: (str) {
                          setState(() {
                            gender = str;
                            bmrState.gender = gender;
                          });
                        },
                      ),
                      _text('Other'),
                      Radio(
                        value: genders[2],
                        groupValue: gender,
                        fillColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        onChanged: (str) {
                          setState(() {
                            gender = str;
                            bmrState.gender = gender;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _text(text) => Text(
        text,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
        textAlign: TextAlign.left,
      );
}
