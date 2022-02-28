import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/Toast.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/GymOffers.dart';
import 'package:wtf/screen/common_widgets/time_line.dart';
import 'package:wtf/screen/gym/arguments/plan_page_argument.dart';
import 'package:wtf/screen/gym/gym_membership_plan_page.dart';
import 'package:wtf/screen/subscriptions/booking_summary.dart';
import 'package:wtf/widget/app_button.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/slide_button.dart';

class BuySubscriptionScreen extends StatefulWidget {
  @override
  _BuySubscriptionScreenState createState() => _BuySubscriptionScreenState();
}

class _BuySubscriptionScreenState extends State<BuySubscriptionScreen> {
  bool show = false;
  bool scrollOrNot = true;
  final bool isPreview = false;
  ScrollController _controller = ScrollController();
  GymStore gymStore;
  PlanColor _planColor;

  @override
  void initState() {
    super.initState();
    //Extracting argument
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final PlanPageArgument args =
    //   ModalRoute.of(context).settings.arguments as PlanPageArgument;
    //   _planColor = args.planColor;
    // });
  }

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
    final PlanPageArgument args =
        ModalRoute.of(context).settings.arguments as PlanPageArgument;
    _planColor = args.planColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
        constraints: BoxConstraints(minHeight: 54, maxHeight: 60),
        child: InkWell(
          onTap: () async {
            if (gymStore.selectedStartingDate != null) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => BookingSummaryScreen(),
                ),
              );
            } else {
              Toast(
                text: 'Please select a date first',
                textColor: Colors.red,
                bgColor: Colors.white,
                textFontSize: 14.0,
              ).showDialog(context);
            }
          },
          child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff490000),
                      Color(0xffBA1406),
                    ],
                  )),
              alignment: Alignment.center,
              child: Text('Buy Now')),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 260,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    'https://assets.fullertonindia.com/sites/default/files/How-to-finance-home-gym.jpg?bsd.MqIzJ7ikD8x6oF6zSSnuhJe_GU_7',
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                          Colors.transparent,
                          AppColors.PRIMARY_COLOR
                        ])),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12, left: 6, right: 0),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 12, right: 0, bottom: 0),
                          title: Text('${gymStore.selectedGymDetail.data.gymName}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w600)),
                          subtitle: Text('${gymStore.selectedGymDetail.data.address1} ${gymStore.selectedGymDetail.data.address2}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                          // trailing: Container(
                          //   padding: EdgeInsets.only(left: 12, right: 12),
                          //   constraints: BoxConstraints(
                          //     minWidth: 70,maxWidth: 120
                          //   ),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(8),
                          //       ),
                          //       gradient: LinearGradient(
                          //           begin: FractionalOffset.topLeft,
                          //           end: FractionalOffset.bottomRight,
                          //           colors: [
                          //             Color(0xff438373),
                          //             Color(0xff3E74B4)
                          //           ])),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Image.asset(
                          //             'assets/logo/wtf_light.png',
                          //             width: 40,
                          //             height: 40,
                          //           ),
                          //           SizedBox(
                          //             width: 8,
                          //           ),
                          //           Text('Lifestyle',
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w800))
                          //         ],
                          //       ),
                          //       Text('Includes Unlimited Arena Access',
                          //           maxLines: 2,
                          //           style: TextStyle(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w600))
                          //     ],
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [_planColor.leftColor, _planColor.rightColor])),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/logo/wtf_light.png',
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                      subtitle: Text(
                          '${gymStore.selectedGymPlan.plan_name ?? ''}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                    // child: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Image.asset(
                    //       'assets/logo/wtf_light.png',
                    //       width: 50,
                    //       height: 50,
                    //     ),
                    //     SizedBox(
                    //       width: 6,
                    //     ),
                    //     Text('${gymStore.selectedGymPlan.planName??''}',
                    //         style: TextStyle(
                    //             fontSize: 24,
                    //             fontWeight: FontWeight.w800,
                    //             color: _planColor.rightColor))
                    //   ],
                    // ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Include Unlimited Arena Access',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w400)),
                  )
                ],
              ),
              // child: ListTile(
              //   title: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Image.asset(
              //         'assets/logo/wtf_light.png',
              //         width: 50,
              //         height: 50,
              //       ),
              //       SizedBox(
              //         width: 6,
              //       ),
              //       Text('Lifestyle')
              //     ],
              //   ),
              //   subtitle: Text('Include Unlimited Arena Access'),
              // ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      if (gymStore.isRenew)
                        print(
                            'Expire Date: ${gymStore.activeSubscriptions.data.expireDate}');
                      DateTime date;
                      if (gymStore.isRenew) {
                        date = await showDatePicker(
                            context: context,
                            initialDate: gymStore
                                .activeSubscriptions.data.expireDate
                                .add(
                              new Duration(days: 1),
                            ),
                            firstDate: gymStore
                                .activeSubscriptions.data.expireDate
                                .add(
                              new Duration(days: 1),
                            ),
                            lastDate: gymStore
                                .activeSubscriptions.data.expireDate
                                .add(
                              new Duration(days: 180),
                            ),
                            builder: (BuildContext context, Widget child) {
                              return getDialogTheme(child);
                            });
                      } else {
                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: new DateTime.now(),
                            lastDate:
                                new DateTime.now().add(new Duration(days: 30)),
                            builder: (BuildContext context, Widget child) {
                              return getDialogTheme(child);
                            });
                      }
                      if (date != null) {
                        context.read<GymStore>().selectedStartingDate = date;
                        context
                            .read<GymStore>()
                            .setStartDate(context: context, dateTime: date);
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppConstants.bgColor),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                              left: 16, right: 16, top: 7, bottom: 7),
                          dense: true,
                          title: Text('Choose Your starting date',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          subtitle: gymStore.selectedStartingDate != null
                              ? Text(DateFormat('yyyy-MM-dd')
                                  .format(gymStore.selectedStartingDate))
                              : null,
                          trailing: Icon(Icons.date_range),
                        )
                        // child: Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text('Choose Your starting date',
                        //         style: TextStyle(
                        //             fontSize: 16, fontWeight: FontWeight.w400)),
                        //     SizedBox(
                        //       width: 8,
                        //     ),
                        //     Icon(Icons.date_range)
                        //   ],
                        // ),
                        ),
                  ),
                  SizedBox(height: 34),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Offers Available for you',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(height: 24),
                  OfferSection(),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('How it works?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(height: 18),
                  howItsWork()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget newUi() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
        constraints: BoxConstraints(minHeight: 54, maxHeight: 60),
        child: InkWell(
          onTap: () async {},
          child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff490000),
                      Color(0xffBA1406),
                    ],
                  )),
              alignment: Alignment.center,
              child: Text('Buy Now')),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    'https://assets.fullertonindia.com/sites/default/files/How-to-finance-home-gym.jpg?bsd.MqIzJ7ikD8x6oF6zSSnuhJe_GU_7',
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                          Colors.transparent,
                          AppColors.PRIMARY_COLOR
                        ])),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12, left: 6, right: 0),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 12, right: 0, bottom: 0),
                          title: Text('Mass Monster'),
                          subtitle: Text('Noida Sector 8 C Bloc',
                              style: TextStyle(color: Colors.white)),
                          // trailing: Container(
                          //   padding: EdgeInsets.only(left: 12, right: 12),
                          //   constraints: BoxConstraints(
                          //     minWidth: 70,maxWidth: 120
                          //   ),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(8),
                          //       ),
                          //       gradient: LinearGradient(
                          //           begin: FractionalOffset.topLeft,
                          //           end: FractionalOffset.bottomRight,
                          //           colors: [
                          //             Color(0xff438373),
                          //             Color(0xff3E74B4)
                          //           ])),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Image.asset(
                          //             'assets/logo/wtf_light.png',
                          //             width: 40,
                          //             height: 40,
                          //           ),
                          //           SizedBox(
                          //             width: 8,
                          //           ),
                          //           Text('Lifestyle',
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w800))
                          //         ],
                          //       ),
                          //       Text('Includes Unlimited Arena Access',
                          //           maxLines: 2,
                          //           style: TextStyle(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w600))
                          //     ],
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppConstants.bgColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Choose Your starting date',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.date_range)
                      ],
                    ),
                  ),
                  SizedBox(height: 34),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Offers Available for you',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                        color: AppConstants.cardBg2,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(12),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return offerItem();
                        }),
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('How it works?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(height: 18),
                  howItsWork()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget offerItem() {
    return ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(0),
        title: Text(
          '20% off for 1 month',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        trailing: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Color(0xffBA1406),
          ),
          child: Text('Apply'),
        ),
        leading: Transform.rotate(
          angle: 80 * pi / -100,
          child: Icon(Icons.label),
        ));
  }

  Widget oldUI() {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 55),
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      GradientImageWidget(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11),
                            topRight: Radius.circular(11)),
                        gragientColor: [
                          Colors.transparent,
                          AppColors.PRIMARY_COLOR,
                          AppColors.PRIMARY_COLOR,
                          // AppColors.PRIMARY_COLOR,
                        ],
                        stops: [0.0, 0.81, 1.0],
                        network: gymStore.selectedGymPlan.image,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 0, left: 10, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(gymStore.selectedGymPlan.plan_name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  // Text(widget.selectedGymPlanModel.gymId,
                                  //     style: TextStyle(
                                  //         color: Colors.grey,
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '\u20B9 ${gymStore.selectedGymPlan.plan_price}',
                                    style: TextStyle(
                                      color: AppConstants.red,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Includes unlimited WTF arena access',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Text('Live Classes Access',
                                  //     style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 10,
                                  //         fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (gymStore.isRenew)
                        print(
                            'Expire Date: ${gymStore.activeSubscriptions.data.expireDate}');
                      DateTime date;
                      if (gymStore.isRenew) {
                        date = await showDatePicker(
                            context: context,
                            initialDate: gymStore
                                .activeSubscriptions.data.expireDate
                                .add(
                              new Duration(days: 1),
                            ),
                            firstDate: gymStore
                                .activeSubscriptions.data.expireDate
                                .add(
                              new Duration(days: 1),
                            ),
                            lastDate: gymStore
                                .activeSubscriptions.data.expireDate
                                .add(
                              new Duration(days: 180),
                            ),
                            builder: (BuildContext context, Widget child) {
                              return getDialogTheme(child);
                            });
                      } else {
                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: new DateTime.now(),
                            lastDate:
                                new DateTime.now().add(new Duration(days: 30)),
                            builder: (BuildContext context, Widget child) {
                              return getDialogTheme(child);
                            });
                      }
                      if (date != null) {
                        context.read<GymStore>().selectedStartingDate = date;
                        context
                            .read<GymStore>()
                            .setStartDate(context: context, dateTime: date);
                      }
                    },
                    child: IntrinsicWidth(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        width: MediaQuery.of(context).size.width - 24.0,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                if (gymStore.selectedStartingDate != null)
                                  Text(
                                    'Begin Date will be',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                Text(
                                  gymStore.selectedStartingDate == null
                                      ? 'Pick a Start Date'
                                      : Helper.stringForDatetime2(
                                          gymStore.selectedStartingDate
                                              .toIso8601String(),
                                        ),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.horizontalSpace(12.0),
                            Icon(
                              Icons.date_range,
                              color: Colors.red,
                              size: 37,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                // SizedBox(
                //   height: 25,
                // ),
                // if (gymStore.selectedGymPlan.planPrice != '0')
                //   OfferSection(
                //     onApplied: () {
                //       setState(() {});
                //     },
                //   ),
                // if (gymStore.selectedGymPlan.planPrice != '0')
                //   Consumer<GymStore>(
                //     builder: (context, store, child) =>
                //         store.chosenOffer != null
                //             ? Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                   horizontal: 6.0,
                //                   vertical: 12.0,
                //                 ),
                //                 child: Row(
                //                   children: [
                //                     Icon(
                //                       Icons.check,
                //                       color: Colors.green,
                //                       size: 18.0,
                //                     ),
                //                     UIHelper.horizontalSpace(8.0),
                //                     Text(
                //                       'Coupon Code Applied',
                //                       style: TextStyle(
                //                         color: Colors.green,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               )
                //             : Container(
                //                 padding: const EdgeInsets.all(10.0),
                //               ),
                //   ),
                // Divider(
                //   height: 0.0,
                //   color: Colors.white38,
                //   thickness: 0.4,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       InkWell(
                //         onTap: () async {
                //           DateTime date = await showDatePicker(
                //             context: context,
                //             initialDate: DateTime.now(),
                //             firstDate: new DateTime.now(),
                //             lastDate:
                //                 new DateTime.now().add(new Duration(days: 30)),
                //           );
                //           if (date != null) {
                //             context.read<GymStore>().selectedStartingDate =
                //                 date;
                //             context
                //                 .read<GymStore>()
                //                 .setStartDate(context: context, dateTime: date);
                //           }
                //         },
                //         child: Container(
                //           padding:
                //               EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(8)),
                //           child: Column(
                //             mainAxisSize: MainAxisSize.min,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             // crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 gymStore.selectedStartingDate == null
                //                     ? 'Pick a Start Date'
                //                     : 'Begin Date will be',
                //                 style: TextStyle(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w900,
                //                   fontSize: 15.0,
                //                 ),
                //               ),
                //               Text(
                //                 gymStore.selectedStartingDate == null
                //                     ? 'Starting from 999/per month'
                //                     : Helper.stringForDatetime(
                //                         gymStore.selectedStartingDate
                //                             .toIso8601String(),
                //                       ),
                //                 style: TextStyle(
                //                   color: Colors.black,
                //                   // fontWeight: FontWeight.bold,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 15,
                //       ),
                //       Container(
                //         padding: EdgeInsets.all(1),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(6),
                //             color: Colors.white),
                //         child: Container(
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(6),
                //               color: Colors.black),
                //           padding:
                //               EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                //           child: Center(
                //             child: Text(
                //               "Details",
                //               style: TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.red),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Divider(
                //   height: 0.0,
                //   color: Colors.white38,
                //   thickness: 0.4,
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How its works",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "1. Pick membership start date and completer your subscription process by clicking Buy now below.",
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        // height: 0.0,
                        color: Colors.white38,
                        thickness: 0.4,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "2. A dedicated General Trainer will be assigned after you have taken your subscription.",
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        // height: 0.0,
                        color: Colors.white38,
                        thickness: 0.4,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "3. Explore WTF and start your fitness journey.",
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider(
                        // height: 0.0,
                        color: Colors.white38,
                        thickness: 0.4,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: AppOutlineButton(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    fontSize: 16,
                    textColor: Colors.red,
                    label: 'Buy Now',
                    color: Colors.white,
                    onPressed: () async {
                      if (gymStore.selectedStartingDate != null) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => BookingSummaryScreen(),
                          ),
                        );
                      } else {
                        Toast(
                          text: 'Please select a date first',
                          textColor: Colors.red,
                          bgColor: Colors.white,
                          textFontSize: 14.0,
                        ).showDialog(context);
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Theme getDialogTheme(Widget child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: AppConstants.primaryColor, //yellow
          onPrimary: Colors.white,
          surface: Colors.grey.shade200, //white
          onSurface: AppConstants.primaryColor, //black
        ),
        dialogBackgroundColor: Colors.white, //white
      ),
      child: child,
    );
  }

  Widget howItsWork() {
    return Container(
      child: Timeline(
        padding: EdgeInsets.all(0),
        lineColor: AppConstants.boxBorderColor,
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/images/calender.png',
              width: 40,
              height: 40,
            ),
            title: Text(
                'Pick membership start ddate and complete your subscription process by clicking Buy Now below.',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/person.png',
              width: 40,
              height: 40,
            ),
            title: Text(
                'A dedicated general trainer will be assigned after you have taken your subscription.',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/dumble.png',
              width: 40,
              height: 40,
            ),
            title: Text('Explore WTF and start your fitness journey.',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
          ),
        ],
        indicators: <Widget>[
          Icon(
            Icons.circle,
            color: Colors.white,
            size: 12,
          ),
          Icon(
            Icons.circle,
            color: Colors.white,
            size: 12,
          ),
          Icon(
            Icons.circle,
            color: Colors.white,
            size: 12,
          ),
        ],
      ),
    );
  }
}

