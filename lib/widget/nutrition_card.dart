import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/model/diet_item.dart';
import 'package:wtf/widget/progress_loader.dart';

class Nutritioncard extends StatefulWidget {
  final String nutrionType;
  final List<Breakfast> breakfast;
  final String date;
  final String day;
  const Nutritioncard({
    Key key,
    this.nutrionType,
    this.breakfast,
    this.date,
    this.day,
  }) : super(key: key);

  @override
  State<Nutritioncard> createState() => _NutritioncardState();
}

class _NutritioncardState extends State<Nutritioncard> {
  bool isLoading = true;
  int totalcal = 0;
  int totalconsumed = 0;
  GymStore store;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  totalfoodCalories() {
    totalcal = 0;

    widget.breakfast.forEach((element) {
      totalcal += int.parse(element.cal ?? "0");
    });
  }

  totalConsumedCalories() {
    totalconsumed = 0;

    widget.breakfast.forEach((element) {
      if (element.consumptionStatus ?? false) {
        totalconsumed += int.parse(element.cal);
      }
    });
  }

  Future pickImage(String uid) async {
    File image;
    try {
      final tempimage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (tempimage == null) return;
      image = File(tempimage.path);
      _showDialog(image, uid);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _showDialog(File image, String uid) {
    String base64Image;
    if (image != null) {
      base64Image = base64Encode(image.readAsBytesSync());
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: .57.sh,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppConstants.boxBorderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  AppConstants.stcoinbgColor,
                  AppConstants.primaryColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        image == null
                            ? Container(
                                height: 250,
                                width: 160,
                                child: Center(
                                  child: Text(
                                    "You need to submit your diet photo",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Image.file(
                                image,
                                height: 250,
                                width: 160,
                                fit: BoxFit.cover,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      NavigationService.goBack;
                      pickImage(uid);
                    },
                    child: Container(
                      height: .05.sh,
                      width: .8.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppConstants.stcoinbgColor,
                              AppConstants.primaryColor,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(0, 2), // Shadow position
                            )
                          ]),
                      child: Center(
                        child: Text(
                          image == null ? "Take a photo" : "Change Photo!",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  image != null
                      ? GestureDetector(
                          onTap: () async {
                            DateTime tdate = DateTime.now();
                            final df = DateFormat('dd-MM-yyyy');
                            String today = df.format(tdate).toString();
                            if (today == widget.date) {
                              store
                                  .dietConsume(
                                    context: context,
                                    mealId: uid,
                                    date: widget.date,
                                    image: base64Image,
                                  )
                                  .then((value) => store.getdietcat(
                                      context: context,
                                      day: widget.day,
                                      date: widget.date))
                                  .then((value) => NavigationService.goBack);
                            } else {
                              FlashHelper.informationBar(
                                context,
                                message: "You can't consume it now",
                              );
                            }
                          },
                          child: Container(
                            height: .05.sh,
                            width: .8.sw,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    AppConstants.stcoinbgColor,
                                    AppConstants.primaryColor,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // Shadow position
                                  )
                                ]),
                            child: Center(
                              child: Text(
                                "Submit Diet!",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<GymStore>(context);
    totalfoodCalories();
    totalConsumedCalories();

    return isLoading
        ? Consumer<GymStore>(
            builder: (context, value, child) => Card(
              margin: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppConstants.dietCardHeading,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(4),
                    height: 65,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          height: 20,
                          left: 15,
                          top: 8,
                          child: Text(
                            widget.nutrionType.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 15,
                          child: Image.asset("assets/images/calorie.png"),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 40,
                          child: Text.rich(
                            TextSpan(
                                text: totalconsumed.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: " kacl ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "/ $totalcal ",
                                    style: TextStyle(
                                      fontFamily: Fonts.ROBOTO,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "kacl",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        // Positioned(
                        //   right: 2,
                        //   top: 6,
                        //   child: Icon(
                        //     Icons.add,
                        //     size: 30,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          AppConstants.dietCardHeading,
                          AppConstants.bgColor,
                        ],
                        stops: [-5.0, 1.0],
                      ),
                    ),
                    child: ListView.separated(
                      physics:
                          ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      itemCount: widget.breakfast.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            CheckboxListTile(
                              title: Text(
                                widget.breakfast[index].name.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                widget.breakfast[index].cal.toString() +
                                    ' cals',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              secondary: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  color: Colors.black87,
                                  child: Image.network(
                                    widget.breakfast[index].coImage.isEmpty ||
                                            widget.breakfast[index].coImage ==
                                                null ||
                                            widget.breakfast[index].coImage ==
                                                "null"
                                        ? Images.noImageFound
                                        : widget.breakfast[index].coImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              autofocus: false,
                              dense: false,
                              activeColor: AppConstants.primaryColor,
                              checkColor: Colors.white,
                              selected: false,
                              value:
                                  widget.breakfast[index].consumptionStatus ??
                                      false,
                              onChanged: (bool value) {
                                DateTime tdate = DateTime.now();
                                final df = DateFormat('dd-MM-yyyy');
                                String today = df.format(tdate).toString();
                                if (today == widget.date) {
                                  if (widget
                                      .breakfast[index].consumptionStatus) {
                                    FlashHelper.informationBar(
                                      context,
                                      message: "Meal alrady consumed",
                                    );
                                  } else {
                                    _showDialog(
                                        null, widget.breakfast[index].uid);
                                  }
                                } else {
                                  FlashHelper.informationBar(
                                    context,
                                    message:
                                        "You can only consume the meal for today",
                                  );
                                }

                                //pickImage();
                              },
                            ),
                            // Positioned(
                            //   right: 25,
                            //   bottom: 5,
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(30),
                            //       color: AppConstants.primaryColor,
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(2.0),
                            //       child: Image.asset(
                            //         'assets/images/question-mark.png',
                            //         height: 15,
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 1,
                          width: 1,
                          color: Colors.white54,
                          padding: EdgeInsets.only(left: 10, right: 10),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Align(
            alignment: Alignment.topCenter,
            child: Loading(),
          );
  }
}
