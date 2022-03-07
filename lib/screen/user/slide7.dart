import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/fluid_slider.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/processing_dialog.dart';

class Slide7 extends StatefulWidget {
  @override
  State<Slide7> createState() => _Slide7State();
}

class _Slide7State extends State<Slide7> {
  String other = 'Any Other';
  bool isSmoking = false;
  bool isDrinking = false;

  int radioCheck = -0;
  
  List<String> selectedConditions = [];
  final formKey = GlobalKey<FormState>();

  var datSource = [
    {
      "display": "Diabetes",
      "value": "Diabetes",
    },
    {
      "display": "Cholesterol",
      "value": "Cholesterol",
    },
    {
      "display": "Hypertension",
      "value": "Hypertension",
    },
    {
      "display": "PCOS",
      "value": "PCOS",
    },
    {
      "display": "Thyroid",
      "value": "Thyroid",
    },
    {
      "display": "Physical Injury",
      "value": "Physical Injury",
    },
    {
      "display": "Excessive Stress/Anxiety",
      "value": "Excessive Stress/Anxiety",
    },
    {
      "display": "Depression",
      "value": "Depression",
    },
    {
      "display": "Anger issues",
      "value": "Anger issues",
    },
    {
      "display": "Loneliness",
      "value": "Loneliness",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, user, snapshot) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Color(0xff922224),
                  child: Column(
                    children: [
                      ListTile(
                        leading: InkWell(
                          onTap: (){},
                          child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                        ),title:  Text(
                        "How fast do you want to ${user.targetWeight > user.weight ? 'gain your weight' : 'lose your weight'}?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      ),
                      SizedBox(height: 40,),
                      Center(
                        child: Text(
                          '${user.goalWeight.toStringAsFixed(2)} kg / week',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 12,right: 12,bottom: 20),
                        child: FluidSlider(
                          value: user.goalWeight,
                          thumbColor: Color(0xff922224),
                          onChanged: (double newValue) {
                            setState(() {
                              user.setValue(
                                goalWeight: newValue,
                              );
                            });
                          },
                          min: 0.0,
                          max: 1.5,
                          sliderColor: AppConstants.white,
                          showDecimalValue: true,
                          start: Container(),
                          end: Container(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:40),
                Center(
                  child: Text(
                    "Do you have any special medical condition(s)?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height:20),
                Container(
                  child: Wrap(
                    children: [
                      ...datSource
                          .map(
                            (e) => Opacity(
                          opacity: selectedConditions.contains('None')
                              ? 0.5
                              : 1.0,
                          child: InkWell(
                            onTap: () async {
                              if (!selectedConditions.contains('None')) {
                                if (selectedConditions
                                    .contains(e['value'])) {
                                  setState(() {
                                    selectedConditions.remove(e['value']);
                                  });
                                  user.existingDisease.remove(e['value']);
                                } else {
                                  setState(() {
                                    selectedConditions.add(e['value']);
                                    user.existingDisease.add(e['value']);
                                  });
                                }
                              }
                              // user.existingDisease
                              //     .addAll(selectedConditions);
                              // user.existingDisease.clear();
                            },
                            child: Container(
                              width:
                              MediaQuery.of(context).size.width * .38,
                              padding: const EdgeInsets.all(12.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                selectedConditions.contains(e['value'])
                                    ? AppConstants.primaryColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: selectedConditions
                                      .contains(e['value'])
                                      ? AppConstants.primaryColor
                                      : Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                                vertical: 6.0,
                              ),
                              child: Text(
                                e['value'],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      Opacity(
                        opacity:
                        selectedConditions.contains('None') ? 0.5 : 1.0,
                        child: InkWell(
                          onTap: () async {
                            if (!selectedConditions.contains('None')) {
                              if (selectedConditions.contains(other)) {
                                setState(() {
                                  selectedConditions.remove(other);
                                  other = 'Any Other';
                                });
                                user.existingDisease.clear();
                                user.existingDisease.addAll(selectedConditions);
                              } else {
                                String value = await showDialog<String>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => CustomTextDialog(),
                                );
                                if (value != null) {
                                  setState(() {
                                    other = value;
                                  });
                                }
                                print('other:: $other');
                                setState(() {
                                  selectedConditions.add(other);
                                  user.existingDisease.add(other);
                                });
                              }
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .38,
                            padding: const EdgeInsets.all(12.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedConditions.contains(other)
                                  ? AppConstants.primaryColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedConditions.contains(other)
                                    ? AppConstants.primaryColor
                                    : Colors.white,
                              ),
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                              vertical: 6.0,
                            ),
                            child: Text(
                              other,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(6.0),
                InkWell(
                  onTap: () async {
                    if (selectedConditions.contains('None')) {
                      setState(() {
                        selectedConditions.remove('None');
                        user.existingDisease.remove('None');
                      });
                    } else {
                      setState(() {
                        selectedConditions.clear();
                        user.existingDisease.clear();
                        selectedConditions.add('None');
                        user.existingDisease.add('None');
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .78,
                    padding: const EdgeInsets.all(12.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedConditions.contains('None')
                          ? AppConstants.primaryColor
                          : Colors.transparent,
                      border: Border.all(
                        color: selectedConditions.contains('None')
                            ? AppConstants.primaryColor
                            : Colors.white,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 6.0,
                    ),
                    child: Text(
                      'None of the above',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:20),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //SizedBox
                    Text(
                      'Do you Drink?',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ), //Text
                    Switch(
                      value: isDrinking,
                      onChanged: (val) {
                        setState(() {
                          isDrinking = !isDrinking;
                          user.setValue(isDrinking: isDrinking);
                        });
                      },
                      activeColor: AppConstants.primaryColor,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ], //<Widget>[]
                ),
                if (isDrinking) ...{
                  UIHelper.verticalSpace(6.0),
                  Text(
                    AppConstants.drinkingText,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: AppColors.TEXT_DARK,
                    ),
                  ),
                },
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //SizedBox
                    Text(
                      'Do you Smoke ?',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                    Switch(
                      value: isSmoking,
                      onChanged: (val) {
                        setState(() {
                          isSmoking = !isSmoking;
                          user.setValue(isSmoking: isSmoking);
                        });
                      },
                      activeColor: AppConstants.primaryColor,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ], //<Widget>[]
                ),
                if (isSmoking) ...{
                  UIHelper.verticalSpace(6.0),
                  Text(
                    AppConstants.smokingText,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: AppColors.TEXT_DARK,
                    ),
                  ),
                },
                SizedBox(
                  height: 60.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget newUI(
      {Function onClick, Map<String, String> data, bool selected = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onClick,
        child: Container(
          child: Text(
            data['type'] ?? 'No Type',
            style: TextStyle(color: selected ? Colors.black : Colors.white),
          ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: selected ? Colors.white : Colors.transparent,
              border: Border.all(width: 1, color: Colors.white)),
        ),
      ),
    );
  }

  Widget oldUI(UserController user){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "How fast do you want to ${user.targetWeight > user.weight ? 'gain your weight' : 'lose your weight'}?",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            AppConstants.confidentialInfo,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          // TextField(),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              '${user.goalWeight.toStringAsFixed(2)} kg / week',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          UIHelper.verticalSpace(70.0),
          FluidSlider(
            value: user.goalWeight,
            onChanged: (double newValue) {
              setState(() {
                user.setValue(
                  goalWeight: newValue,
                );
              });
            },
            min: 0.0,
            max: 1.5,
            sliderColor: AppConstants.primaryColor,
            showDecimalValue: true,
            start: Container(),
            end: Container(),
          ),
        ],
      ),
    );
  }
}
