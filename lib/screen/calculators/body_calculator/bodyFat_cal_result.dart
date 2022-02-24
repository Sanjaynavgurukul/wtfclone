import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/calculators/body_calculator/bodyFat_state.dart';
import 'package:wtf/widget/slide_button.dart';

class BodyFatCalResult extends StatelessWidget {
  const BodyFatCalResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BodyState bodyState = context.watch<BodyState>();
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Body Fat Calculator',
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
          // await bodyState.saveProgress(context: context);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
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
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              'Your Body Fat Calculator Result',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Consumer<BodyState>(
              builder: (context, data, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Body Fat = ${data.bodyFat.toStringAsFixed(2)} %',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: Fonts.ROBOTO,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      UIHelper.verticalSpace(12.0),
                      Text(
                        'BMI = ${bodyState.bmiResult.toStringAsFixed(2)} Kg/m²',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: Fonts.ROBOTO,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      UIHelper.verticalSpace(12.0),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Table(
                          border: TableBorder.all(color: Colors.white),
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Type',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Value',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(
                                color: AppConstants.primaryColor,
                                border: Border.all(
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Minimal',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    '2% - 6%',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(
                                color: bodyState.bodyFat.truncateToDouble() >
                                            0 &&
                                        bodyState.bodyFat.truncateToDouble() <=
                                            6
                                    ? Colors.grey
                                    : Colors.transparent,
                                border: Border.all(
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Athlete',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    '6% - 14%',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(
                                color: bodyState.bodyFat.truncateToDouble() >
                                            6 &&
                                        bodyState.bodyFat.truncateToDouble() <=
                                            14
                                    ? Colors.blue
                                    : Colors.transparent,
                                border: Border.all(
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Fit',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    '14% - 18%',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(
                                color: bodyState.bodyFat.truncateToDouble() >
                                            14 &&
                                        bodyState.bodyFat.truncateToDouble() <=
                                            18
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Average',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    '18% - 25%',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(
                                color: bodyState.bodyFat.truncateToDouble() >
                                            18 &&
                                        bodyState.bodyFat.truncateToDouble() <=
                                            25
                                    ? Colors.deepOrange
                                    : Colors.transparent,
                                border: Border.all(
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Obese',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    '26% and above',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(
                                color: bodyState.bodyFat.truncateToDouble() > 26
                                    ? AppConstants.primaryColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(20.0),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
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
      ));

  _subText(text) => Padding(
      padding: EdgeInsets.only(left: 30, bottom: 20),
      child: Text(
        text,
        style: TextStyle(color: Colors.red),
      ));
}
