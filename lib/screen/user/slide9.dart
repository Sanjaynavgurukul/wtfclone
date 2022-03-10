import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';

import '../../main.dart';
import 'package:numberpicker/numberpicker.dart';

import 'dart:math' as math;

class Slide9 extends StatefulWidget {
  @override
  State<Slide9> createState() => _Slide9State();
}

class _Slide9State extends State<Slide9> {
  String bodyType = '';

  List<Map<String, String>> types = [
    {
      'type': 'Lean',
      'image':
      'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/lean.svg'
    },
    {
      'type': 'Skinny',
      'image':
      'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/skinny.svg'
    },
    {
      'type': 'Average',
      'image':
      'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/average.svg'
    },
    {
      'type': 'Athletic',
      'image':
      'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/muscular.svg'
    },
    {
      'type': 'Overweight',
      'image':
      'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/fat.svg'
    },
    {
      'type': 'Heavy',
      'image':
      'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/veryFat.svg'
    },
  ];

  @override
  void initState() {
    // final user = Provider.of<UserController>(context, listen: false);
    // if (user.bodyType != null && user.bodyType != '') {
    //   bodyType = user.bodyType;
    // }
    super.initState();
  }

  List<String> tallList = ['in cm', 'in inches'];
  List<String> weightList = ['in kg', 'in pound'];

