import 'package:flutter/material.dart';
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
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/red_clipper.dart';

import '../main.dart';

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
            headerSliverBuilder: (context, _) => [
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ClipPath(
                    clipper: RedClippper(),
                    child: Container(
                      color: AppConstants.primaryColor,
                      height: 40,
                      // height: 140.0,
                    ),
                  ),
                ),
              ),
            ],
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PreferenceBuilder<String>(
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
                        UIHelper.horizontalSpace(12.0),
                        InkWell(
                          onTap: () async {
                            await locator<AppPrefs>().clear();
                            NavigationService.navigateToReplacement(
                                Routes.loader);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Hi ${locator<AppPrefs>().userName.getValue()}',
                                style: TextStyle(
                                  fontFamily: 'VisbyCF-ExtraBold',
                                  fontSize: 24.0,
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
                                  fontSize: 20.0,
                                  color: const Color(0xffe6e6e6),
                                ),
                              ),
                            ],
                          ),
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
                          'My WTF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                  // UIHelper.verticalSpace(20.0),
                  Flexible(
                    child: Container(
                      height: 180.0,
                      margin: const EdgeInsets.only(
                        top: 12.0,
                      ),
                      child: ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (items[index]['name'] ==
                                  'Active Subscriptions') {
                                context.read<GymStore>().getActiveSubscriptions(
                                      context: context,
                                    );
                                if (store.activeSubscriptions != null &&
                                    store.activeSubscriptions.data != null) {
                                  context
                                      .read<GymStore>()
                                      .getActiveSubscriptions(
                                        context: context,
                                      );
                                } else {
                                  Fluttertoast.showToast(
                                    msg:
                                        'You don\'t have any active subscriptions',
                                    fontSize: 14.0,
                                    textColor: Colors.white,
                                    backgroundColor: AppConstants.primaryColor,
                                  );
                                }
                              }
                              NavigationService.navigateTo(
                                  items[index]['screen']);
                            },
                            child: Container(
                              width: 140.0,
                              height: 180.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Stack(
                                children: [
                                  GradientImageWidget(
                                    network: items[index]['image'],
                                  ),
                                  Positioned(
                                    bottom: 10.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Center(
                                      child: Text(
                                        items[index]['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20.0),
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'More Categories',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 24.0,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       UIHelper.horizontalSpace(16.0),
                  //       Expanded(
                  //         child: Container(
                  //           height: 1.0,
                  //           color: Colors.white.withOpacity(0.4),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // UIHelper.verticalSpace(20.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        store.myWorkoutSchedule = null;
                      });
                      NavigationService.navigateTo(Routes.mySchedule);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 220.0,
                      child: Stack(
                        children: [
                          GradientImageWidget(
                            network: Images.mySchedule,
                            boxFit: BoxFit.fill,
                          ),
                          Positioned(
                            bottom: 12.0,
                            left: 0.0,
                            right: 0.0,
                            child: Text(
                              'My Schedule',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
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
