import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/MemberSubscriptions.dart';
import 'package:wtf/widget/progress_loader.dart';

class MySubscription extends StatefulWidget {
  @override
  _MySubscriptionState createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
          backgroundColor: AppColors.PRIMARY_COLOR,
          appBar: AppBar(
            backgroundColor: AppConstants.primaryColor,
            brightness: Brightness.dark,
            title: Text(
              'My Subscriptions',
              style: AppConstants.customStyle(
                color: Colors.white,
                size: 16.0,
              ),
            ),
            bottom: TabBar(tabs: [
              Tab(
                text: 'Regular',
              ),
              Tab(
                text: 'Addon',
              ),
              Tab(
                text: 'Live',
              ),
              Tab(
                text: 'Event',
              ),
              Tab(
                text: 'PT',
              ),
            ]),
          ),
          body: Consumer<GymStore>(
            builder: (context, store, child) => TabBarView(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<GymStore>()
                        .getMemberSubscriptions(context: context);
                  },
                  backgroundColor: Colors.white,
                  child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: store.regularSubscriptions.length == 0
                          ? 1
                          : store.regularSubscriptions.length,
                      itemBuilder: (context, index) {
                        if (store.regularSubscriptions == null) {
                          return Loading();
                        } else {
                          if (store.regularSubscriptions != null &&
                              store.regularSubscriptions.isNotEmpty) {
                            SubscriptionData e =
                                store.regularSubscriptions[index];
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Gym Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.gymName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'Start Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.startDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .startDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Plan Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.planName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'End Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.expireDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .expireDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // if (e.gymId != null)
                                //   GetGymData(
                                //     id: e.gymId,
                                //   )
                              ],
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              alignment: Alignment.center,
                              child: Text(
                                'No Data Found',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          }
                        }
                      }),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<GymStore>()
                        .getMemberSubscriptions(context: context);
                  },
                  backgroundColor: Colors.white,
                  child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: store.addOnSubscriptions.length == 0
                          ? 1
                          : store.addOnSubscriptions.length,
                      itemBuilder: (context, index) {
                        if (store.addOnSubscriptions == null) {
                          return Loading();
                        } else {
                          if (store.addOnSubscriptions != null &&
                              store.addOnSubscriptions.isNotEmpty) {
                            SubscriptionData e =
                                store.addOnSubscriptions[index];
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Gym Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.gymName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'Start Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.startDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .startDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Addon Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.addonName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'End Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.expireDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .expireDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.0),
                                      if (e.price != 0)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Addon Sessions:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.nSession,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              textAlign: TextAlign.right,
                                              text: TextSpan(
                                                text: 'Completed Session:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.completedSession,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              alignment: Alignment.center,
                              child: Text(
                                'No Addon Found',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          }
                        }
                      }),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<GymStore>()
                        .getMemberSubscriptions(context: context);
                  },
                  backgroundColor: Colors.white,
                  child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: store.addOnLiveSubscriptions.length == 0
                          ? 1
                          : store.addOnLiveSubscriptions.length,
                      itemBuilder: (context, index) {
                        if (store.addOnLiveSubscriptions == null) {
                          return Loading();
                        } else {
                          if (store.addOnLiveSubscriptions != null &&
                              store.addOnLiveSubscriptions.isNotEmpty) {
                            SubscriptionData e =
                                store.addOnLiveSubscriptions[index];
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Gym Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.gymName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'Start Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.startDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .startDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Addon Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.addonName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'End Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.expireDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .expireDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.0),
                                      if (e.price != 0)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Addon Sessions:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.nSession,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              textAlign: TextAlign.right,
                                              text: TextSpan(
                                                text: 'Completed Session:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.completedSession,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              alignment: Alignment.center,
                              child: Text(
                                'No Live class Found',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          }
                        }
                      }),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<GymStore>()
                        .getMemberSubscriptions(context: context);
                  },
                  backgroundColor: Colors.white,
                  child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: store.eventSubscriptions.length == 0
                          ? 1
                          : store.eventSubscriptions.length,
                      itemBuilder: (context, index) {
                        if (store.eventSubscriptions == null) {
                          return Loading();
                        } else {
                          if (store.eventSubscriptions != null &&
                              store.eventSubscriptions.isNotEmpty) {
                            SubscriptionData e =
                                store.eventSubscriptions[index];
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Gym Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.gymName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'Start Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.startDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .startDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Event Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.eventName ?? '',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'End Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.expireDate != null
                                                      ? Helper
                                                          .stringForDatetime2(e
                                                              .expireDate
                                                              .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            alignment: Alignment.center,
                            child: Text(
                              'No Event Found',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }
                      }),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<GymStore>()
                        .getMemberSubscriptions(context: context);
                  },
                  backgroundColor: Colors.white,
                  child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: store.pt.length == 0
                          ? 1
                          : store.pt.length,
                      itemBuilder: (context, index) {
                        if (store.pt == null) {
                          return Loading();
                        } else {
                          if (store.pt != null &&
                              store.pt.isNotEmpty) {
                            SubscriptionData e =
                            store.pt[index];
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  margin:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Gym Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.gymName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'Start Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.startDate != null
                                                      ? Helper
                                                      .stringForDatetime2(e
                                                      .startDate
                                                      .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpace(16.0),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Plan Name:  \n',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 12.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e.planName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: 'End Date:  \n',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 12.0,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: e.expireDate != null
                                                      ? Helper
                                                      .stringForDatetime2(e
                                                      .expireDate
                                                      .toIso8601String())
                                                      : '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // if (e.gymId != null)
                                //   GetGymData(
                                //     id: e.gymId,
                                //   )
                              ],
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              alignment: Alignment.center,
                              child: Text(
                                'No Data Found',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          }
                        }
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
