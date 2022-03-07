import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
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
  var genderList = <String>[
    'Male',
    'Female',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserController>(context, listen: false);
    if (user.gender != null && user.gender != '') {
      _value = genderList.indexOf(user.gender);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, user, snapshot) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Column(
                      children: [
                        InkWell(
                          onTap:(){
                            setState(() {
                              user.gender = genderList[0];
                              locator<AppPrefs>().gender.setValue(genderList[0]);
                            });
                            },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(8)),
                              color: Color(0xff922224),
                              border:Border.all(width: 2,color:user.gender == genderList[0] ? Colors.white:Color(0xff922224))
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
                              user.gender = genderList[1];
                              locator<AppPrefs>().gender.setValue(genderList[1]);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration:BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(8)),
                                color: Color(0xff922224),
                                border:Border.all(width: 2,color:user.gender == genderList[1] ? Colors.white:Color(0xff922224))
                            ),child: SvgPicture.asset(
                              'assets/svg/male_filter.svg',
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
                             user.gender = genderList[2];
                             locator<AppPrefs>().gender.setValue(genderList[2]);
                           });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration:BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(8)),
                                color: Color(0xff922224),
                                border:Border.all(width: 2,color:user.gender == genderList[2] ? Colors.white:Color(0xff922224))
                            ),child: SvgPicture.asset(
                              'assets/svg/male_filter.svg',
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
                value: user.age,
                minValue: 1,
                maxValue: 100,
                step: 1,
                haptics: true,
                onChanged: (value) {
                  setState(() {
                    user.setValue(age: value);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Widget oldUI(UserController user){
    return Column(
      children: [
        // GenderSelectionTopBar(),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GenderItem(
              title: genderList[0],
              isSelected: user.gender == genderList[0],
              onPress: (str) {
                setState(() {
                  user.gender = str;
                  locator<AppPrefs>().gender.setValue(str);
                });
              },
            ),
            SizedBox(
              width: 5,
            ),
            GenderItem(
              title: genderList[1],
              isSelected: user.gender == genderList[1],
              onPress: (str) {
                setState(() {
                  user.gender = str;
                  locator<AppPrefs>().gender.setValue(str);
                });
              },
            ),
          ],
        ),
        UIHelper.verticalSpace(20.0),
        InkWell(
          onTap: () async {
            setState(() {
              user.gender = 'other';
              locator<AppPrefs>().gender.setValue('other');
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * .78,
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: user.gender == 'other'
                  ? AppConstants.primaryColor
                  : Colors.transparent,
              border: Border.all(
                color: user.gender == 'other'
                    ? AppConstants.primaryColor
                    : Colors.white,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 6.0,
            ),
            child: Text(
              'Other',
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
      ],
    );
  }
}
//
// @override
// Widget build(BuildContext context) {
//   return Consumer<UserController>(
//     builder: (context, user, snapshot) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text("Select your Gender ?",
//               style: TextStyle(fontSize: 22.0, color: Colors.white)),
//           SizedBox(height: 20),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             child: DropdownButton(
//               iconSize: 28,
//               isExpanded: true,
//               dropdownColor: AppColors.TEXT_DARK,
//               value: _value == null ? null : genderList[_value],
//               style: TextStyle(color: Colors.green),
//               items: genderList.map((String value) {
//                 return new DropdownMenuItem<String>(
//                   value: value,
//                   child: new Text(value,
//                       style: TextStyle(color: Colors.red, fontSize: 16)),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _value = genderList.indexOf(value);
//                   print(value);
//                   user.setValue(gender: value);
//                 });
//               },
//             ),
//           ),
//           SizedBox(
//             height: 40.0,
//           ),
//           Text("Select your Body Type ?",
//               style: TextStyle(fontSize: 22.0, color: Colors.white)),
//           SizedBox(height: 20),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             child: DropdownButton(
//               iconSize: 28,
//               isExpanded: true,
//               dropdownColor: AppColors.TEXT_DARK,
//               value: _value2 == null ? null : bodyTypes[_value2],
//               style: TextStyle(color: Colors.green),
//               items: bodyTypes.map((String value) {
//                 return new DropdownMenuItem<String>(
//                   value: value,
//                   child: new Text(value,
//                       style: TextStyle(color: Colors.red, fontSize: 16)),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _value2 = bodyTypes.indexOf(value);
//                   print(value);
//                   user.setValue(bodyType: value);
//                 });
//               },
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
