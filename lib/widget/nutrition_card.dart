import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/model/diet_item.dart';
import 'package:wtf/screen/nutrition/diet_schedule.dart';
import 'package:wtf/widget/custom_button.dart';
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

  Future<void> _showDialog(File image, String uid) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DietSaverDialog(
          uid: uid,
          date: widget.date,
          day: widget.day,
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
            builder: (context, store, child) => Card(
              margin: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Color(0xff2d2d2d),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: AppConstants.dietCardHeading,
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
                              fontSize: 14.0,
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: ListView.separated(
                      physics:
                          ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      itemCount: widget.breakfast.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return DietCard(
                          data: widget.breakfast[index],
                          onMarked: () {
                            DateTime tdate = DateTime.now();
                            final df = DateFormat('dd-MM-yyyy');
                            String today = df.format(tdate).toString();
                            if (today == widget.date) {
                              if (widget.breakfast[index].consumptionStatus) {
                                FlashHelper.informationBar(
                                  context,
                                  message: "Meal already consumed",
                                );
                              } else {
                                _showDialog(null, widget.breakfast[index].uid);
                              }
                            } else {
                              // FlashHelper.informationBar(
                              //   context,
                              //   message:
                              //       "You can only consume the meal for today",
                              // );
                              _showDialog(null, widget.breakfast[index].uid);
                            }
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 1,
                          width: 1,
                          color: Colors.white38,
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

class DietSaverDialog extends StatefulWidget {
  final String uid;
  final String day;
  final String date;

  DietSaverDialog({this.uid, this.day, this.date});

  @override
  _DietSaverDialogState createState() => _DietSaverDialogState();
}

class _DietSaverDialogState extends State<DietSaverDialog> {
  File image;
  String base64Image;
  GymStore store;

  Future pickImage() async {
    try {
      final tempimage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (tempimage == null) return;
      image = File(tempimage.path);
      if (image != null) {
        base64Image = base64Encode(image.readAsBytesSync());
      }
      setState(() {});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 500.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    image == null
                        ? Container(
                            height: 200,
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
                        : ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.file(
                              image,
                              height: 300,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ],
                ),
              ),
              CustomButton(
                textColor: Colors.white,
                bgColor: AppConstants.primaryColor,
                height: 36.0,
                onTap: () {
                  pickImage();
                },
                text: image == null ? "Take a photo" : "Change Photo!",
                textSize: 14.0,
              ),
              image != null
                  ? CustomButton(
                      textColor: Colors.white,
                      bgColor: AppConstants.primaryColor,
                      height: 36.0,
                      onTap: () {
                        DateTime tdate = DateTime.now();
                        final df = DateFormat('dd-MM-yyyy');
                        String today = df.format(tdate).toString();
                        if (today == widget.date) {
                          store
                              .dietConsume(
                                context: context,
                                mealId: widget.uid,
                                date: widget.date,
                                image: base64Image,
                                day: widget.day,
                              )
                              .then(
                                (value) => NavigationService.goBack,
                              );
                        } else {
                          store
                              .dietConsume(
                                context: context,
                                mealId: widget.uid,
                                date: widget.date,
                                image: base64Image,
                                day: widget.day,
                              )
                              .then(
                                (value) => NavigationService.goBack,
                              );
                          // FlashHelper.informationBar(
                          //   context,
                          //   message: "You can't consume it now",
                          // );
                        }
                      },
                      text: 'Submit Diet',
                      textSize: 14.0,
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
