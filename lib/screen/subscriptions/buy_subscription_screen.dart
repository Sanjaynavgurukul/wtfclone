import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/Toast.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/GymOffers.dart';
import 'package:wtf/screen/subscriptions/booking_summary.dart';
import 'package:wtf/widget/app_button.dart';
import 'package:wtf/widget/gradient_image_widget.dart';

class BuySubscriptionScreen extends StatefulWidget {
  @override
  _BuySubscriptionScreenState createState() => _BuySubscriptionScreenState();
}

class _BuySubscriptionScreenState extends State<BuySubscriptionScreen> {
  @override
  void initState() {
    super.initState();
  }

  ScrollController _controller = ScrollController();

  GymStore gymStore;

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
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
                                  Text(gymStore.selectedGymPlan.planName,
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
                                    '\u20B9 ${gymStore.selectedGymPlan.planPrice}',
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

                          initialDate:
                              gymStore.activeSubscriptions.data.expireDate.add(
                            new Duration(days: 1),
                          ),
                          firstDate:
                              gymStore.activeSubscriptions.data.expireDate.add(
                            new Duration(days: 1),
                          ),
                          lastDate:
                              gymStore.activeSubscriptions.data.expireDate.add(
                            new Duration(days: 180),
                          ),
                            builder: (BuildContext context, Widget child) {
                              return getDialogTheme(child);
                            }
                        );
                      } else {
                        date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: new DateTime.now(),
                          lastDate:
                              new DateTime.now().add(new Duration(days: 30)),
                          builder: (BuildContext context, Widget child) {
                            return getDialogTheme(child);
                          }
                        );
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
                SizedBox(
                  height: 25,
                ),
                if (gymStore.selectedGymPlan.planPrice != '0')
                  OfferSection(
                    onApplied: () {
                      setState(() {});
                    },
                  ),
                if (gymStore.selectedGymPlan.planPrice != '0')
                  Consumer<GymStore>(
                    builder: (context, store, child) =>
                        store.chosenOffer != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 18.0,
                                    ),
                                    UIHelper.horizontalSpace(8.0),
                                    Text(
                                      'Coupon Code Applied',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(10.0),
                              ),
                  ),
                Divider(
                  height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                SizedBox(
                  height: 20,
                ),
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

  Theme getDialogTheme(Widget child){
    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.black,//yellow
          onPrimary: Colors.white,
          surface: Colors.grey.shade200,//white
          onSurface: Colors.black,//black
        ),
        dialogBackgroundColor:Colors.white,//white
      ),child: child,
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
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      "Offers available for you",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...store.selectedGymOffer.data
                            .map((e) => OfferCard(
                                  data: e,
                                  onApplied: widget.onApplied,
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}

class OfferCard extends StatefulWidget {
  final OfferData data;
  final bool showDivider;
  final GestureTapCallback onApplied;

  OfferCard({
    this.data,
    this.showDivider = true,
    this.onApplied,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10.0,
          bottom: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/offers.png',
            ),
            UIHelper.horizontalSpace(8.0),
            Expanded(
              flex: 3,
              child: Text(
                widget.data.name,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            UIHelper.horizontalSpace(6.0),
            Expanded(
              flex: 1,
              child: InkWell(
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
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    store.chosenOffer == widget.data ? 'Remove' : 'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            UIHelper.horizontalSpace(10.0),
          ],
        ),
      ),
    );
  }
}