class OfferSection extends StatefulWidget {
  final String gymId;
  final GestureTapCallback onApplied;

  OfferSection({
    this.gymId,
    this.onApplied,
  });

  @override
  _OfferSectionState createState() => _OfferSectionState();
}

class _OfferSectionState extends State<OfferSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => store.selectedGymOffer != null &&
              store.selectedGymOffer.data != null &&
              store.selectedGymOffer.data.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                  color: AppConstants.cardBg2,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: EdgeInsets.only(left: 12, right: 12),
              child: filterData(store.selectedGymOffer.data).isNotEmpty ? ListView.builder(
                  itemCount: filterData(store.selectedGymOffer.data).length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    OfferData d = filterData(store.selectedGymOffer.data)[index];
                    return OfferCard(data: d,onApplied: widget.onApplied);
                  }):Container(
                decoration: BoxDecoration(
                    color: AppConstants.cardBg2,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Center(child: Text('No Offer Available')),
              )
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     // ...store.selectedGymOffer.data
              //     //     .map((e){
              //     //       if(e.status == 'active'){
              //     //         OfferCard(
              //     //           data: e,
              //     //           onApplied: widget.onApplied,
              //     //         );
              //     //       }
              //     // })
              //     //     .toList()??Container(
              //     //   decoration: BoxDecoration(
              //     //       color: AppConstants.cardBg2,
              //     //       borderRadius: BorderRadius.all(Radius.circular(12))),
              //     //   padding: EdgeInsets.only(left: 12, right: 12),
              //     //   child: Center(child: Text('No Offer Available')),
              //     // ),
              //   ],
              // ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: AppConstants.cardBg2,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Center(child: Text('No Offer Available')),
            ),
    );
  }

  List<OfferData> filterData(List<OfferData> data){
    // return data.forEach((element) =>element.status =='active').toList();
    return data.where((element) => element.status == 'active').toList();
  }

}

class OfferCard extends StatefulWidget {
  final OfferData data;
  final GestureTapCallback onApplied;

  OfferCard({
    this.data,
    this.onApplied,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            '${widget.data.name ?? 'No Title'}',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          trailing: InkWell(
            onTap: () async {
              if (store.chosenOffer != null &&
                  store.chosenOffer == widget.data) {
                await store.setOffer(context: context, data: null);
                widget.onApplied();
              } else {
                await store.setOffer(context: context, data: widget.data);
                widget.onApplied();
              }
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Color(0xffBA1406),
              ),
              child: Text(
                store.chosenOffer == widget.data ? 'Remove' : 'Apply',
              ),
            ),
          ),
          leading: Transform.rotate(
            angle: 80 * pi / -100,
            child: Icon(Icons.label),
          )),
    );
  }
}
