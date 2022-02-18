import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtf/controller/explore_controller_presenter.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Local_values.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/common_function.dart';
import 'package:wtf/helper/global.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/model/common_model.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/model/gym_plan_model.dart';
import 'package:wtf/model/gym_search_model.dart';
import 'package:wtf/model/gym_slot_model.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/slide_button.dart';
import 'package:wtf/widget/text_field.dart';

import '../../main.dart';

class ScheduleSlotScreen extends StatefulWidget {
  @override
  _ScheduleSlotScreenState createState() => _ScheduleSlotScreenState();
}

class _ScheduleSlotScreenState extends State<ScheduleSlotScreen>
    implements ExploreContract {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController city = TextEditingController();
  ExplorePresenter _presenter;
  GymSlotModel _gymSlotModel;
  bool isLoaded = false;
  int _selectedSlotIndex = 0;
  int _radioValue = 0;

  bool isEmailValid = false;
  bool isNameValid = false;
  bool isNumberValid = false;

  List<String> scheduleTiming = [
    "9-10 am",
    "10-11 am",
    "11-12 am",
    "12-13 pm",
    "13-14 pm"
  ];

  @override
  void initState() {
    name.text = locator<AppPrefs>().userName.getValue();
    email.text = locator<AppPrefs>().userEmail.getValue();
    mobile.text = locator<AppPrefs>().phoneNumber.getValue();
    super.initState();
    _presenter = new ExplorePresenter(this);

    getGymSlot('');
  }

  @override
  Widget build(BuildContext context) {
    // var selectedSlot = _gymSlotModel.data[_selectedSlotIndex];
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SafeArea(
        child: !isLoaded
            ? LoadingWithBackground()
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Western Dance",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Padding(padding: EdgeInsets.all(8.0)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0.0, bottom: 0.0, left: 17),
                                    hintText: 'Select Preffered Batch',
                                    hintStyle: TextStyle(
                                        color: Colors.white70, fontSize: 15),
                                    suffixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(50.0))),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 7,
                      ),

                      // Date picker
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "2-8 August 2021",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            timingRowWidget("Mon"),
                            timingRowWidget("Tue"),
                            timingRowWidget("Wed"),
                            timingRowWidget("Thu"),
                            timingRowWidget("Fri"),
                            timingRowWidget("Sat"),
                            timingRowWidget("Sun"),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Selected Slot",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Start Time:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "${_gymSlotModel.data[_selectedSlotIndex].startTime}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "End Time:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "${_gymSlotModel.data[_selectedSlotIndex].endTime}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Trainer:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        "${_gymSlotModel.data[_selectedSlotIndex].trainerId}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // Date picker
                      SizedBox(height: 25),

                      // Book Session Column
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            color: Colors.grey[800],
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Book Session',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  Icon(
                                    Icons.keyboard_arrow_up_sharp,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                UnderlineTextField(
                                  inputFormatters: [Global.amountValidator],
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  hintText: 'Enter Name',
                                  controller: name,
                                  preffixIcon: Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                UnderlineTextField(
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  hintText: 'E-mail',
                                  controller: email,
                                  preffixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter E-mail';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    if (value.isEmpty || value == null) {
                                      isEmailValid = false;
                                    } else if (!Global.validateEmail(value)) {
                                      isEmailValid = false;
                                    } else {
                                      isEmailValid = true;
                                    }
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                UnderlineTextField(
                                  inputFormatters: [
                                    Global.amountValidator,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  fontFamily: Fonts.ROBOTO,
                                  hintText: 'Mobile No.',
                                  controller: mobile,
                                  preffixIcon: Icon(
                                    Icons.mobile_friendly,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Mobile No.';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    Colors.white),
                                            child: Radio(
                                              value: 0,
                                              activeColor: Colors.white,
                                              groupValue: _radioValue,
                                              onChanged: (val) {
                                                setState(() {
                                                  _radioValue = val;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            "Male",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    Colors.white),
                                            child: Radio(
                                              value: 1,
                                              activeColor: Colors.white,
                                              groupValue: _radioValue,
                                              onChanged: (val) {
                                                setState(() {
                                                  _radioValue = val;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            "Female",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Enter Address",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                UnderlineTextField(
                                  inputFormatters: [Global.amountValidator],
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  hintText: 'Address',
                                  controller: address,
                                  preffixIcon: Icon(
                                    Icons.home_outlined,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Address';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                UnderlineTextField(
                                  inputFormatters: [Global.amountValidator],
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  hintText: 'Locality',
                                  controller: locality,
                                  preffixIcon: Icon(
                                    Icons.location_city_outlined,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Locality';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                UnderlineTextField(
                                  inputFormatters: [Global.amountValidator],
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  fontFamily: Fonts.ROBOTO,
                                  hintText: 'Pincode',
                                  controller: pinCode,
                                  preffixIcon: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Pincode';
                                    }
                                    return null;
                                  },
                                ),
                                UnderlineTextField(
                                  inputFormatters: [Global.amountValidator],
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  hintText: 'City',
                                  controller: city,
                                  preffixIcon: Icon(
                                    Icons.location_city_outlined,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter City';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Book Session Column
                      SizedBox(
                        height: 30,
                      ),
                      // Buy memberShip button
                      SlideButton("Proceed to buy", () {
                        LocalValue.SLOT_ID =
                            _gymSlotModel.data[_selectedSlotIndex].uid;
                        print("Slot id is ${LocalValue.SLOT_ID}");
                        NavigationService.navigateTo(Routes.membershipPlanPage);
                      }),

                      // Buy memberShip button
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Padding timingRowWidget(String day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          // SizedBox(
          //   width: 8,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: scheduleTiming.map((e) {
              return Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black),
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  @override
  void onGetGymDetailsSuccess(GymDetailsModel model) {
    // TODO: implement onGetGymDetailsSuccess
  }

  @override
  void onGetGymError(Object errorTxt) {
    if (errorTxt is String) {
      CommonFunction.showToast(errorTxt);
    } else if (errorTxt is GymModel) {
      CommonFunction.showToast(errorTxt.message);
    }
    CommonFunction.showToast(errorTxt);
  }

  @override
  void onGymSlotSuccess(GymSlotModel model) {
    if (model != null && model.status) {
      setState(() {
        _gymSlotModel = model;
        isLoaded = true;
      });
    } else {
      CommonFunction.showToast(model.message);
    }
  }

  Future<void> getGymSlot(String gymId) async {
    // CommonFunction.showProgressDialog(context);
    print("get Gym Plan 0");
    await _presenter.getGymSlots(gymId);
  }

  @override
  void onGetGymSuccess(GymModel model) {
    // TODO: implement onGetGymSuccess
  }

  @override
  void onGymPlansSuccess(GymPlanModel model) {
    // TODO: implement onGymPlansSuccess
  }

  @override
  void onsearchGymSuccess(GymSearchModel model) {
    // TODO: implement onsearchGymSuccess
  }

  @override
  void onAddSubscriptionSuccess(CommonModel model) {
    // TODO: implement onAddSubscriptionSuccess
  }
}
