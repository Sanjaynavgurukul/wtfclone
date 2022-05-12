import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:wtf/100ms/main.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/MemberSubscriptions.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/screen/common_widgets/common_banner.dart';
import 'package:wtf/screen/home/categories.dart';
import 'package:wtf/screen/home/upcoming_events.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/custom_expansion_tile.dart';
import 'package:wtf/widget/progress_loader.dart';
import '../ExplorePage.dart';
import '../event/EventDetails.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  bool abc = false;
  bool abc2 = false;
  // StopWatchTimer _stopWatchTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _stopWatchTimer = StopWatchTimer(
    //   presetMillisecond: exTimerHelper.convertMil(false),
    //   mode: StopWatchMode.countUp,
    // );
    //
    // if (globalTimerIsOn()) {
    //   startTimer();
    // }
  }

  // void startTimer() {
  //   _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  // }

  bool globalTimerIsOn() {
    bool isWorkoutOn = locator<AppPrefs>().exerciseOn.getValue();
    return isWorkoutOn;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    checkVersionCode();

    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async{
      //     await store.getPermissions();
      //     store.navigateTo100MsPreview(context: context, token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3Nfa2V5IjoiNjIzYzA5NDI0NGFlMDRiNTFjYjA2NTdmIiwicm9vbV9pZCI6IjYyNzRmYzM5ZmY2ODhjMDM3YTM4YjE1ZCIsInVzZXJfaWQiOiJjbmRzem10biIsInJvbGUiOiJndWVzdCIsImp0aSI6ImMyM2M0YWE3LTY1YjAtNDdkNS04NjA1LTc2YTBmNzhjY2EwOCIsInR5cGUiOiJhcHAiLCJ2ZXJzaW9uIjoyLCJleHAiOjE2NTE5MjcwNDh9.y9-F5tsIVD-e27zM9y5Cve_Z4dMIMIaNmNDT2wLTVnw');
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GymStore>().init(context: context);
        },
        color: AppConstants.primaryColor,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (globalTimerIsOn())
              //   StreamBuilder<int>(
              //       stream: _stopWatchTimer.secondTime,
              //       initialData: _stopWatchTimer.secondTime.value,
              //       builder: (context, snap) {
              //         int value = snap.data;
              //         return ListTile(
              //           title: Text('Workout on',textAlign: TextAlign.center,),
              //           subtitle: Text(
              //             '${exTimerHelper.convertHour(value)}:${exTimerHelper.convertMin(value)}:${exTimerHelper.convertSec(value)}'
              //               ,textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 color: AppConstants.bgColor,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //           trailing: Icon(Icons.navigate_next_sharp),
              //         );
              //       }),
              CommonBanner(
                bannerType: "FC_banner",
                second_banner_pref: 'WTF_banner',
                fraction: 1,
                height: 400,
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  // new AnimatedContainer(
                  //   duration: const Duration(milliseconds: 860),
                  //   child: new Container(
                  //     margin: EdgeInsets.all(6),
                  //     child: ExpansionTileCard(
                  //       baseColor: Colors.cyan[50],
                  //       title: Text('My\nSchedule'),
                  //       onExpansionChanged: (value){
                  //         setState(() {
                  //           if(!value){
                  //             leftExpanded = true;
                  //             rightCardWidth2 = 0;
                  //             leftCardWidth2 = (leftCardWidth)*2;
                  //             // leftCardWidth2 = (leftCardWidth) * 2;
                  //           } else {
                  //             leftExpanded = false;
                  //             leftCardWidth2 = leftCardWidth;
                  //             rightCardWidth2 = rightCardWidth;
                  //             // leftCardWidth2 = (leftCardWidth) * 2;
                  //           }
                  //         });
                  //       },
                  //     )
                  //   ),
                  //   height: leftCardWidth,
                  //   width:  leftExpanded?leftCardWidth2 :leftCardWidth,
                  // ),
                  // new AnimatedContainer(
                  //   duration: const Duration(milliseconds: 860),
                  //   child: new Container(
                  //       margin: EdgeInsets.all(6),
                  //       child: ExpansionTileCard(
                  //         baseColor: Colors.cyan[50],
                  //         title: Text('My\nSchedule'),
                  //         onExpansionChanged: (value){
                  //           setState(() {
                  //             if(!value){
                  //               rightExpanded = true;
                  //               leftCardWidth = 0;
                  //               rightCardWidth2 = (rightCardWidth)*2;
                  //               // leftCardWidth2 = (leftCardWidth) * 2;
                  //             } else {
                  //               rightExpanded = false;
                  //               rightCardWidth2 = rightCardWidth;
                  //               leftCardWidth = rightCardWidth;
                  //               // leftCardWidth2 = (leftCardWidth) * 2;
                  //             }
                  //           });
                  //         },
                  //       )
                  //   ),
                  //   height: rightCardWidth,
                  //   width:  rightExpanded?rightCardWidth2 :rightCardWidth,
                  // ),
                  if (!abc &&
                      store.mySchedule != null &&
                      store.mySchedule.data != null &&
                      store.mySchedule.data.hasData())
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(6),
                        child: ExpansionTileCard(
                          key: cardA,
                          baseColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 6, bottom: 6),
                          expandedColor: Colors.white,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 6,
                              ),
                              Image.asset(
                                'assets/gif/my_schedule.gif',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              store.upcomingEvents != null &&
                                      store.upcomingEvents.data.isNotEmpty
                                  ? Expanded(
                                      child: ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text('My Schedule',
                                            maxLines: 2,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    )
                                  : Text('My Schedule',
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black))
                            ],
                          ),
                          onExpansionChanged: (v) {
                            setState(() {
                              abc2 = v;
                            });
                          },
                          children: [
                            TodayScheduleCard()
                            // Container(
                            //   color: Color(0xff922224),
                            //   child: Column(
                            //     children: [
                            //       if (store.mySchedule.data.regular.isNotEmpty ||
                            //           store.mySchedule.data.addonPt.isNotEmpty)
                            //         TodayScheduleItem(
                            //           scheduleName: store.mySchedule.data.addonPt.isNotEmpty
                            //               ? 'Personal Training'
                            //               : 'Gym Workouts',
                            //           session: store.mySchedule.data.addonPt.isNotEmpty
                            //               ? store.mySchedule.data.addonPt.first.nSession
                            //               : null,
                            //           completedSession:
                            //           store.mySchedule.data.addonPt.isNotEmpty
                            //               ? store.mySchedule.data.addonPt.first
                            //               .completedSession
                            //               : null,
                            //           data: store.mySchedule.data.regular.isNotEmpty
                            //               ? store.mySchedule.data.regular.first
                            //               : store.mySchedule.data.addonPt.first,
                            //         ),
                            //       if (store.mySchedule.data.addon.isNotEmpty)
                            //         TodayScheduleItem(
                            //           scheduleName:
                            //           store.mySchedule.data.addon.first.addonName,
                            //           session: store.mySchedule.data.addon.first.nSession,
                            //           completedSession:
                            //           store.mySchedule.data.addon.first.completedSession,
                            //           data: store.mySchedule.data.addon.first,
                            //         ),
                            //       if (store.mySchedule.data.addonLive.isNotEmpty)
                            //         TodayScheduleItem(
                            //           scheduleName:
                            //           store.mySchedule.data.addonLive.first.addonName,
                            //           session: store.mySchedule.data.addonLive.first.nSession,
                            //           completedSession: store
                            //               .mySchedule.data.addonLive.first.completedSession,
                            //           data: store.mySchedule.data.addonLive.first,
                            //         ),
                            //       if (store.mySchedule.data.event.isNotEmpty)
                            //         TodayScheduleItem(
                            //           scheduleName:
                            //           store.mySchedule.data.event.first.eventName,
                            //           data: store.mySchedule.data.event.first,
                            //         ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),

                  if (store.upcomingEvents != null &&
                      store.upcomingEvents.data.isNotEmpty &&
                      !abc2)
                    Flexible(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.all(6),
                          child: ExpansionTileCard(
                            key: cardB,
                            baseColor: Colors.white,
                            expandedColor: Colors.white,
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Image.asset(
                                  'assets/gif/upcoming.gif',
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text('Upcoming Activities',
                                        maxLines: 2,
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                )
                              ],
                            ),
                            contentPadding: EdgeInsets.only(top: 6, bottom: 6),
                            onExpansionChanged: (v) {
                              setState(() {
                                abc = v;
                              });
                            },
                            children: [UpcomingEventsWidget()],
                          )),
                    ),
                ],
              ),
              UIHelper.verticalSpace(10.0),
              Categories(),
              UIHelper.verticalSpace(25.0),
              LiveAddonWidget(
                showHorizontalPadding: true,
              ),
              UIHelper.verticalSpace(25.0),
              AllAddonWidget(
                showHorizontalPadding: true,
                showOnlyPT: true,
              ),
              UIHelper.verticalSpace(25.0),
              AllAddonWidget(
                showHorizontalPadding: true,
              ),
              UIHelper.verticalSpace(25.0),
              // Trending(),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Challenges',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Explore challenges will gonna start near you.',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
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
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Events',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Explore events near by your location only',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 240.0,
                  child: Consumer<GymStore>(
                    builder: (context, store, child) => store.allEvents != null
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
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print('version check appName = $appName');
    print('version check packageName = $packageName');
    print('version check version = $version');
    print('version check buildNumber = $buildNumber');
  }
}

