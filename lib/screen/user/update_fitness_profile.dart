import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/user/slide0.dart';
import 'package:wtf/screen/user/slide1.dart';
import 'package:wtf/screen/user/slide10.dart';
import 'package:wtf/screen/user/slide12.dart';
import 'package:wtf/screen/user/slide3.dart';
import 'package:wtf/screen/user/slide4.dart';
import 'package:wtf/screen/user/slide5.dart';
import 'package:wtf/screen/user/slide6.dart';
import 'package:wtf/screen/user/slide7.dart';
import 'package:wtf/screen/user/slide8.dart';
import 'package:wtf/screen/user/slide9.dart';
import 'package:wtf/widget/Shimmer/values/type.dart';

class UpdateFitnessProfile extends StatefulWidget {
  @override
  _UpdateFitnessProfileState createState() => _UpdateFitnessProfileState();
}

class _UpdateFitnessProfileState extends State<UpdateFitnessProfile> {
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

  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   Navigator.of(context).pop(false);
  //
  //   return true;
  // }
  List<Widget> contents = [];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    contents = <Widget>[
      Slide0(
        subTitle:
            'To help us serve you better and give you a wholesome experience, please keep updating your fitness profile on weekly basis.',
        title: 'Update your Fitness Profile',
      ),
      Slide1(),
      Slide9(),
      // Slide11(),
      Slide3(),
      Slide4(),
      Slide5(),
      Slide6(),
      Slide7(),
      Slide8(),
      Slide12(),
      Slide10(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Consumer<UserController>(builder: (context, user, snapshot) {
        return Container(
          color: AppColors.PRIMARY_COLOR,
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    UIHelper.verticalSpace(30.0),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (index) => buildDot(index, context),
                        ),
                      ),
                    ),
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
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 40,
                              horizontal: 30.0,
                            ),
                            child: contents[i],
                          );
                        },
                      ),
                    ),
                  ],
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
                              if (currentIndex + 1 == contents.length) {
                                Map<String, dynamic> res =
                                    await user.updateMember(context: context);
                                if (res['status']) {
                                  // NavigationService.navigateTo(Routes.mainHome);
                                  context
                                      .read<GymStore>()
                                      .init(context: context);
                                  NavigationService.popAndReplace(
                                      Routes.homePage);
                                } else {
                                  key.currentState.showSnackBar(
                                    new SnackBar(
                                      content: Text(res['message']),
                                    ),
                                  );
                                }
                              } else {
                                // if (currentIndex == 0) {
                                //   if (user.name == null || user.name.isEmpty) {
                                //     key.currentState.showSnackBar(new SnackBar(
                                //         content: new Text('Enter your name')));
                                //     return;
                                //   }
                                // }

                                if (currentIndex == 1) {
                                  if (user.gender == null ||
                                      user.gender == '') {
                                    key.currentState.showSnackBar(
                                      new SnackBar(
                                        content: new Text('Select your gender'),
                                      ),
                                    );
                                    return;
                                  }
                                }
                                if (currentIndex == 2) {
                                  if (user.bodyType == null ||
                                      user.bodyType == '') {
                                    key.currentState.showSnackBar(
                                      new SnackBar(
                                        content:
                                            new Text('Select your body type'),
                                      ),
                                    );
                                    return;
                                  }
                                }

                                if (currentIndex == 3) {
                                  if (user.age == 1) {
                                    key.currentState.showSnackBar(
                                      new SnackBar(
                                        content: new Text('Select your age'),
                                      ),
                                    );
                                    return;
                                  }
                                }

                                if (currentIndex == 4) {
                                  if (user.heightFeet == 1.0) {
                                    key.currentState.showSnackBar(
                                      new SnackBar(
                                        content: new Text('Select your height'),
                                      ),
                                    );
                                    return;
                                  }
                                }

                                if (currentIndex == 5) {
                                  if (user.weight == 1) {
                                    key.currentState.showSnackBar(
                                      new SnackBar(
                                        content: new Text('Select your weight'),
                                      ),
                                    );
                                    return;
                                  }
                                }

                                if (currentIndex == 6) {
                                  if (user.targetWeight == 1) {
                                    key.currentState.showSnackBar(new SnackBar(
                                        content: new Text(
                                            'Select your target weight')));
                                    return;
                                  }
                                }

                                if (currentIndex == 8) {
                                  context.read<GymStore>().getdietPref(
                                      context: context,
                                      type: DietPrefType.type1);
                                  context.read<GymStore>().getdietPref(
                                      context: context,
                                      type: DietPrefType.type2);
                                  if (user.existingDisease.length == null ||
                                      user.existingDisease.length == 0) {
                                    key.currentState.showSnackBar(
                                      new SnackBar(
                                        content: new Text('Select disease'),
                                      ),
                                    );
                                    return;
                                  }
                                }

                                if (currentIndex == 9) {
                                  if (user.type1 == null ||
                                      user.type2 == null) {
                                    key.currentState.showSnackBar(
                                      new SnackBar(
                                        content: new Text('Select your diet'),
                                      ),
                                    );
                                    return;
                                  }
                                }

                                _controller.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInToLinear,
                                );
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
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: currentIndex == index ? 30 : 20,
      margin: EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: currentIndex == index ? Colors.red : Colors.white,
      ),
    );
  }
}