  String tallLabel;
  String weightLabel;
  String targetWeightLabel;

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, user, child) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 18, right: 18),
          child: Column(
            children: [
              Text(
                'Let us know more about you',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 40,
              ),
              //Body Type Card :D
              ExpansionTileCard(
                elevation: 0,
                baseColor: Color(0xff922224),
                expandedColor: Color(0xff922224),
                title: Text('Choose your body type',
                    style: TextStyle(color: Colors.white)),
                subtitle: user.preambleModel.bodyType == null
                    ? null
                    : Text(
                  user.preambleModel.bodyType ?? '',
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff292929),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 0.0,
                        spacing: 12.0,
                        children: types
                            .map((e) => newUI(
                            data: e,
                            selected: user.preambleModel.bodyType == null
                                ? false
                                : user.preambleModel.bodyType == e['type'],
                            onClick: () {
                              // print('clicked value');
                              setState(() {
                                bodyType = e['type'];
                                user.preambleModel.bodyType = bodyType;
                                // user.setValue(bodyType: e['type']);
                              });
                            }))
                            .toList()),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              //Your height Card :D
              ExpansionTileCard(
                elevation: 0,
                baseColor: Color(0xff292929),
                expandedColor: Color(0xff922224),
                trailing: PopupMenuButton<String>(
                  color: Color(0xff922224),
                  itemBuilder: (context) => tallList
                      .map((e) => PopupMenuItem(
                    value: e,
                    onTap: () {
                      tallLabel = e;
                      user.preambleModel.heightInCm = e == tallList[0];
                      setState(() {});
                    },
                    child: Text(
                      "$e",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ))
                      .toList(),
                  child: Container(
                    child: Text(tallLabel ?? tallList[0]),
                  ),
                ),
                title: Text('Enter your height',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                subtitle: Text(
                    '${user.preambleModel.heightInCm ? '${user.preambleModel.heightCm} CM' : '${user.preambleModel.heightFeet} Inches'}',
                    style: TextStyle(color: Colors.white)),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff292929),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: user.preambleModel.heightInCm
                        ? NumberPicker(
                      textStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 45,
                        color: Color(0xff922224),
                        fontWeight: FontWeight.bold,
                      ),
                      itemHeight: 60,
                      value: user.preambleModel.heightCm,
                      minValue: 0,
                      maxValue: 200,
                      step: 1,
                      haptics: true,
                      onChanged: (value) {
                        setState(() {
                          user.preambleModel.heightCm = value;
                          // user.setValue(heightFeet: '$value'+'cm');
                        });
                      },
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        UIHelper.verticalSpace(30.0),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Feet',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpace(80.0),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Inches',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DecimalNumberPicker(
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.white54,
                            ),
                            selectedTextStyle: TextStyle(
                              fontSize: 45,
                              color: Color(0xff922224),
                              fontWeight: FontWeight.bold,
                            ),
                            itemHeight: 60,
                            value: user.preambleModel.heightFeet ?? 5.0,
                            minValue: 1,
                            maxValue: 9,
                            haptics: true,
                            decimalPlaces: 2,
                            decimalTextMapper: (text) {
                              print('text: $text');
                              int dec = int.tryParse(text);
                              return dec < 12 ? text : '';
                            },
                            onChanged: (value) {
                              user.preambleModel.heightFeet = value;
                              // user.setValue(heightFeet: value.toString());
                              setState(() {
                                // print('checking decimal number = ${seperateValue(user.heightFeet)[0]} ${seperateValue(user.heightFeet)[1]}');
                              });
                            }
                          /*onChanged: (value) => setState(() => _currentDoubleValue = value

                ),*/
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              // //Your weight card :D
              ExpansionTileCard(
                elevation: 0,
                baseColor: Color(0xff292929),
                expandedColor: Color(0xff922224),
                trailing: PopupMenuButton<String>(
                  color: Color(0xff922224),
                  itemBuilder: (context) => weightList
                      .map((e) => PopupMenuItem(
                    value: e,
                    onTap: () {
                      weightLabel = e;
                      user.preambleModel.weightInKg = e ==weightList[0] ;
                      setState(() {});
                    },
                    child: Text(
                      "$e",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ))
                      .toList(),
                  child: Container(
                    child: Text(weightLabel ?? weightList[0]),
                  ),
                ),
                title: Text('Enter your weight',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                subtitle: user.preambleModel.weightInKg?valueLabel(user.preambleModel.weight):valueLabel(user.preambleModel.weightInLbs),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff292929),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: user.preambleModel.weightInKg
                        ? NumberPicker(
                      textStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 45,
                        color: Color(0xff922224),
                        fontWeight: FontWeight.bold,
                      ),
                      itemHeight: 60,
                      value: user.preambleModel.weight ?? 0,
                      minValue: 0,
                      maxValue: 200,
                      step: 1,
                      haptics: true,
                      onChanged: (value) {
                        setState(() {
                          user.preambleModel.weight = value;
                        });
                      },
                    )
                        : NumberPicker(
                      textStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 45,
                        color: Color(0xff922224),
                        fontWeight: FontWeight.bold,
                      ),
                      itemHeight: 60,
                      value: user.preambleModel.weightInLbs ?? 0,
                      minValue: 0,
                      maxValue: 600,
                      step: 1,
                      haptics: true,
                      onChanged: (value) {
                        setState(() {
                          user.preambleModel.weightInLbs = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              //Target weight card :D
              ExpansionTileCard(
                elevation: 0,
                baseColor: Color(0xff292929),
                expandedColor: Color(0xff922224),
                trailing: PopupMenuButton<String>(
                  color: Color(0xff922224),
                  itemBuilder: (context) => weightList
                      .map((e) => PopupMenuItem(
                    value: e,
                    onTap: () {
                      targetWeightLabel = e;
                      user.preambleModel.targetWeightInKg = e == weightList[0];
                      setState(() {});
                    },
                    child: Text(
                      "$e",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ))
                      .toList(),
                  child: Container(
                    child: Text(targetWeightLabel ?? weightList[0]),
                  ),
                ),
                title: Text ('Target weight',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                subtitle: user.preambleModel.targetWeightInKg
                    ? valueLabel(user.preambleModel.targetWeight)
                    : valueLabel(user.preambleModel.targetWeightInLbs),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff292929),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: user.preambleModel.targetWeightInKg
                        ? NumberPicker(
                      textStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 45,
                        color: Color(0xff922224),
                        fontWeight: FontWeight.bold,
                      ),
                      itemHeight: 60,
                      value:  user.preambleModel.targetWeight??0,
                      minValue: 0,
                      maxValue: 200,
                      step: 1,
                      haptics: true,
                      onChanged: (value) {
                        setState(() {
                          user.preambleModel.targetWeight = value;
                        });
                      },
                    )
                        : NumberPicker(
                      textStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 45,
                        color: Color(0xff922224),
                        fontWeight: FontWeight.bold,
                      ),
                      itemHeight: 60,
                      value: user.preambleModel.targetWeightInLbs??0,
                      minValue: 0,
                      maxValue: 600,
                      step: 1,
                      haptics: true,
                      onChanged: (value) {
                        setState(() {
                          user.preambleModel.targetWeightInLbs = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              SwitchListTile(
                tileColor: Color(0xff292929),
                title: const Text('Gaining Weight'),
                value: user.preambleModel.gainingWeight,
                onChanged: (bool value) {
                  setState(() {
                    user.preambleModel.gainingWeight = value;
                  });
                },
                secondary: const Icon(Icons.lightbulb_outline),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget valueLabel(dynamic value) {
    if (value == null)
      return null;
    else {
      return Text('$value',style:TextStyle(color: Colors.white));
    }
  }

  // Widget so(BuildContext context){
  //   return Consumer<UserController>(
  //     builder: (context, user, child) => SingleChildScrollView(
  //       child: Container(
  //         padding: EdgeInsets.only(top: 40,left: 18,right: 18),
  //         child: Column(
  //           children: [
  //             Text('Let us know more about you' ,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
  //             SizedBox(height: 40,),
  //             //Body Type Card :D
  //             ExpansionTileCard(
  //               elevation: 0,
  //               baseColor: Color(0xff922224),
  //               expandedColor: Color(0xff922224),
  //               title: Text('Choose your body type',
  //                   style: TextStyle(color: Colors.white)),
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                       color: Color(0xff292929),
  //                       borderRadius: BorderRadius.only(
  //                           bottomLeft: Radius.circular(8),
  //                           bottomRight: Radius.circular(8))),
  //                   padding: EdgeInsets.all(12),
  //                   width: double.infinity,
  //                   child: Wrap(
  //                       alignment: WrapAlignment.start,
  //                       runAlignment: WrapAlignment.start,
  //                       crossAxisAlignment: WrapCrossAlignment.start,
  //                       runSpacing: 0.0,
  //                       spacing: 12.0,
  //                       children: types
  //                           .map((e) => newUI(
  //                           data: e,
  //                           selected: bodyType == e['type'],
  //                           onClick: () {
  //                             // print('clicked value');
  //                             setState(() {
  //                               bodyType = e['type'];
  //                               user.setValue(bodyType: e['type']);
  //                             });
  //                           }))
  //                           .toList()),
  //                 )
  //               ],
  //             ),
  //             SizedBox(height: 12,),
  //             //Your height Card :D
  //             ExpansionTileCard(
  //               elevation: 0,
  //               baseColor: Color(0xff292929),
  //               expandedColor: Color(0xff922224),
  //               trailing: _heightChildPopup(),
  //               title: Text('Enter your height',
  //                   style: TextStyle(color: Colors.white,fontSize: 12)),
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                       color: Color(0xff292929),
  //                       borderRadius: BorderRadius.only(
  //                           bottomLeft: Radius.circular(8),
  //                           bottomRight: Radius.circular(8))),
  //                   padding: EdgeInsets.all(12),
  //                   width: double.infinity,
  //                   child: (tallLabel ?? tallList[0]) == tallList[0] ?Height() :HeightCm(),
  //                 )
  //               ],
  //             ),
  //             SizedBox(height: 12,),
  //             //Your weight card :D
  //             ExpansionTileCard(
  //               elevation: 0,
  //               baseColor: Color(0xff292929),
  //               expandedColor: Color(0xff922224),
  //               trailing: _weightChildPopup(),
  //               title: Text('Enter your weight',
  //                   style: TextStyle(color: Colors.white,fontSize: 12)),
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                       color: Color(0xff292929),
  //                       borderRadius: BorderRadius.only(
  //                           bottomLeft: Radius.circular(8),
  //                           bottomRight: Radius.circular(8))),
  //                   padding: EdgeInsets.all(12),
  //                   width: double.infinity,
  //                   child: (weightLabel ?? weightList[0]) == weightList[0] ?NumberPicker(
  //                     textStyle: TextStyle(
  //                       fontSize: 22,
  //                       color: Colors.white,
  //                     ),
  //                     selectedTextStyle: TextStyle(
  //                       fontSize: 45,
  //                       color: Color(0xff922224),
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     itemHeight: 60,
  //                     value: weightInKg,
  //                     minValue: 0,
  //                     maxValue: 200,
  //                     step: 1,
  //                     haptics: true,
  //                     onChanged: (value){
  //                       setState(() {
  //                         weightInKg = value;
  //                         user.setValue(weight: '${weightInKg.toString()} kg');
  //                       });
  //                     },
  //                   ):NumberPicker(
  //                     textStyle: TextStyle(
  //                       fontSize: 22,
  //                       color: Colors.white,
  //                     ),
  //                     selectedTextStyle: TextStyle(
  //                       fontSize: 45,
  //                       color: Color(0xff922224),
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     itemHeight: 60,
  //                     value: weightInPound,
  //                     minValue: 0,
  //                     maxValue: 600,
  //                     step: 1,
  //                     haptics: true,
  //                     onChanged: (value){
  //                       setState(() {
  //                         weightInPound = value;
  //                         // user.setValue(heightFeet: value);
  //                         user.setValue(weight: '${weightInPound.toString()} lbs');
  //                       });
  //                     },
  //                   ),
  //                 )
  //               ],
  //             ),
  //             SizedBox(height: 12,),
  //             //Target weight card :D
  //             ExpansionTileCard(
  //               elevation: 0,
  //               baseColor: Color(0xff292929),
  //               expandedColor: Color(0xff922224),
  //               trailing: _weightChildPopup(),
  //               title: Text('Target weight',
  //                   style: TextStyle(color: Colors.white,fontSize: 12)),
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                       color: Color(0xff292929),
  //                       borderRadius: BorderRadius.only(
  //                           bottomLeft: Radius.circular(8),
  //                           bottomRight: Radius.circular(8))),
  //                   padding: EdgeInsets.all(12),
  //                   width: double.infinity,
  //                   child: (weightLabel ?? weightList[0]) == weightList[0] ?NumberPicker(
  //                     textStyle: TextStyle(
  //                       fontSize: 22,
  //                       color: Colors.white,
  //                     ),
  //                     selectedTextStyle: TextStyle(
  //                       fontSize: 45,
  //                       color: Color(0xff922224),
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     itemHeight: 60,
  //                     value: targetWeightInKg,
  //                     minValue: 0,
  //                     maxValue: 200,
  //                     step: 1,
  //                     haptics: true,
  //                     onChanged: (value){
  //                       setState(() {
  //                         targetWeightInKg = value;
  //                         user.setValue(targetWeight: '${targetWeightInKg.toString()} kg');
  //
  //                       });
  //                     },
  //                   ):NumberPicker(
  //                     textStyle: TextStyle(
  //                       fontSize: 22,
  //                       color: Colors.white,
  //                     ),
  //                     selectedTextStyle: TextStyle(
  //                       fontSize: 45,
  //                       color: Color(0xff922224),
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     itemHeight: 60,
  //                     value: targetWeightInPound,
  //                     minValue: 0,
  //                     maxValue: 600,
  //                     step: 1,
  //                     haptics: true,
  //                     onChanged: (value){
  //                       setState(() {
  //                         targetWeightInPound = value;
  //                         user.setValue(targetWeight: '${targetWeightInPound.toString()} lbs');
  //                         // user.setValue(heightFeet: value);
  //                       });
  //                     },
  //                   ),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
    return Column(
      children: [
        Text(
          "Select your body type",
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        UIHelper.verticalSpace(20.0),
        Container(
          height: Get.height * 0.6,
          width: Get.width,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: types.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => _item(
              title: types[index]['type'],
              onPress: () {
                setState(() {
                  bodyType = types[index]['type'];
                  print('Body Type: ${types[index]}');
                  user.setValue(bodyType: types[index]['type']);
                });
              },
              isSelected: bodyType == types[index]['type'],
              image: types[index]['image'],
            ),
          ),
        ),
        UIHelper.verticalSpace(8.0),
        Text(
          AppConstants.confidentialInfo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            color: AppColors.TEXT_DARK,
          ),
        ),
      ],
    );
  }

  _item({title, isSelected, onPress, String image}) {
    return InkWell(
      onTap: onPress,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100.0,
                width: 120.0,
                // alignment: Alignment.centerRight,
                child: SvgPicture.asset(image),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          if (isSelected)
            AnimatedPositioned(
              bottom: 56.0,
              right: 24.0,
              duration: Duration(
                milliseconds: 650,
              ),
              curve: Curves.easeInOutCubic,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
            )
        ],
      ),
    );
  }

}