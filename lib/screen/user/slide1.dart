import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';

import '../../main.dart';
import 'gender_selection/gender_item.dart';

class Slide1 extends StatefulWidget {
  @override
  State<Slide1> createState() => _Slide1State();
}

class _Slide1State extends State<Slide1> {
  int _value;
  // final _place = TextEditingController();

  var genderList = <String>[
    'Male',
    'Female',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, user, snapshot) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 40,left: 18,right: 18),
            child: Column(
              children: [
                Text('Choose Who you are' ,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                SizedBox(height: 40,),
                Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: Column(
                        children: [
                          InkWell(
                            onTap:(){
                              setState(() {
                                user.preambleModel.gender = genderList[0];
                                // locator<AppPrefs>().gender.setValue(genderList[0]);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.all(Radius.circular(8)),
                                  color: Color(0xff922224),
                                  border:Border.all(width: 2,color:user.preambleModel.gender == genderList[0] ? Colors.white:Color(0xff922224))
                              ),child: SvgPicture.asset(
                                'assets/svg/male_filter.svg',
                                color: Colors.white,
                                semanticsLabel: 'male selection'
                            ),
                            ),
                          ),
                          SizedBox(height:8),
                          Text(genderList[0],style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600),)
                        ],
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      flex:1,
                      child: Column(
                        children: [
                          InkWell(
                            onTap:(){
                              setState(() {
                                user.preambleModel.gender = genderList[1];
                                locator<AppPrefs>().gender.setValue(genderList[1]);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.all(Radius.circular(8)),
                                  color: Color(0xff922224),
                                  border:Border.all(width: 2,color:user.preambleModel.gender == genderList[1] ? Colors.white:Color(0xff922224))
                              ),child: SvgPicture.asset(
                                'assets/svg/female_gender.svg',
                                color: Colors.white,
                                semanticsLabel: 'male selection'
                            ),
                            ),
                          ),
                          SizedBox(height:8),
                          Text(genderList[1],style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600),)
                        ],
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      flex:1,
                      child: Column(
                        children: [
                          InkWell(
                            onTap:(){
                              setState(() {
                                user.preambleModel.gender = genderList[2];
                                locator<AppPrefs>().gender.setValue(genderList[2]);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.all(Radius.circular(8)),
                                  color: Color(0xff922224),
                                  border:Border.all(width: 2,color:user.preambleModel.gender == genderList[2] ? Colors.white:Color(0xff922224))
                              ),child: SvgPicture.asset(
                                'assets/svg/other_gender.svg',
                                color: Colors.white,
                                semanticsLabel: 'male selection'
                            ),
                            ),
                          ),
                          SizedBox(height:8),
                          Text(genderList[2],style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600),)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height:40),
                Text("What is your Age?",
                    style: TextStyle(fontSize: 22.0, color: Colors.white)),
                NumberPicker(
                  textStyle: TextStyle(
                    fontSize: 25,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  selectedTextStyle: TextStyle(
                    fontSize: 45,
                    color: Color(0xff922224),
                    fontWeight: FontWeight.bold,
                  ),
                  // decoration: BoxDecoration(
                  //   color: AppConstants.primaryColor.withOpacity(0.6),
                  // ),
                  itemHeight: 60,
                  value: user.preambleModel.age??24,
                  minValue: 1,
                  maxValue: 100,
                  step: 1,
                  haptics: true,
                  onChanged: (value) {
                    setState(() {
                      // user.setValue(age: value);
                      user.preambleModel.age = value;
                    });
                  },
                ),
                SizedBox(height: 16,),
              ],
            ),
          ),
        );
      },
    );
  }
}