class LiveBannerWidget extends StatelessWidget {
  const LiveBannerWidget({
    Key key,
    this.showAll = false,
  }) : super(key: key);
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, value, child) {
        print(
            'Dashboard banner length: ${value.bannerList.where((element) => element.type == 'LIVE_banner').toList()}');
        return value.bannerList == null
            ? Container(
                height: 200,
                width: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
            : value.bannerList.isEmpty
                ? Container()
                : CarouselSlider(
                    options: CarouselOptions(
                      height: showAll
                          ? value.bannerList
                                      .where((element) =>
                                          element.type == 'LIVE_banner')
                                      .toList()
                                      .length >
                                  0
                              ? 260.0
                              : 0.0
                          : 260.0,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      pageSnapping: true,
                    ),
                    items: showAll
                        ? value.bannerList
                            .where((element) => element.type == 'LIVE_banner')
                            .toList()
                            .map(
                            (i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Builder(
                                  builder: (BuildContext context) {
                                    if (i.image == null) {
                                      return Center(
                                        child: Text("No image data"),
                                      );
                                    }
                                    return Image.network(
                                      i.image,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, _, chunk) =>
                                          chunk == null
                                              ? _
                                              : RectangleShimmering(
                                                  width: double.infinity,
                                                  height: 180.0,
                                                ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).toList()
                        : value.bannerList.map(
                            (i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Builder(
                                  builder: (BuildContext context) {
                                    if (i.image == null) {
                                      return Center(
                                        child: Text("No image data"),
                                      );
                                    }
                                    return Image.network(
                                      i.image,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, _, chunk) =>
                                          chunk == null
                                              ? _
                                              : RectangleShimmering(
                                                  width: double.infinity,
                                                  height: 180.0,
                                                ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).toList(),
                  );
      },
    );
  }
}

class AddonBannerWidget extends StatelessWidget {
  const AddonBannerWidget({
    Key key,
    this.showAll = false,
  }) : super(key: key);
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, value, child) {
        print(
            'Dashboard banner length: ${value.bannerList.where((element) => element.type == 'ADDON_banner').toList()}');
        return value.bannerList == null
            ? Container(
                height: 200,
                width: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
            : value.bannerList.isEmpty
                ? Container()
                : CarouselSlider(
                    options: CarouselOptions(
                      height: showAll
                          ? value.bannerList
                                      .where((element) =>
                                          element.type == 'ADDON_banner')
                                      .toList()
                                      .length >
                                  0
                              ? 260.0
                              : 0.0
                          : 260.0,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      pageSnapping: true,
                    ),
                    items: showAll
                        ? value.bannerList
                            .where((element) => element.type == 'ADDON_banner')
                            .toList()
                            .map(
                            (i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Builder(
                                  builder: (BuildContext context) {
                                    if (i.image == null) {
                                      return Center(
                                        child: Text("No image data"),
                                      );
                                    }
                                    return Image.network(
                                      i.image,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, _, chunk) =>
                                          chunk == null
                                              ? _
                                              : RectangleShimmering(
                                                  width: double.infinity,
                                                  height: 180.0,
                                                ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).toList()
                        : value.bannerList.map(
                            (i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Builder(
                                  builder: (BuildContext context) {
                                    if (i.image == null) {
                                      return Center(
                                        child: Text("No image data"),
                                      );
                                    }
                                    return Image.network(
                                      i.image,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, _, chunk) =>
                                          chunk == null
                                              ? _
                                              : RectangleShimmering(
                                                  width: double.infinity,
                                                  height: 180.0,
                                                ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).toList(),
                  );
      },
    );
  }
}

class PTBannerWidget extends StatelessWidget {
  const PTBannerWidget({
    Key key,
    this.showAll = false,
  }) : super(key: key);
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, value, child) {
        print(
            'Dashboard banner length: ${value.bannerList.where((element) => element.type == 'PT_banner').toList()}');
        return value.bannerList == null
            ? Container(
                height: 200,
                width: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
            : value.bannerList.isEmpty
                ? Container()
                : CarouselSlider(
                    options: CarouselOptions(
                      height: showAll
                          ? value.bannerList
                                      .where((element) =>
                                          element.type == 'PT_banner')
                                      .toList()
                                      .length >
                                  0
                              ? 260.0
                              : 0.0
                          : 260.0,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      pageSnapping: true,
                    ),
                    items: showAll
                        ? value.bannerList
                            .where((element) => element.type == 'PT_banner')
                            .toList()
                            .map(
                            (i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Builder(
                                  builder: (BuildContext context) {
                                    if (i.image == null) {
                                      return Center(
                                        child: Text("No image data"),
                                      );
                                    }
                                    return Image.network(
                                      i.image,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, _, chunk) =>
                                          chunk == null
                                              ? _
                                              : RectangleShimmering(
                                                  width: double.infinity,
                                                  height: 180.0,
                                                ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).toList()
                        : value.bannerList.map(
                            (i) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Builder(
                                  builder: (BuildContext context) {
                                    if (i.image == null) {
                                      return Center(
                                        child: Text("No image data"),
                                      );
                                    }
                                    return Image.network(
                                      i.image,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                      loadingBuilder: (context, _, chunk) =>
                                          chunk == null
                                              ? _
                                              : RectangleShimmering(
                                                  width: double.infinity,
                                                  height: 180.0,
                                                ),
                                    );
                                  },
                                ),
                              );
                            },
                          ).toList(),
                  );
      },
    );
  }
}

class TodayScheduleCard extends StatelessWidget {
  const TodayScheduleCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => store.mySchedule != null &&
              store.mySchedule.data != null &&
              store.mySchedule.data.hasData()
          ? Container(
              width: double.infinity,
              color: Color(0xff922224),
              child: Column(
                children: [
                  if (store.mySchedule.data.regular.isNotEmpty ||
                      store.mySchedule.data.addonPt.isNotEmpty)
                    TodayScheduleItem(
                      scheduleName: store.mySchedule.data.addonPt.isNotEmpty
                          ? 'Personal Training'
                          : 'Gym Workouts',
                      session: store.mySchedule.data.addonPt.isNotEmpty
                          ? store.mySchedule.data.addonPt.first.nSession
                          : null,
                      completedSession: store.mySchedule.data.addonPt.isNotEmpty
                          ? store.mySchedule.data.addonPt.first.completedSession
                          : null,
                      data: store.mySchedule.data.regular.isNotEmpty
                          ? store.mySchedule.data.regular.first
                          : store.mySchedule.data.addonPt.first,
                    ),
                  if (store.mySchedule.data.addon.isNotEmpty)
                    TodayScheduleItem(
                      scheduleName: store.mySchedule.data.addon.first.addonName,
                      session: store.mySchedule.data.addon.first.nSession,
                      completedSession:
                          store.mySchedule.data.addon.first.completedSession,
                      data: store.mySchedule.data.addon.first,
                    ),
                  if (store.mySchedule.data.addonLive.isNotEmpty)
                    TodayScheduleItem(
                      scheduleName:
                          store.mySchedule.data.addonLive.first.addonName,
                      session: store.mySchedule.data.addonLive.first.nSession,
                      completedSession: store
                          .mySchedule.data.addonLive.first.completedSession,
                      data: store.mySchedule.data.addonLive.first,
                    ),
                  if (store.mySchedule.data.event.isNotEmpty)
                    TodayScheduleItem(
                      scheduleName: store.mySchedule.data.event.first.eventName,
                      data: store.mySchedule.data.event.first,
                    ),
                ],
              ),
            )
          : Container(),
    );
  }
}

class TodayScheduleItem extends StatelessWidget {
  final String scheduleName;
  final String session;
  final String completedSession;
  final MyScheduleAddonData data;

  const TodayScheduleItem({
    Key key,
    this.scheduleName,
    this.completedSession,
    this.session,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 26),
              title: Text(scheduleName ?? '',
                  style: TextStyle(
                      color: Color(0xffFF8F8F), fontWeight: FontWeight.w500,fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    data?.gymname ?? '',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700,fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${data.gymAddress1 ?? 'address'} , ${data.gymAddress2 ?? ' is here'}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                ],
              ),
              trailing: InkWell(
                onTap: () {
                  MapsLauncher.launchCoordinates(
                    data.gymLat.isNotEmpty
                        ? double.tryParse(data.gymLat)
                        : 28.576639,
                    data.gymLng.isNotEmpty
                        ? double.tryParse(data.gymLng)
                        : 77.388474,
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Text('Direction'),
                ),
              ),
            ),

            ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 12),
              title: Consumer<GymStore>(
                builder: (context, store, child) => store.attendanceDetails ==
                            null ||
                        (store.attendanceDetails != null &&
                            store.attendanceDetails.status)
                    ? Text(
                        'Tap on check-in within Gym premises to activate your session',
                        style: TextStyle(
                            color: Color(0xffFFF848),
                            fontWeight: FontWeight.w600))
                    : Container(),
              ),
              trailing: store.attendanceDetails == null ||
                      (store.attendanceDetails != null &&
                          store.attendanceDetails.data == null)
                  ? InkWell(
                      onTap: () {
                        if (data.type == 'addon_live') {
                          switch (data.roomStatus) {
                            case 'scheduled':
                              FlashHelper.informationBar(
                                context,
                                message:
                                    'Trainer has not started the live session yet',
                              );
                              break;
                            case 'started':
                              context.read<GymStore>().joinLiveSession(
                                    addonName: data.addonName,
                                    liveClassId: data.liveClassId,
                                    roomId: data.roomId,
                                    context: context,
                                    addonId: data.addonId,
                                trainerId: data.trainer_id
                                  );
                              break;
                            case 'completed':
                              FlashHelper.informationBar(
                                context,
                                message: 'Trainer has ended the live session',
                              );
                              break;
                            default:
                              break;
                          }
                        } else {
                          context.read<GymStore>().setSelectedSchedule(
                                context: context,
                                val: data,
                              );
                          //TODO check here checkin
                          context
                              .read<GymStore>()
                              .getCurrentAttendance(context: context);
                          NavigationService.navigateTo(Routes.mainAttendance);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 12, bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(width: 1, color: Colors.white),
                            color: Colors.white),
                        child: Text(
                            data.type == 'addon_live'
                                ? 'Join Session'
                                : 'Check In',
                            style: TextStyle(color: Colors.black)),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (data.type == 'addon_live') {
                          switch (data.roomStatus) {
                            case 'scheduled':
                              FlashHelper.informationBar(
                                context,
                                message:
                                    'Trainer has not started the live session yet',
                              );
                              break;
                            case 'started':
                              context.read<GymStore>().joinLiveSession(
                                    addonName: data.addonName,
                                    liveClassId: data.liveClassId,
                                    roomId: data.roomId,
                                    context: context,
                                    addonId: data.addonId,
                                  trainerId: data.trainer_id
                                  );
                              break;
                            case 'completed':
                              FlashHelper.informationBar(
                                context,
                                message: 'Trainer has ended the live session',
                              );
                              break;
                            default:
                              break;
                          }
                        } else {
                          NavigationService.navigateTo(Routes.dateWorkoutList);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 12, bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(width: 1, color: Colors.white),
                            color: Colors.white),
                        child: Text(
                            data.type == 'addon_live'
                                ? 'Join Session'
                                : 'CONTINUE',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
            ),

            UIHelper.verticalSpace(10.0),
            if (session != null || completedSession != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 6.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpace(12.0),
                    if (session != null)
                      RichText(
                        text: TextSpan(
                          text: 'Sessions: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          children: [
                            TextSpan(
                              text: session ?? '0',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    UIHelper.horizontalSpace(12.0),
                    if (completedSession != null)
                      RichText(
                        text: TextSpan(
                          text: 'Completed Sessions: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          children: [
                            TextSpan(
                              text: completedSession ?? '0',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            //

            // UIHelper.verticalSpace(10.0),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 18.0,
            //     right: 18.0,
            //   ),
            //   child: Text(
            //     '${data?.gymname ?? ''} ',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // if (session != null || completedSession != null)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 18.0,
            //       vertical: 6.0,
            //     ),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         UIHelper.verticalSpace(12.0),
            //         if (session != null)
            //           RichText(
            //             text: TextSpan(
            //               text: 'Sessions: ',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 14.0,
            //                 color: Colors.white.withOpacity(0.6),
            //               ),
            //               children: [
            //                 TextSpan(
            //                   text: session ?? '0',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w500,
            //                     fontSize: 14.0,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         UIHelper.horizontalSpace(12.0),
            //         if (completedSession != null)
            //           RichText(
            //             text: TextSpan(
            //               text: 'Completed Sessions: ',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 14.0,
            //                 color: Colors.white.withOpacity(0.6),
            //               ),
            //               children: [
            //                 TextSpan(
            //                   text: completedSession ?? '0',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w500,
            //                     fontSize: 14.0,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //       ],
            //     ),
            //   ),
            // UIHelper.verticalSpace(10.0),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 18.0,
            //     right: 18.0,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Flexible(
            //         child: Row(
            //           children: [
            //             Icon(
            //               Icons.location_on_outlined,
            //               color: Colors.white.withOpacity(0.8),
            //               size: 14,
            //             ),
            //             SizedBox(
            //               width: 4,
            //             ),
            //             Flexible(
            //               child: Text(
            //                 // '${store.activeSubscriptions?.data?.gymAddress1}, ${store.activeSubscriptions?.data?.gymAddress2}',
            //                 '${data.gymAddress1 ?? 'address'} , ${data.gymAddress2 ?? ' is here'}',
            //                 style: TextStyle(
            //                   color: Colors.white.withOpacity(0.8),
            //                   fontSize: 11.5,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // UIHelper.verticalSpace(10.0),
            // Consumer<GymStore>(
            //   builder: (context, store, child) =>
            //       store.attendanceDetails == null ||
            //               (store.attendanceDetails != null &&
            //                   store.attendanceDetails.status)
            //           ? Container(
            //               padding: const EdgeInsets.symmetric(
            //                 vertical: 12.0,
            //                 horizontal: 12.0,
            //               ),
            //               color: Colors.black,
            //               child: Text(
            //                 'Tap on Check In button within Gym premises to activate your session.',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 14,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //             )
            //           : Container(),
            // ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // Padding(
            //     //   padding: const EdgeInsets.symmetric(
            //     //     horizontal: 12.0,
            //     //   ),
            //     //   child: GetDirectionButton(
            //     //
            //     //     lat: data.gymLat.isNotEmpty
            //     //         ? double.tryParse(data.gymLat)
            //     //         : 28.576639,
            //     //     lng: data.gymLng.isNotEmpty
            //     //         ? double.tryParse(data.gymLng)
            //     //         : 77.388474,
            //     //   ),
            //     // ),
            //
            //     InkWell(
            //       onTap: () {
            //         MapsLauncher.launchCoordinates(
            //           data.gymLat.isNotEmpty
            //               ? double.tryParse(data.gymLat)
            //               : 28.576639,
            //           data.gymLng.isNotEmpty
            //               ? double.tryParse(data.gymLng)
            //               : 77.388474,
            //         );
            //       },
            //       child: Container(
            //         padding:
            //         EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(6)),
            //             border: Border.all(width: 1, color: Colors.white)),
            //         child: Text('Direction'),
            //       ),
            //     ),
            //
            //     InkWell(
            //       onTap: (){
            //         if (data.type == 'addon_live') {
            //           switch (data.roomStatus) {
            //             case 'scheduled':
            //               FlashHelper.informationBar(
            //                 context,
            //                 message:
            //                 'Trainer has not started the live session yet',
            //               );
            //               break;
            //             case 'started':
            //               context.read<GymStore>().joinLiveSession(
            //                 addonName: data.addonName,
            //                 liveClassId: data.liveClassId,
            //                 roomId: data.roomId,
            //                 context: context,
            //                 addonId: data.addonId,
            //               );
            //               break;
            //             case 'completed':
            //               FlashHelper.informationBar(
            //                 context,
            //                 message: 'Trainer has ended the live session',
            //               );
            //               break;
            //             default:
            //               break;
            //           }
            //         } else {
            //           context.read<GymStore>().setSelectedSchedule(
            //             context: context,
            //             val: data,
            //           );
            //           context
            //               .read<GymStore>()
            //               .getCurrentAttendance(context: context);
            //           NavigationService.navigateTo(Routes.mainAttendance);
            //         }
            //       },
            //       child: Container(
            //         padding:
            //         EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(6)),
            //             border: Border.all(width: 1, color: Colors.white),
            //             color: Colors.white),
            //         child: Text(data.type == 'addon_live'
            //             ? 'Join Live Session'
            //             : 'Lets WTF - Check In', style: TextStyle(color: Colors.black)),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: (){
            //         if (data.type == 'addon_live') {
            //           switch (data.roomStatus) {
            //             case 'scheduled':
            //               FlashHelper.informationBar(
            //                 context,
            //                 message:
            //                 'Trainer has not started the live session yet',
            //               );
            //               break;
            //             case 'started':
            //               context.read<GymStore>().joinLiveSession(
            //                 addonName: data.addonName,
            //                 liveClassId: data.liveClassId,
            //                 roomId: data.roomId,
            //                 context: context,
            //                 addonId: data.addonId,
            //               );
            //               break;
            //             case 'completed':
            //               FlashHelper.informationBar(
            //                 context,
            //                 message: 'Trainer has ended the live session',
            //               );
            //               break;
            //             default:
            //               break;
            //           }
            //         } else {
            //           NavigationService.navigateTo(Routes.mySchedule);
            //         }
            //       },
            //       child: Container(
            //         padding:
            //         EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(6)),
            //             border: Border.all(width: 1, color: Colors.white),
            //             color: Colors.white),
            //         child: Text(data.type == 'addon_live'
            //         ? 'Join Live Session'
            //             : 'CONTINUE', style: TextStyle(color: Colors.black)),
            //       ),
            //     ),
            //
            //     if (store.attendanceDetails == null ||
            //         (store.attendanceDetails != null &&
            //             store.attendanceDetails.data == null))
            //       // CustomButton(
            //       //   padding: const EdgeInsets.symmetric(
            //       //     vertical: 6.0,
            //       //     horizontal: 16.0,
            //       //   ),
            //       //   text: data.type == 'addon_live'
            //       //       ? 'Join Live Session'
            //       //       : 'Lets WTF - Check In',
            //       //   bgColor: AppConstants.primaryColor,
            //       //   textColor: Colors.white,
            //       //   textSize: 12.0,
            //       //   height: 30.0,
            //       //   onTap: () {
            //       //     if (data.type == 'addon_live') {
            //       //       switch (data.roomStatus) {
            //       //         case 'scheduled':
            //       //           FlashHelper.informationBar(
            //       //             context,
            //       //             message:
            //       //                 'Trainer has not started the live session yet',
            //       //           );
            //       //           break;
            //       //         case 'started':
            //       //           context.read<GymStore>().joinLiveSession(
            //       //                 addonName: data.addonName,
            //       //                 liveClassId: data.liveClassId,
            //       //                 roomId: data.roomId,
            //       //                 context: context,
            //       //                 addonId: data.addonId,
            //       //               );
            //       //           break;
            //       //         case 'completed':
            //       //           FlashHelper.informationBar(
            //       //             context,
            //       //             message: 'Trainer has ended the live session',
            //       //           );
            //       //           break;
            //       //         default:
            //       //           break;
            //       //       }
            //       //     } else {
            //       //       context.read<GymStore>().setSelectedSchedule(
            //       //             context: context,
            //       //             val: data,
            //       //           );
            //       //       context
            //       //           .read<GymStore>()
            //       //           .getCurrentAttendance(context: context);
            //       //       NavigationService.navigateTo(Routes.mainAttendance);
            //       //     }
            //       //   },
            //       // )
            //
            //     else
            //       CustomButton(
            //         padding: const EdgeInsets.symmetric(
            //           vertical: 6.0,
            //           horizontal: 16.0,
            //         ),
            //         text: data.type == 'addon_live'
            //             ? 'Join Live Session'
            //             : 'CONTINUE',
            //         bgColor: AppConstants.primaryColor,
            //         textColor: Colors.white,
            //         onTap: () {
            //           if (data.type == 'addon_live') {
            //             switch (data.roomStatus) {
            //               case 'scheduled':
            //                 FlashHelper.informationBar(
            //                   context,
            //                   message:
            //                       'Trainer has not started the live session yet',
            //                 );
            //                 break;
            //               case 'started':
            //                 context.read<GymStore>().joinLiveSession(
            //                       addonName: data.addonName,
            //                       liveClassId: data.liveClassId,
            //                       roomId: data.roomId,
            //                       context: context,
            //                       addonId: data.addonId,
            //                     );
            //                 break;
            //               case 'completed':
            //                 FlashHelper.informationBar(
            //                   context,
            //                   message: 'Trainer has ended the live session',
            //                 );
            //                 break;
            //               default:
            //                 break;
            //             }
            //           } else {
            //             NavigationService.navigateTo(Routes.mySchedule);
            //           }
            //         },
            //         textSize: 12.0,
            //         height: 30.0,
            //       ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class RenewCard extends StatelessWidget {
  const RenewCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => store.regularSubscriptions != null &&
              store.regularSubscriptions.length > 0 &&
              store.regularSubscriptions.first.expireDate
                  .isAfter(DateTime.now().add(Duration(days: 5)))
          ? IntrinsicHeight(
              child: Container(
                width: double.infinity,
                child: CustomExpansionTile(
                  collapsedIconColor: Colors.white,
                  collapsedTextColor: Colors.white,
                  collapsedBackgroundColor: AppConstants.primaryColor,
                  iconColor: Colors.white,
                  // tilePadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.platform,
                  title: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: Text(
                      'Today\'s Schedule',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    RenewCardItem(
                      scheduleName: 'Gym Membership Card about to Expire.',
                      data: store.regularSubscriptions.first,
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}

class RenewCardItem extends StatelessWidget {
  final String scheduleName;

  final SubscriptionData data;

  const RenewCardItem({
    Key key,
    this.scheduleName,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12.0,
        ),
        color: AppColors.TEXT_DARK.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(8.0),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      scheduleName ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(10.0),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
              ),
              child: Text(
                '${data?.gymName ?? ''} ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            UIHelper.verticalSpace(10.0),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white.withOpacity(0.8),
                          size: 14,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          child: Text(
                            // '${store.activeSubscriptions?.data?.gymAddress1}, ${store.activeSubscriptions?.data?.gymAddress2}',
                            '${data.gymAddress1 ?? 'address'} , ${data.gymAddress2 ?? ' is here'}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: GetDirectionButton(
                    lat: data.lat.isNotEmpty
                        ? double.tryParse(data.lat)
                        : 28.576639,
                    lng: data.lng.isNotEmpty
                        ? double.tryParse(data.lng)
                        : 77.388474,
                  ),
                ),
                CustomButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 16.0,
                  ),
                  text: 'Renew Now',
                  bgColor: AppConstants.primaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    // LocalValue.GYM_ID = data.gymId;
                    store.getGymPlans(
                      context: context,
                      gymId: data.gymId,
                    );
                    NavigationService.navigateTo(
                      Routes.gymMembershipPlanPage,
                    );
                  },
                  textSize: 12.0,
                  height: 30.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LiveAddonWidget extends StatefulWidget {
  final bool showHorizontalPadding;

  LiveAddonWidget({this.showHorizontalPadding = false});

  @override
  _LiveAddonWidgetState createState() => _LiveAddonWidgetState();
}

class _LiveAddonWidgetState extends State<LiveAddonWidget> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Container(
      // padding: EdgeInsets.symmetric(
      //   horizontal: widget.showHorizontalPadding ? 24.0 : 0.0,
      // ),
      child: Consumer<GymStore>(
        builder: (context, store, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4.0,
                      color: AppConstants.white,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WTF Powered',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                            color: AppConstants.white.withOpacity(0.8),
                          ),
                        ),
                        UIHelper.verticalSpace(4.0),
                        GradientText(
                          text: 'Live Class',
                          colors: <Color>[Colors.redAccent, Colors.white],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 4.0,
                      color: AppConstants.white,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(12.0),
              Expanded(
                child: store.allLiveClasses != null
                    ? store.allLiveClasses.data != null &&
                            store.allLiveClasses.data.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.only(
                              left: widget.showHorizontalPadding ? 10.0 : 0.0,
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: store.allLiveClasses.data.length > 3
                                  ? 4
                                  : store.allLiveClasses.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => index == 3
                                  ? SeeAll(
                                      onTap: () {
                                        NavigationService.navigateTo(
                                            Routes.allLiveAddons);
                                      },
                                    )
                                  : LiveCard(
                                      data: store.allLiveClasses.data[index],
                                      isLiveCard: true,
                                    ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'No live Classes found',
                            ),
                          )
                    : Loading(),
              ),
            ],
          );
        },
      ),
      height: 380.0,
    );
  }
}

class SeeAll extends StatelessWidget {
  final GestureTapCallback onTap;

  const SeeAll({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: AppConstants.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 200.0,
          height: 120.0,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: AppConstants.buttonRed1.withOpacity(0.3),
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'View All',
                style: TextStyle(
                  color: AppConstants.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AllAddonWidget extends StatefulWidget {
  final bool showHorizontalPadding;
  final bool showOnlyPT;

  AllAddonWidget({
    this.showHorizontalPadding = false,
    this.showOnlyPT = false,
  });

  @override
  _AllAddonWidgetState createState() => _AllAddonWidgetState();
}

class _AllAddonWidgetState extends State<AllAddonWidget> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Container(
      padding: EdgeInsets.only(
        left: widget.showHorizontalPadding ? 20.0 : 0.0,
        // right: widget.showHorizontalPadding ? 20.0 : 0.0,
      ),
      height: 380.0,
      child: Consumer<GymStore>(
        builder: (context, store, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'WTF Powered',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: AppConstants.white.withOpacity(0.8),
                ),
              ),
              UIHelper.verticalSpace(4.0),
              GradientText(
                text:
                    '${widget.showOnlyPT ? 'Personal Training' : 'Fitness Activities'}',
                colors: <Color>[Colors.deepOrange, Colors.yellow],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              UIHelper.verticalSpace(16.0),
              Expanded(
                child: store.allAddonClasses != null
                    ? store.allAddonClasses.data != null &&
                            store.allAddonClasses.data.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: store.allAddonClasses.data
                                        .where((e) => widget.showOnlyPT
                                            ? e.isPt == 1
                                            : e.isPt == 0)
                                        .toList()
                                        .length >
                                    3
                                ? 4
                                : store.allAddonClasses.data
                                    .where((e) => widget.showOnlyPT
                                        ? e.isPt == 1
                                        : e.isPt == 0)
                                    .toList()
                                    .length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => index == 3
                                ? SeeAll(
                                    onTap: () {
                                      if (widget.showOnlyPT) {
                                        locator<AppPrefs>()
                                            .seeMorePt
                                            .setValue(widget.showOnlyPT);
                                        NavigationService.navigateTo(
                                            Routes.ptClassPage);
                                      } else {
                                        NavigationService.navigateTo(
                                            Routes.poweredPages);
                                      }
                                    },
                                  )
                                : LiveCard(
                                    data: store.allAddonClasses.data
                                        .where((e) => widget.showOnlyPT
                                            ? e.isPt == 1
                                            : e.isPt == 0)
                                        .toList()[index],
                                    showOnlyPt: widget.showOnlyPT,
                                  ),
                          )
                        : Center(
                            child: Text(
                              'No Activity found',
                            ),
                          )
                    : Loading(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomGradientWidget extends StatelessWidget {
  /// Text to show.
  final Widget child;

  /// List of colors to apply.
  final List<Color> colors;

  /// Text style.
  final TextStyle style;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// Defines what happens at the edge of the gradient.
  final TileMode tileMode;

  /// Use a custom gradient. This will override the [type],
  /// [colors], [transform] and [tileMode] parameters
  final Gradient customGradient;

  /// Set gradient direction. Possible values:
  ///
  /// [GradientDirection.rtl] (Right to left)
  /// [GradientDirection.ltr] (Left to right)
  /// [GradientDirection.ttb] (Top to bottom)
  /// [GradientDirection.btt] (Bottom to top)
  final GradientDirection gradientDirection;

  /// Used for transforming gradient shaders without applying
  /// the same transform to the entire canvas.
  final GradientTransform transform;

  /// Set gradient type. Possible values:
  ///
  /// [GradientType.linear]
  /// [GradientType.radial]
  final GradientType type;

  CustomGradientWidget(
      {Key key,
      @required this.child,
      @required this.colors,
      this.style,
      this.overflow,
      this.textAlign = TextAlign.start,
      this.tileMode = TileMode.clamp,
      this.customGradient,
      this.type = GradientType.linear,
      this.gradientDirection = GradientDirection.ltr,
      this.transform})
      : assert(child != null, 'Child cannot be null.'),
        assert(colors != null && colors.length > 1,
            'Colors cannot be null. You must specify a minimum of two colors'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return _createShader(bounds);
          },
          child: child,
        ),
        child,
        Opacity(
          opacity: 0.3,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return _createShader(bounds);
            },
            child: child,
          ),
        ),
      ],
    );
  }

  Shader _createShader(Rect bounds) {
    if (customGradient != null) {
      return customGradient.createShader(bounds);
    }

    switch (type) {
      case GradientType.linear:
        return _linearGradient(bounds).createShader(bounds);
        break;
      case GradientType.radial:
        return _radialGradient(bounds).createShader(bounds);
        break;
      default:
        return _linearGradient(bounds).createShader(bounds);
    }
  }

  Gradient _linearGradient(Rect bounds) {
    return LinearGradient(
      begin: _getGradientDirection('begin'),
      end: _getGradientDirection('end'),
      colors: colors,
      transform: transform,
      tileMode: tileMode,
    );
  }

  Gradient _radialGradient(Rect bounds) {
    return RadialGradient(
      colors: colors,
      transform: transform,
      tileMode: tileMode,
    );
  }

  Alignment _getGradientDirection(String key) {
    final Map<String, Alignment> map = {
      'begin': Alignment.centerLeft,
      'end': Alignment.centerRight
    };

    switch (gradientDirection) {
      case GradientDirection.ltr:
        map['begin'] = Alignment.centerLeft;
        map['end'] = Alignment.centerRight;
        break;
      case GradientDirection.rtl:
        map['begin'] = Alignment.centerRight;
        map['end'] = Alignment.centerLeft;
        break;
      case GradientDirection.ttb:
        map['begin'] = Alignment.topCenter;
        map['end'] = Alignment.bottomCenter;
        break;
      case GradientDirection.btt:
        map['begin'] = Alignment.bottomCenter;
        map['end'] = Alignment.topCenter;
        break;
    }

    return map[key];
  }
}

enum GradientType { linear, radial }

enum GradientDirection { rtl, ltr, ttb, btt }
