import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/all_events.dart';
import 'package:wtf/widget/ComingSoonWidget.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../main.dart';
import 'DiscoverScreen.dart';
import 'SidebarDrawer.dart';
import 'home/home.dart';
import 'membership_page.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<GymStore>().init(context: context);
        },
        color: AppConstants.primaryColor,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CommonAppBar(),
                  // Container(
                  //   alignment: Alignment.bottomLeft,
                  //   padding: EdgeInsets.only(left: 5),
                  //   child: Text(
                  //     "Search WTF Fitness centers near you",
                  //     textAlign: TextAlign.start,
                  //     style: TextStyle(
                  //       color: Colors.white.withOpacity(0.5),
                  //       fontSize: 12.0,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  // ),
                  // Padding(padding: EdgeInsets.all(8.0)),
                  // Row(
                  //   children: [
                  //     Icon(Icons.edit_location),
                  //     UIHelper.horizontalSpace(8.0),
                  //     Flexible(
                  //       child: Text(
                  //         '${store.currentAddressResult.formattedAddress}',
                  //         maxLines: 2,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SearchBar(),
                  SizedBox(
                    height: 12.0,
                  ),
                  BannerWidget(
                    isExplore: true,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Discover WTF Centers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Explore Arena & Fitness Studios near you',
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                              context.read<GymStore>().getDiscoverNow(
                                    context: context,
                                    type: 'gym',
                                  );
                            } else {
                              context.read<GymStore>().getDiscoverNow(
                                    context: context,
                                    type: 'studio',
                                  );
                            }
                            NavigationService.navigateTo(Routes.discoverNow);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: 120.0,
                            margin: EdgeInsets.only(right: 15),
                            child: Stack(
                              children: [
                                GradientImageWidget(
                                  // assets: 'assets/images/gym_cover.png',
                                  network:
                                      index == 0 ? Images.arena : Images.studio,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                    left: 10,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      index == 0 ? 'Arena' : 'Fitness Studio',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Challenges',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Explore Challenges happening near you.',
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Consumer<GymStore>(
                      builder: (context, store, child) =>
                          store.allChallenges != null
                              ? store.allChallenges.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: store.allChallenges.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return EventCard(
                                          data: store.allChallenges[index],
                                          isChallenge: true,
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        'No Challenges present as of now.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                              : Loading(),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),

                  Text(
                    'Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Explore Events happening near you.',
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    height: 240.0,
                    child: Consumer<GymStore>(
                      builder: (context, store, child) =>
                          store.allEvents != null
                              ? store.allEvents.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: store.allEvents.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return EventCard(
                                          data: store.allEvents[index],
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        'No Upcoming Events present as of now.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                              : Loading(),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Explore more',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Consumer<GymStore>(
                    builder: (context, store, child) => store.allGyms != null
                        ? store.allGyms.data != null &&
                                store.allGyms.data.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) => GymCard(
                                  item: store.allGyms.data[index],
                                ),
                                shrinkWrap: true,
                                itemCount: store.allGyms.data.length,
                                primary: false,
                              )
                            : Center(
                                child: Text(
                                  'Not Available',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                        : Loader(),
                  ),
                  UIHelper.verticalSpace(20.0),
                  ComingSoonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventsData data;
  final bool isChallenge;
  const EventCard({
    Key key,
    this.data,
    this.isChallenge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => InkWell(
        onTap: () {
          store.getEventById(
            context: context,
            eventId: data.uid,
          );
          NavigationService.navigateTo(Routes.eventDetails);
        },
        child: Container(
          width: isChallenge
              ? MediaQuery.of(context).size.width / 2.2
              : MediaQuery.of(context).size.width / 1.6,
          height: MediaQuery.of(context).size.height / 3,
          margin: EdgeInsets.only(right: 15),
          child: Stack(
            children: [
              GradientImageWidget(
                // assets:
                //     'assets/images/challenge.png',
                network: data.image,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    UIHelper.verticalSpace(6.0),
                    Text(
                      data.gymName ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                    UIHelper.verticalSpace(6.0),
                    Text(
                      data.date.contains('-')
                          ? data.date
                          : Helper.stringForDatetimeDT(
                                  DateTime.parse(data.date)) ??
                              '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              if (data.price == '0')
                Positioned(
                  right: 16.0,
                  top: 10.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      'FREE',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              // else
              //   Positioned(
              //     right: 16.0,
              //     top: 10.0,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 8.0,
              //         horizontal: 10.0,
              //       ),
              //       decoration: BoxDecoration(
              //         color: AppConstants.primaryColor,
              //         borderRadius: BorderRadius.circular(12.0),
              //       ),
              //       child: Text(
              //         '₹${data.price}',
              //         style: TextStyle(
              //           fontSize: 10.0,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 12.0,
        top: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UIHelper.horizontalSpace(6.0),
          InkWell(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  // builder: (context) => MyProfileXd(),
                  builder: (context) => SidebarDrawer(),
                ),
              );
            },
            child: PreferenceBuilder<String>(
              preference: locator<AppPrefs>().avatar,
              builder: (context, snapshot) {
                print('user image: $snapshot');
                String img = snapshot;
                if (img.startsWith(
                    'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com')) {
                  img.replaceFirst(
                      'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com',
                      AppConstants.cloudFrontImage);
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      img,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          UIHelper.horizontalSpace(16.0),
          Expanded(
            child: Consumer<GymStore>(
              builder: (context, store, child) => InkWell(
                onTap: () async {
                  // await context
                  //     .read<GymStore>()
                  //     .getActiveSubscriptions(context: context);
                  // if (store.activeSubscriptions != null)
                  //   context.read<GymStore>().getGymDetails(
                  //         context: context,
                  //         gymId: store.activeSubscriptions.data.gymId,
                  //       );
                  // NavigationService.navigateTo(Routes.activeSubscriptionScreen);
                  context.read<GymStore>().getGymDetails(
                        context: context,
                        gymId: store.activeSubscriptions.data.gymId,
                      );
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => BuyMemberShipPage(
                        gymId: store.activeSubscriptions.data.gymId,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PreferenceBuilder<String>(
                        preference: locator<AppPrefs>().userName,
                        builder: (context, name) {
                          return Text(
                            'Hi! ${name.isNotEmpty ? name.capitalize() : ""}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          );
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          children: [
                            if (store.activeSubscriptions == null ||
                                store.activeSubscriptions.data == null)
                              TextSpan(
                                text: ' WTF',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  color: Colors.redAccent,
                                ),
                              )
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (store.activeSubscriptions != null &&
                        store.activeSubscriptions.data != null)
                      Text(
                        store.activeSubscriptions.data.gymName ?? 'n/a',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: Colors.redAccent,
                        ),
                      )
                    // else
                    //   Text(
                    //     'WTF',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w900,
                    //       fontSize: 20.0,
                    //       color: Colors.redAccent,
                    //     ),
                    // ),
                    // RichText(
                    //   overflow: TextOverflow.ellipsis,
                    //   text: TextSpan(
                    //     text: 'Welcome to  \n',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 14.0,
                    //       color: Colors.white,
                    //     ),
                    //     children: [
                    //       if (store.activeSubscriptions != null &&
                    //           store.activeSubscriptions.data != null)
                    //         TextSpan(
                    //           text:
                    //               store.activeSubscriptions.data.gymName ?? 'n/a',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.w900,
                    //             fontSize: 16.0,
                    //             color: Colors.redAccent,
                    //           ),
                    //         )
                    //       else
                    //         TextSpan(
                    //           text: 'WTF',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.w900,
                    //             fontSize: 20.0,
                    //             color: Colors.redAccent,
                    //           ),
                    //         )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          VerticalDivider(
            width: 1.0,
            color: Colors.white,
          ),
          UIHelper.horizontalSpace(10.0),
          PreferenceBuilder<String>(
            preference: locator<AppPrefs>().dateAdded,
            builder: (context, snapshot) {
              return snapshot != null
                  ? Text(
                      // '',
                      'Joined ${Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('hour') || Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('hours') || Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('minutes') || Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('minute') ? 'today' : '\n${Jiffy(snapshot).startOf(Units.DAY).fromNow()}'}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                        color: Colors.white,
                      ),
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
