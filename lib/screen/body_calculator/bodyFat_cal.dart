import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/screen/body_calculator/bodyFat_state.dart';
import 'package:wtf/widget/slide_button.dart';

import '../calories_counter/CalorieCounterTextBox.dart';

class BodyFatCalculator extends StatefulWidget {
  const BodyFatCalculator({Key key}) : super(key: key);

  @override
  _BodyFatCalculatorState createState() => _BodyFatCalculatorState();
}

class _BodyFatCalculatorState extends State<BodyFatCalculator> {
  String gender = '';
  List genders = ['Male', 'Female', 'Other'];
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  FocusNode ageNode = FocusNode(),
      weightNode = FocusNode(),
      neckNode = FocusNode(),
      waistNode = FocusNode(),
      hipNode = FocusNode(),
      heightNode = FocusNode();
  BodyState bodyState;
  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    neckController.dispose();
    waistController.dispose();
    hipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bodyState = Provider.of<BodyState>(context);
    return Builder(
      builder: (context) => Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(
            'Body Fat Calculator',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24.0,
          ),
          height: 80.0,
          child: SlideButton(
            'Calculate',
            () {
              if (ageController.text.isEmpty ||
                  weightController.text.isEmpty ||
                  heightController.text.isEmpty ||
                  bodyState.gender.isEmpty) {
                FlashHelper.informationBar(context,
                    message: 'Please provide all details');
                /* -------------------------------------------------------------------------- */
                /*                                 show error                                 */
                /* -------------------------------------------------------------------------- */
              } else {
                if (gender == genders[0] || gender == genders[2]) {
                  Provider.of<BodyState>(context, listen: false).bmi(
                    height: num.parse(heightController.text),
                    weight: num.parse(weightController.text),
                    context: context,
                  );
                  Provider.of<BodyState>(context, listen: false).bodyFatMen(
                    age: num.parse(ageController.text),
                    height: num.parse(heightController.text),
                    weight: num.parse(weightController.text),
                    context: context,
                    neck: num.parse(neckController.text),
                    waist: num.parse(waistController.text),
                  );
                } else {
                  Provider.of<BodyState>(context, listen: false).bmi(
                      height: num.parse(heightController.text),
                      weight: num.parse(weightController.text));
                  Provider.of<BodyState>(context, listen: false).bodyFatWoMen(
                    age: num.parse(ageController.text),
                    height: num.parse(heightController.text),
                    weight: num.parse(weightController.text),
                    neck: num.parse(neckController.text),
                    waist: num.parse(waistController.text),
                    hip: num.parse(hipController.text),
                    context: context,
                  );
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
                      launch(AppConstants.bodyFatCalculatorReference);
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
                    action: TextInputAction.next,
                    node2: neckNode,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _text('Neck'),
                  SizedBox(
                    height: 5,
                  ),
                  CalorieCounterTextBox(
                    controller: neckController,
                    hint: '10cm',
                    node: neckNode,
                    keyboardType: TextInputType.number,
                    action: TextInputAction.next,
                    node2: waistNode,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _text('Waist'),
                  SizedBox(
                    height: 5,
                  ),
                  CalorieCounterTextBox(
                    controller: waistController,
                    hint: '10cm',
                    node: waistNode,
                    keyboardType: TextInputType.number,
                    action: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (gender == 'Female') ...{
                    _text('Hip'),
                    SizedBox(
                      height: 5,
                    ),
                    CalorieCounterTextBox(
                      controller: hipController,
                      hint: '10cm',
                      node: hipNode,
                      keyboardType: TextInputType.number,
                      action: TextInputAction.done,
                    ),
                  },
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
                            bodyState.gender = gender;
                          });
                        },
                      ),
                      _text('Female'),
                      Radio(
                        value: genders[1],
                        groupValue: gender,
                        fillColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        onChanged: (str) {
                          setState(() {
                            gender = str;
                            bodyState.gender = gender;
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
                            bodyState.gender = gender;
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
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.left,
      );
}
