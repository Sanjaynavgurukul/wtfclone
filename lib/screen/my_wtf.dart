import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/SidebarDrawer.dart';

import '../main.dart';
import 'body_calculator/body_calculator.dart';

class MyWtf extends StatefulWidget {
  @override
  _MyWtfState createState() => _MyWtfState();
}

class _MyWtfState extends State<MyWtf> {
  List<Map<String, dynamic>> items = [
    {
      'name': 'My Stats',
      'image': Images.myStats,
      'screen': Routes.myStats,
    },
    {
      'name': 'Body Statistics',
      'image': Images.bodyCalculator,
      'screen': Routes.bodyCalculator,
    },
    {
      'name': 'Active Subscriptions',
      'image': Images.activeSubscription,
      'screen': Routes.activeSubscriptionScreen,
    },
    // {
    //   'name': 'My Schedule',
    //   'image': Images.mySchedule,
    // },
  ];
  GymStore store;
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) => [],
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 8.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SidebarDrawer(),
                              ),
                            );
                          },
                          child: PreferenceBuilder<String>(
                            preference: locator<AppPrefs>().avatar,
                            builder: (context, snapshot) {
                              return Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                    snapshot,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        UIHelper.horizontalSpace(12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hi ${locator<AppPrefs>().userName.getValue()}',
                              style: TextStyle(
                                fontFamily: 'VisbyCF-ExtraBold',
                                fontSize: 20.0,
                                color: const Color(0xffe6e6e6),
                                height: 1.2000000211927626,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Welcome Back !",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14.0,
                                color: const Color(0xffe6e6e6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'My',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        UIHelper.horizontalSpace(4.0),
                        Image.asset('assets/images/wtf_2.png'),
                        UIHelper.horizontalSpace(16.0),
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(30.0),
                  MyWtfCard(
                    onTap: () {
                      setState(() {
                        store.myWorkoutSchedule = null;
                      });
                      NavigationService.navigateTo(Routes.mySchedule);
                    },
                    image: 'schedule',
                    text: 'My Schedule',
                  ),
                  UIHelper.verticalSpace(20.0),
                  MyWtfCard(
                    onTap: () {
                      NavigationService.navigateTo(Routes.myStats);
                    },
                    image: 'stats',
                    text: 'My Stats    ',
                  ),
                  UIHelper.verticalSpace(35.0),
                  Text(
                    'Fitness Calculators',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpace(25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OpenCalButon(
                        onTap: () {
                          NavigationService.navigateTo(Routes.bodyFatCal);
                        },
                        label: 'Body Fat %',
                        image: 'bodyFat',
                      ),
                      OpenCalButon(
                        onTap: () {
                          NavigationService.navigateTo(Routes.bmrCalculator);
                        },
                        label: 'Calorie Burnt',
                        image: 'cal',
                      ),
                      OpenCalButon(
                        onTap: () {
                          NavigationService.navigateTo(Routes.calorieCounter);
                        },
                        label: 'Calorie Required',
                        image: 'cal_req',
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(25.0),
                  MyWtfSubscriptionCard(
                    onTap: () async {
                      await context.read<GymStore>().getActiveSubscriptions(
                            context: context,
                          );
                      if (store.activeSubscriptions != null &&
                          store.activeSubscriptions.data != null) {
                        context.read<GymStore>().getActiveSubscriptions(
                              context: context,
                            );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'You don\'t have any active subscriptions',
                          fontSize: 14.0,
                          textColor: Colors.white,
                          backgroundColor: AppConstants.primaryColor,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyWtfCard extends StatelessWidget {
  final String text, image;
  final GestureTapCallback onTap;
  const MyWtfCard({
    Key key,
    this.text,
    this.onTap,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: AppConstants.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/$image.svg'),
            UIHelper.horizontalSpace(20.0),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWtfSubscriptionCard extends StatelessWidget {
  final GestureTapCallback onTap;
  const MyWtfSubscriptionCard({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = context.watch<GymStore>();
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: AppConstants.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/active.svg',
              color: AppConstants.white,
              height: 36.0,
            ),
            UIHelper.horizontalSpace(20.0),
            if (!store.activeSubscriptions.data.startDate
                .isAfter(DateTime.now()))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Subscription : ${store.activeSubscriptions.data.planName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.0,
                      color: const Color(0xffe6e6e6),
                    ),
                  ),
                  UIHelper.verticalSpace(4.0),
                  Text(
                    " ${store.activeSubscriptions.data.expireDate.difference(DateTime.now()).inDays} days left",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.0,
                      color: const Color(0xffe6e6e6),
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Active",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.0,
                      color: const Color(0xffe6e6e6),
                    ),
                  ),
                  UIHelper.verticalSpace(4.0),
                  Text(
                    "Subscription Found",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.0,
                      color: const Color(0xffe6e6e6),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
