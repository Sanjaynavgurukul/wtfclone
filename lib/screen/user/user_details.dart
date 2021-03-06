import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/screen/user/slide0.dart';
import 'package:wtf/screen/user/slide1.dart';
import 'package:wtf/screen/user/slide10.dart';
import 'package:wtf/screen/user/slide12.dart';
import 'package:wtf/screen/user/slide7.dart';
import 'package:wtf/screen/user/slide9.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  bool visible = false;

  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  loadProgress() {
    Timer timer = Timer(Duration(seconds: 1), () {
      setState(() {
        visible = false;
      });
    });
  }

  GymStore user;

  List<Widget> contents = [];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    user = Provider.of<GymStore>(context, listen: false);
    contents = <Widget>[
      Slide0(
        title: 'Welcome to WTF',
        subTitle:
            'To help us serve you better and give you a wholesome experience, please complete your fitness profile.',
      ),
      // Slide2(),//
      Slide1(), //
      Slide9(), //
      // Slide11(),
      // Slide2(),
      // Slide3(),
      // Slide4(),
      // Slide5(),
      // Slide6(),
      Slide7(), //
      // Slide8(),
      Slide12(), //
      Slide10(), //
    ];
    // BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  // void showPlacePicker(GymStore store) async {
  //   LocationResult result = await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //         Helper.googleMapKey,
  //         displayLocation: LatLng(
  //             store.currentPosition.latitude, store.currentPosition.longitude),
  //       ),
  //     ),
  //   );
  //   print(result);
  //
  //     store.preambleModel.location = result.formattedAddress;
  //     // user.setValue(address: result.formattedAddress);
  //
  //   // Handle the result in your way
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (locator<AppPrefs>().updateMemberData.getValue()) {
        //   return true;
        // } else {
        //   switch (currentIndex) {
        //     case 0:
        //       return false;
        //     case 1:
        //     case 2:
        //     case 3:
        //     case 4:
        //     case 5:
        //     case 6:
        //     case 7:
        //     case 8:
        //     case 9:
        //     case 10:
        //     case 11:
        //     case 12:
        //       currentIndex--;
        //       _controller.animateToPage(currentIndex,
        //           duration: Duration(milliseconds: 400),
        //           curve: Curves.easeInCubic);
        //       return false;
        //     default:
        //       return false;
        //   }
        // }
        return true;
      },
      child: Scaffold(
        key: key,
        backgroundColor: AppColors.PRIMARY_COLOR,
        body: Consumer<GymStore>(builder: (context, user, snapshot) {
          return Scaffold(
            // color: AppColors.PRIMARY_COLOR,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: new NeverScrollableScrollPhysics(),
                      controller: _controller,
                      itemCount: contents.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (_, i) {
                        return contents[i];
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentIndex == 0
                            ? Container(
                                height: 50,
                              )
                            : Container(
                                height: 50,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.previousPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInToLinear);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(60),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_back_outlined,
                                            color: AppConstants.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: currentIndex == 0 ? 18 : 0),
                            child: Row(
                              mainAxisAlignment: currentIndex == 0
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: List.generate(
                                contents.length,
                                (index) => buildDot(index, context),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(170)),
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward,
                                  color: AppConstants.primaryColor),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                // if (currentIndex + 1 == contents.length) {
                                //   Map<String, dynamic> res =
                                //       await user.addMember(context: context);
                                //   if (res['status']) {
                                //     // NavigationService.navigateTo(Routes.mainHome);
                                //     context
                                //         .read<GymStore>()
                                //         .init(context: context);
                                //     NavigationService.popAndReplace(
                                //         Routes.homePage);
                                //   } else {
                                //     key.currentState.showSnackBar(
                                //       new SnackBar(
                                //         content: Text(res['message']),
                                //       ),
                                //     );
                                //   }
                                // } else {
                                //   // if (currentIndex == 0) {
                                //   //   if (user.name == null || user.name.isEmpty) {
                                //   //     key.currentState.showSnackBar(new SnackBar(
                                //   //         content: new Text('Enter your name')));
                                //   //     return;
                                //   //   }
                                //   // }
                                //
                                //   //Gender and age validation :D
                                //   if (currentIndex == 1) {
                                //     //Checking Gender Validation :D
                                //     if (user.gender == null &&
                                //         user.gender == '') {
                                //       displaySnack('Please select gender');
                                //       return;
                                //     } else if (user.age == null ||
                                //         user.age == 0) {
                                //       displaySnack('Please select Age!');
                                //       return;
                                //     }
                                //
                                //     // else if()
                                //     //   if (user.gender == null &&
                                //     //       user.gender == '' && user.age != null && user.age != 0) {
                                //     //     key.currentState.showSnackBar(
                                //     //       new SnackBar(
                                //     //         content:
                                //     //             new Text('Select your gender'),
                                //     //       ),
                                //     //     );
                                //     //     return;
                                //     //   }
                                //   }
                                //   //Body Type height weight target weight validation :D
                                //   if (currentIndex == 2) {
                                //     if (user.bodyType == null ||
                                //         user.bodyType == '') {
                                //       displaySnack('Select your body type');
                                //       return;
                                //     } else if (user.heightFeet == null ||
                                //         user.heightFeet == 0) {
                                //       displaySnack('Please choose your height');
                                //       return;
                                //     } else if (user.weight == null ||
                                //         user.weight == 0) {
                                //       displaySnack('Please choose your weight');
                                //       return;
                                //     } else if (user.targetWeight == null ||
                                //         user.targetWeight == 0) {
                                //       displaySnack(
                                //           'Please choose your target weight');
                                //       return;
                                //     }
                                //   }
                                //
                                //   if (currentIndex == 3) {
                                //     if (user.targetWeight == null ||
                                //         user.targetWeight == 0) {
                                //       displaySnack(
                                //           'Please select your target weight per week');
                                //       return;
                                //     } else if (user.existingDisease.length ==
                                //             null ||
                                //         user.existingDisease.length == 0) {
                                //       key.currentState.showSnackBar(
                                //         new SnackBar(
                                //           content: new Text('Select disease'),
                                //         ),
                                //       );
                                //       return;
                                //     }
                                //     context.read<GymStore>().getdietPref(
                                //         context: context,
                                //         type: DietPrefType.type1);
                                //     context.read<GymStore>().getdietPref(
                                //         context: context,
                                //         type: DietPrefType.type2);
                                //   }
                                //
                                //   if (currentIndex == 4) {
                                //     if (user.type1 == null ||
                                //         user.type1.isEmpty ||
                                //         user.type1 == '') {
                                //       displaySnack(
                                //           'Please select your Fitness goal!');
                                //       return;
                                //     } else if (user.type2 == null ||
                                //         user.type2.isEmpty ||
                                //         user.type2 == '') {
                                //       displaySnack('Please select your diet preference');
                                //       return;
                                //     }
                                //   }

                                // if (currentIndex == 100) {
                                //   if (user.address == null ||
                                //       user.address.isEmpty) {
                                //     key.currentState.showSnackBar(
                                //       new SnackBar(
                                //         content:
                                //         new Text('Enter your city name'),
                                //       ),
                                //     );
                                //     return;
                                //   }
                                // }
                                //
                                // if (currentIndex == 5) {
                                //   if (user.age == 1) {
                                //     key.currentState.showSnackBar(
                                //       new SnackBar(
                                //         content: new Text('Select your age'),
                                //       ),
                                //     );
                                //     return;
                                //   }
                                // }
                                //
                                // if (currentIndex == 6) {
                                //   if (user.heightFeet == 1.0) {
                                //     key.currentState.showSnackBar(
                                //       new SnackBar(
                                //         content:
                                //         new Text('Select your height'),
                                //       ),
                                //     );
                                //     return;
                                //   }
                                // }
                                //
                                // if (currentIndex == 7) {
                                //   if (user.weight == 1) {
                                //     key.currentState.showSnackBar(
                                //       new SnackBar(
                                //         content:
                                //         new Text('Select your weight'),
                                //       ),
                                //     );
                                //     return;
                                //   }
                                // }
                                //
                                // if (currentIndex == 8) {
                                //   if (user.targetWeight == 1) {
                                //     key.currentState.showSnackBar(new SnackBar(
                                //         content: new Text(
                                //             'Select your target weight')));
                                //     return;
                                //   }
                                // }
                                //
                                // if (currentIndex == 10) {
                                //   if (user.existingDisease.length == null ||
                                //       user.existingDisease.length == 0) {
                                //     key.currentState.showSnackBar(
                                //       new SnackBar(
                                //         content: new Text('Select disease'),
                                //       ),
                                //     );
                                //     return;
                                //   }
                                //   context.read<GymStore>().getdietPref(
                                //       context: context,
                                //       type: DietPrefType.type1);
                                //   context.read<GymStore>().getdietPref(
                                //       context: context,
                                //       type: DietPrefType.type2);
                                // }
                                //
                                // if (currentIndex == 11) {
                                //   if (user.type1 == null &&
                                //       user.type2 == null) {
                                //     key.currentState.showSnackBar(
                                //         new SnackBar(
                                //             content: new Text(
                                //                 'Select your diet and')));
                                //     return;
                                //   }
                                // }

                                //

                                //age and gender :D
                               //  if(currentIndex == 1){
                               //    if(user.preambleModel.location == null){
                               //      displaySnack('Please Select your location');
                               //      return;
                               //    }else{
                               //      gotoNext();
                               //    }
                               //  }
                               // else
                                if(currentIndex == 0){
                                 if(user.preambleModel.location == null || user.preambleModel.location.isEmpty){
                                  displaySnack('Please Select your location');
                                  return;
                                }else{
                                   gotoNext();
                                 }
                                }
                                 else if (currentIndex == 1) {
                                  if (user.preambleModel.gender == null ||
                                      user.preambleModel.gender.isEmpty) {
                                    displaySnack('Please select your gender!');
                                    return;
                                  } else if (user.preambleModel.age == null ||
                                      user.preambleModel.age == 0) {
                                    displaySnack('Please select valid age!');
                                    return;
                                  } else {
                                    gotoNext();
                                  }
                                } else if (currentIndex == 2) {
                                  if (user.preambleModel.body_type == null) {
                                    displaySnack(
                                        'Please select your body type!');
                                    return;
                                  } //validating in height in cm
                                  else if (user.preambleModel.howactive ==
                                          null ||
                                      user.preambleModel.howactive.isEmpty) {
                                    displaySnack(
                                        'Please choose your workout experience');
                                    return;
                                  } else if (user.preambleModel.heightInCm &&
                                      (user.preambleModel.heightCm == null ||
                                          user.preambleModel.heightCm == 0)) {
                                    displaySnack(
                                        'Please choose your valid height in cm!');
                                    return;
                                  } //validating in height in Feet
                                  else if (!user.preambleModel.heightInCm &&
                                      (user.preambleModel.heightFeet == null ||
                                          user.preambleModel.heightFeet == 0)) {
                                    displaySnack(
                                        'Please choose your valid height in feet!');
                                    return;
                                  }
                                  //validating your weight in kg
                                  else if (user.preambleModel.weightInKg &&
                                      (user.preambleModel.weightKg == null ||
                                          user.preambleModel.weightKg == 0)) {
                                    displaySnack(
                                        'Please choose your valid weight in kg!');
                                    return;
                                  } //validating your weight in pound
                                  else if(user.preambleModel.target_weight  == 0 || user.preambleModel.target_weight == null){
                                    displaySnack(
                                        'Please choose your valid target weight in kg!');
                                    return;
                                  }
                                  // else if (user
                                  //         .preambleModel.target_weight &&
                                  //     (user.preambleModel.targetWeight ==
                                  //             null ||
                                  //         user.preambleModel.targetWeight ==
                                  //             0)) {
                                  //   displaySnack(
                                  //       'Please choose your valid target weight in kg!');
                                  //   return;
                                  // } //validating target weight in lbs
                                  // else if (!user
                                  //         .preambleModel.targetWeightInKg &&
                                  //     (user.preambleModel.targetWeightInLbs ==
                                  //             null ||
                                  //         user.preambleModel
                                  //                 .targetWeightInLbs ==
                                  //             0)) {
                                  //   displaySnack(
                                  //       'Please choose your valid target weight in lbs!');
                                  //   return;
                                  // }

                                  else {
                                    gotoNext();
                                  }
                                }
                                else if (currentIndex == 3) {
                                  if (user.preambleModel.target_duration == null ||
                                      user.preambleModel.target_duration == 0.0) {
                                    displaySnack(
                                        'Please select valid goal weight!');
                                    return;
                                  } else if (user
                                              .preambleModel.existing_disease ==
                                          null ||
                                      user.preambleModel.existing_disease
                                          .isEmpty) {
                                    displaySnack(
                                        'Please select 1 medical condition!');
                                    return;
                                  } else {
                                    gotoNext();
                                  }
                                }
                                else if (currentIndex == 4) {
                                  if (user.preambleModel.type1 == null ||
                                      user.preambleModel.type1.isEmpty) {
                                    displaySnack(
                                        'Please select your fitness goal');
                                    return;
                                  } else if (user.preambleModel.type2 == null ||
                                      user.preambleModel.type2.isEmpty) {
                                    displaySnack(
                                        'Please select your diet preference');
                                    return;
                                  } else {
                                    gotoNext();
                                  }
                                }
                                // else if(currentIndex == 5){
                                //   user.updatePreamble(user.preambleModel).then((value) {
                                //     if(value != null && value){
                                //       if (!user.preambleFromLogin) Navigator.pop(context);
                                //       if (value) {
                                //         // FlashHelper.successBar(context, message: 'BMR result Saved');
                                //         if (!user.preambleFromLogin) {
                                //           context.read<GymStore>().init(context: context);
                                //           NavigationService.navigateTo(Routes.bmrCalculatorResult);
                                //         }
                                //       } else {
                                //         displaySnack('Please try again!');
                                //       }
                                //     }else{
                                //       displaySnack('Something went wrong please try again later!');
                                //     }
                                //   });
                                // }
                                else {
                                  gotoNext();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void gotoNext() {
    if (currentIndex == 5) {
      user.preambleModel.user_id = locator<AppPrefs>().memberId.getValue();
      // print('check uid -- ${user.preambleModel.uid}');
      updatePreambleData();
    } else {
      _controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInToLinear,
      );
    }
  }

  void displaySnack(String message) {
    key.currentState.showSnackBar(
      new SnackBar(
        content: new Text('$message'),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 6,
      width: 6,
      // width: currentIndex == index ? 30 : 20,
      // margin: EdgeInsets.only(right: 7),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: currentIndex == index ? Colors.red : Colors.white,
      ),
    );
  }

  void updatePreambleData() {
    // updateMember();
    user.updatePreamble(data: user.preambleModel).then((value) {
      if (value) {
        // if(user.preambleFromLogin){
        //   addMember();
        // }else{
        //   updateMember();
        // }
       updateMember();
      } else {
        displaySnack('Something went wrong while saving BMR!!');
      }
    });
  }

  void updateMember() {
    print('check data === uid ${user.preambleModel.user_id}  ${user.preambleModel.user_uid}');
    user
        .updateMember(
            context: context,
            data: user.preambleModel,
            isLogin: locator<AppPrefs>().memberAdded.getValue())
        .then((value) {
      // Navigator.pop(context);
      if (value) {
       // saveBMR();
        if(user.preambleFromPayment){
          locator<AppPrefs>().memberAdded.setValue(true);
          Navigator.pop(context,true);
        }else{
          if (user.preambleFromLogin) {
            locator<AppPrefs>().memberAdded.setValue(true);
            NavigationService.navigateToReplacement(Routes.homePage);
          } else {
            // NavigationService.navigateTo(Routes.bmrCalculatorResult);
            locator<AppPrefs>().memberAdded.setValue(true);
            // NavigationService.navigateToReplacement(Routes.bmrCalculatorResult);
            Navigator.pop(context);
          }
        }
      } else {
        displaySnack('Something went wrong please try again later!!');
      }
    });
  }

  void saveBMR(){
    user.saveBmr();
  }
}
