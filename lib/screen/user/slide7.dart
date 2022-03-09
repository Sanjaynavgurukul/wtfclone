import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
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
  static String other = 'Other';

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
    {
      "display": "Other",
      "value": 'other',
    },
    {
      "display": "None of above",
      "value": 'none',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, user, snapshot) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40, left: 18, right: 18),
                  color: Color(0xff922224),
                  child: Column(
                    children: [
                      Text(
                        "How fast do you want to ${user.preambleModel.gainingWeight ? 'gain your weight' : 'lose your weight'}?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Text(
                          '${user.preambleModel.goalWeight.toStringAsFixed(2)} kg / week',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 12, right: 12, bottom: 20),
                        child: FluidSlider(
                          value: user.preambleModel.goalWeight,
                          thumbColor: Color(0xff922224),
                          onChanged: (double newValue) {
                            setState(() {
                              user.preambleModel.goalWeight = newValue;
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

                SizedBox(height: 40),
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
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 0.0,
                      spacing: 12.0,
                      children: datSource.map((data) {
                        String value = data['value'];
                        String name = data['display'];
                        bool selected =
                            user.preambleModel.existingDisease.contains(value) ??
                                false;
                        bool isOther =
                            user.preambleModel.existingDisease.contains('other');
                        bool none =
                            user.preambleModel.existingDisease.contains('none');
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () async {
                              if (value == 'other') {
                                await showDialog<String>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => CustomTextDialog(),
                                ).then((v) {
                                  if(v != null){
                                    user.preambleModel.existingDisease = [];
                                    user.preambleModel.otherDietPreference = v;
                                    user.preambleModel.existingDisease.add(value);
                                    setState(() {});
                                  }
                                });
                              } else if (value == 'none') {
                                user.preambleModel.existingDisease = [];
                                user.preambleModel.existingDisease.add(value);
                                setState(() {});
                              } else {
                                if (isOther) {
                                  user.preambleModel.existingDisease = [];
                                  user.preambleModel.existingDisease.add(value);
                                  setState(() {});
                                } else if (none) {
                                  user.preambleModel.existingDisease = [];
                                  user.preambleModel.existingDisease.add(value);
                                  setState(() {});
                                } else {
                                  if (selected) {
                                    user.preambleModel.existingDisease
                                        .remove(value);
                                    setState(() {});
                                  } else {
                                    user.preambleModel.existingDisease
                                        .add(value);
                                    setState(() {});
                                  }
                                }
                              }
                            },
                            child: Container(
                              child: Text(
                                name ?? 'No Type',
                                style: TextStyle(
                                    color:
                                        selected ? Colors.black : Colors.white),
                              ),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: selected
                                      ? Colors.white
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                            ),
                          ),
                        );
                      }).toList()),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 18,right: 18),
                //   child: Wrap(
                //     children: [
                //       ...datSource
                //           .map(
                //             (e) => Opacity(
                //           opacity: selectedConditions.contains('None')
                //               ? 0.5
                //               : 1.0,
                //           child: InkWell(
                //             onTap: () async {
                //               if (!selectedConditions.contains('None')) {
                //                 if (selectedConditions
                //                     .contains(e['value'])) {
                //                   setState(() {
                //                     selectedConditions.remove(e['value']);
                //                   });
                //                   user.preambleModel.existingDisease.remove(e['value']);
                //                 } else {
                //                   setState(() {
                //                     selectedConditions.add(e['value']);
                //                     user.preambleModel.existingDisease.add(e['value']);
                //                   });
                //                 }
                //               }
                //               // user.existingDisease
                //               //     .addAll(selectedConditions);
                //               // user.existingDisease.clear();
                //             },
                //             child: Container(
                //               width:
                //               MediaQuery.of(context).size.width * .38,
                //               padding: const EdgeInsets.all(12.0),
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                 color:
                //                 selectedConditions.contains(e['value'])
                //                     ? AppConstants.primaryColor
                //                     : Colors.transparent,
                //                 border: Border.all(
                //                   color: selectedConditions
                //                       .contains(e['value'])
                //                       ? AppConstants.primaryColor
                //                       : Colors.white,
                //                 ),
                //               ),
                //               margin: const EdgeInsets.symmetric(
                //                 horizontal: 4.0,
                //                 vertical: 6.0,
                //               ),
                //               child: Text(
                //                 e['value'],
                //                 textAlign: TextAlign.center,
                //                 maxLines: 2,
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white,
                //                   fontSize: 12,
                //                   letterSpacing: 0.5,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       )
                //           .toList(),
                //       Opacity(
                //         opacity:
                //         selectedConditions.contains('None') ? 0.5 : 1.0,
                //         child: InkWell(
                //           onTap: () async {
                //             if (!selectedConditions.contains('None')) {
                //               if (selectedConditions.contains(other)) {
                //                 setState(() {
                //                   selectedConditions.remove(other);
                //                   other = 'Any Other';
                //                 });
                //                 user.preambleModel.existingDisease.clear();
                //                 user.preambleModel.existingDisease.addAll(selectedConditions);
                //               } else {
                //                 String value = await showDialog<String>(
                //                   context: context,
                //                   barrierDismissible: true,
                //                   builder: (context) => CustomTextDialog(),
                //                 );
                //                 if (value != null) {
                //                   setState(() {
                //                     other = value;
                //                   });
                //                 }
                //                 print('other:: $other');
                //                 setState(() {
                //                   selectedConditions.add(other);
                //                   user.preambleModel.existingDisease.add(other);
                //                 });
                //               }
                //             }
                //           },
                //           child: Container(
                //             width: MediaQuery.of(context).size.width * .38,
                //             padding: const EdgeInsets.all(12.0),
                //             alignment: Alignment.center,
                //             decoration: BoxDecoration(
                //               color: selectedConditions.contains(other)
                //                   ? AppConstants.primaryColor
                //                   : Colors.transparent,
                //               border: Border.all(
                //                 color: selectedConditions.contains(other)
                //                     ? AppConstants.primaryColor
                //                     : Colors.white,
                //               ),
                //             ),
                //             margin: const EdgeInsets.symmetric(
                //               horizontal: 4.0,
                //               vertical: 6.0,
                //             ),
                //             child: Text(
                //               other,
                //               textAlign: TextAlign.center,
                //               maxLines: 2,
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.white,
                //                 fontSize: 12,
                //                 letterSpacing: 0.5,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // UIHelper.verticalSpace(6.0),
                // Container(
                //   padding: EdgeInsets.only(left: 18,right: 18),
                //   child: InkWell(
                //     onTap: () async {
                //       if (selectedConditions.contains('None')) {
                //         setState(() {
                //           selectedConditions.remove('None');
                //           user.preambleModel.existingDisease.remove('None');
                //         });
                //       } else {
                //         setState(() {
                //           selectedConditions.clear();
                //           user.preambleModel.existingDisease.clear();
                //           selectedConditions.add('None');
                //           user.preambleModel.existingDisease.add('None');
                //         });
                //       }
                //     },
                //     child: Container(
                //       width: MediaQuery.of(context).size.width * .78,
                //       padding: const EdgeInsets.all(12.0),
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         color: selectedConditions.contains('None')
                //             ? AppConstants.primaryColor
                //             : Colors.transparent,
                //         border: Border.all(
                //           color: selectedConditions.contains('None')
                //               ? AppConstants.primaryColor
                //               : Colors.white,
                //         ),
                //       ),
                //       margin: const EdgeInsets.symmetric(
                //         horizontal: 4.0,
                //         vertical: 6.0,
                //       ),
                //       child: Text(
                //         'None of the above',
                //         textAlign: TextAlign.center,
                //         maxLines: 2,
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //           fontSize: 12,
                //           letterSpacing: 0.5,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                SizedBox(height: 20),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Row(
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
                        value: user.preambleModel.isDrinking,
                        onChanged: (val) {
                          setState(() {
                            user.preambleModel.isDrinking =
                                !user.preambleModel.isDrinking;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                        inactiveTrackColor: Colors.grey,
                      ),
                    ], //<Widget>[]
                  ),
                ),
                if (user.preambleModel.isDrinking) ...{
                  UIHelper.verticalSpace(6.0),
                  Container(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Text(
                      AppConstants.drinkingText,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.TEXT_DARK,
                      ),
                    ),
                  )
                },
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Row(
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
                        value: user.preambleModel.isSmoking,
                        onChanged: (val) {
                          setState(() {
                            user.preambleModel.isSmoking =
                                !user.preambleModel.isSmoking;
                          });
                        },
                        activeColor: AppConstants.primaryColor,
                        inactiveTrackColor: Colors.grey,
                      ),
                    ], //<Widget>[]
                  ),
                ),
                if (user.preambleModel.isSmoking) ...{
                  UIHelper.verticalSpace(6.0),
                  Container(
                      padding: EdgeInsets.only(left: 18, right: 18),
                      child: Text(
                        AppConstants.smokingText,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.TEXT_DARK,
                        ),
                      )),
                },
                SizedBox(
                  height: 100.0,
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

  Widget oldUI(UserController user) {
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
                  goalWeight: newValue.toString(),
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

  Future<String> otherMedical(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CustomTextDialog(),
    );
  }
}
