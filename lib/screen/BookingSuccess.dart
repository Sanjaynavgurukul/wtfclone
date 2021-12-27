import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/slide_button.dart';

class PurchaseDone extends StatelessWidget {
  const PurchaseDone({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.read<GymStore>();
    bool isFromAddon = gymStore.selectedSlotData != null ? true : false;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(
            'Booking Detail',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 100.0,
          child: SlideButton(
            "Let\'s WTF",
            () {
              Navigator.of(NavigationService.navigatorKey.currentContext)
                  .popUntil((route) => route.isFirst);
              NavigationService.navigatorKey.currentContext
                  .read<GymStore>()
                  .init(context: context);
              NavigationService.navigatorKey.currentContext
                  .read<GymStore>()
                  .changeNavigationTab(index: 2);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                UIHelper.verticalSpace(12.0),
                CircleAvatar(
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 50,
                  ),
                  backgroundColor: Colors.green,
                  radius: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Booking successful',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20),
                  child: Consumer<GymStore>(
                    builder: (context, store, child) => Text(
                      isFromAddon
                          ? 'Your ${gymStore.selectedAddOnSlot.name ?? ''} sessions at the ${gymStore.selectedGymDetail.data.gymName ?? ''} is confirmed on ${gymStore.selectedSlotData.startTime}'
                          : 'Your ${gymStore.selectedGymPlan.planName ?? ''} subscription at the ${gymStore.selectedGymDetail.data.gymName ?? ''} is confirmed on ${Helper.formatDate(gymStore.selectedStartingDate.toIso8601String())}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: gymStore.selectedGymPlan != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Booked at:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Flexible(
                                  child: Text(
                                    gymStore.selectedGymDetail.data.gymName,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Membership:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "WTF Arena Membership",
                                  style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Plan:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  gymStore.selectedGymPlan.planName ?? '',
                                  style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Begin Date:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  Helper.stringForDatetime2(gymStore
                                      .selectedStartingDate
                                      .toIso8601String()),
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "End Date:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${Helper.stringForDatetime2(gymStore.selectedStartingDate.add(
                                        Duration(
                                          days: int.tryParse(
                                            gymStore.selectedGymPlan.duration,
                                          ),
                                        ),
                                      ).toIso8601String())}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Booked at:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  gymStore.selectedGymDetail.data.gymName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AddOn :",
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          '${gymStore.selectedAddOnSlot.name} ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                      children: [
                                        if (gymStore.selectedSession != null)
                                          TextSpan(
                                            text:
                                                ' (${gymStore.selectedSession.nSession} Sessions)',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                      ],
                                    ),
                                    textAlign: TextAlign.right,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            if (gymStore.selectedTrainer != null)
                              Divider(
                                thickness: 0.7,
                                color: Colors.white,
                              ),
                            if (gymStore.selectedTrainer != null)
                              SizedBox(height: 4.0),
                            if (gymStore.selectedTrainer != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Trainer :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '${gymStore.selectedTrainer.name} ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                      children: [
                                        // if (gymStore.selectedSession != null)
                                        //   TextSpan(
                                        //     text:
                                        //         ' (${gymStore.selectedSession.nSession} Sessions)',
                                        //     style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 15.0,
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            if (gymStore.selectedTrainer != null)
                              SizedBox(height: 4.0),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Begin Time: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  gymStore.selectedSlotData.startTime,
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Begin Date:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.toIso8601String())}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  gymStore.isFreeSession
                                      ? "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.toIso8601String())}"
                                      : "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.add(
                                            Duration(
                                                days: int.tryParse(gymStore
                                                    .selectedSession.duration)),
                                          ).toIso8601String())}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Divider(
                              thickness: 0.7,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  stepsItem(string) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 3,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                string,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}

class EventPurchaseDone extends StatelessWidget {
  const EventPurchaseDone({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.read<GymStore>();
    return WillPopScope(
      onWillPop: () async {
        gymStore.init(context: context);
        Navigator.of(context).popUntil((route) => route.isFirst);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(
            'Booking Detail',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 110.0,
          child: SlideButton(
            "Let\'s WTF",
            () {
              Navigator.of(NavigationService.navigatorKey.currentContext)
                  .popUntil((route) => route.isFirst);
              NavigationService.navigatorKey.currentContext
                  .read<GymStore>()
                  .init(context: context);
              NavigationService.navigatorKey.currentContext
                  .read<GymStore>()
                  .changeNavigationTab(index: 2);
              // NavigationService.navigateTo(Routes.scheduleSlotPage);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UIHelper.verticalSpace(20.0),
            CircleAvatar(
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 50,
              ),
              backgroundColor: Colors.green,
              radius: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Booking successful',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: Text(
                'You\'ve successfully taken participation in - ${gymStore.selectedEventData.name ?? ''}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event :",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${gymStore.selectedEventData.name}",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Duration:",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${gymStore.selectedEventData.timeFrom} to ${gymStore.selectedEventData.timeTo}',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Date:",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        Helper.stringForDatetime2(
                                gymStore.selectedEventData.date) ??
                            '',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   color: Color(0xff333333),
            //   alignment: Alignment.center,
            //   width: double.maxFinite,
            //   child: Text(
            //     'Steps to unlock your session',
            //     style: TextStyle(
            //       fontSize: 20,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // for (int i = 0; i < 3; i++)
            //   stepsItem(
            //       'Navigate to unlock your booking slider on home screen'),
            // Spacer(),
            // Spacer(),

            Spacer(),
          ],
        ),
      ),
    );
  }

  stepsItem(string) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 3,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                string,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
