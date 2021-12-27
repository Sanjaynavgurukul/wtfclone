import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/screen/home/body_stats.dart';
import 'package:wtf/screen/home/categories.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/custom_expansion_tile.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../EventDetails.dart';
import '../ExplorePage.dart';
import 'more_categories/more_categories.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: CommonAppBar(),
              // ),
              // Stories(),
              // Divider(
              //   thickness: 1.5,
              //   color: Color(0xff333333),
              // ),
              BannerWidget(),
              SizedBox(
                height: 16.0,
              ),
              // Stories(),
              if (store.mySchedule != null) TodayScheduleCard(),
              UIHelper.verticalSpace(10.0),
              UpcomingEventsWidget(),
              if (store.upcomingEvents != null &&
                  store.upcomingEvents.data.isNotEmpty)
                Divider(
                  thickness: 1.2,
                  color: Colors.white10,
                ),
              UIHelper.verticalSpace(10.0),
              Categories(),
              SizedBox(
                height: 25,
              ),
              BodyStats(),
              SizedBox(
                height: 25,
              ),
              MoreCategories(),
              SizedBox(
                height: 20,
              ),
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
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    Key key,
    this.isExplore = false,
  }) : super(key: key);
  final bool isExplore;

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, value, child) {
        print(
            'Dashboard banner length: ${value.bannerList.where((element) => element.type == 'WTF_banner').toList()}');
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
                      height: 180.0,
                      viewportFraction: 0.7,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      pageSnapping: true,
                    ),
                    items: isExplore
                        ? value.bannerList
                            .where((element) => element.type == 'WTF_banner')
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
                                      fit: BoxFit.cover,
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
                                      fit: BoxFit.cover,
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
                    if (store.mySchedule.data.regular.isNotEmpty ||
                        store.mySchedule.data.addonPt.isNotEmpty)
                      TodayScheduleItem(
                        scheduleName: store.mySchedule.data.addonPt.isNotEmpty
                            ? 'Personal Training'
                            : 'Gym Workouts',
                        session: store.mySchedule.data.addonPt.isNotEmpty
                            ? store.mySchedule.data.addonPt.first.nSession
                            : null,
                        completedSession:
                            store.mySchedule.data.addonPt.isNotEmpty
                                ? store.mySchedule.data.addonPt.first
                                    .completedSession
                                : null,
                        data: store.mySchedule.data.regular.isNotEmpty
                            ? store.mySchedule.data.regular.first
                            : store.mySchedule.data.addonPt.first,
                      ),
                    if (store.mySchedule.data.addon.isNotEmpty)
                      TodayScheduleItem(
                        scheduleName:
                            store.mySchedule.data.addon.first.addonName,
                        session: store.mySchedule.data.addon.first.nSession,
                        completedSession:
                            store.mySchedule.data.addon.first.completedSession,
                        data: store.mySchedule.data.addon.first,
                      ),
                    if (store.mySchedule.data.event.isNotEmpty)
                      TodayScheduleItem(
                        scheduleName:
                            store.mySchedule.data.event.first.eventName,
                        data: store.mySchedule.data.event.first,
                      ),
                  ],
                ),
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
                '${data?.gymname ?? ''} ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
                    UIHelper.verticalSpace(12.0),
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
            Consumer<GymStore>(
              builder: (context, store, child) =>
                  store.attendanceDetails == null ||
                          (store.attendanceDetails != null &&
                              store.attendanceDetails.status)
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 12.0,
                          ),
                          color: Colors.black,
                          child: Text(
                            'Tap on Check In button within Gym premises to activate your session.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: GetDirectionButton(
                    lat: data.gymLat.isNotEmpty
                        ? double.tryParse(data.gymLat)
                        : 28.576639,
                    lng: data.gymLng.isNotEmpty
                        ? double.tryParse(data.gymLng)
                        : 77.388474,
                  ),
                ),
                if (store.attendanceDetails == null ||
                    (store.attendanceDetails != null &&
                        store.attendanceDetails.data == null))
                  CustomButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    text: 'Lets WTF - Check In',
                    bgColor: AppConstants.primaryColor,
                    textColor: Colors.white,
                    textSize: 12.0,
                    height: 30.0,
                    onTap: () {
                      context.read<GymStore>().setSelectedSchedule(
                            context: context,
                            val: data,
                          );
                      context
                          .read<GymStore>()
                          .getCurrentAttendance(context: context);
                      NavigationService.navigateTo(Routes.mainAttendance);
                    },
                  )
                else
                  CustomButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    text: 'CONTINUE',
                    bgColor: AppConstants.primaryColor,
                    textColor: Colors.white,
                    onTap: () {
                      NavigationService.navigateTo(Routes.mySchedule);
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

class UpcomingEventsWidget extends StatefulWidget {
  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  GymStore store;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    var newD = LayoutBuilder(
      builder: (context, constraints) => Consumer<GymStore>(
        builder: (context, store, child) => store.upcomingEvents != null
            ? store.upcomingEvents.data.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: CustomExpansionTile(
                      collapsedIconColor: Colors.white,
                      collapsedTextColor: Colors.white,
                      collapsedBackgroundColor: AppConstants.primaryColor,
                      iconColor: Colors.white,
                      // tilePadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.platform,

                      title: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Text(
                          'Upcoming Activities',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      children: [
                        Container(
                          height: 200.0,
                          child: ListView.builder(
                              itemCount: store.upcomingEvents.data.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var item = store.upcomingEvents.data[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: InkWell(
                                    onTap: () {
                                      store.getEventById(
                                        context: context,
                                        eventId: item.eventId,
                                      );
                                      NavigationService.navigateTo(
                                          Routes.eventDetails);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        // height: 80.0,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.TEXT_DARK
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 15.0,
                                                      height: 8.0,
                                                      decoration: BoxDecoration(
                                                        color: AppConstants
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    UIHelper.horizontalSpace(
                                                        6.0),
                                                    // Text(
                                                    //   'Upcoming',
                                                    //   style: TextStyle(
                                                    //     color: Colors.white,
                                                    //     fontWeight:
                                                    //         FontWeight.bold,
                                                    //     fontSize: 16.0,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                UIHelper.verticalSpace(16.0),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  child: Text(
                                                    item.startDate.isAfter(
                                                            DateTime.now())
                                                        ? 'Join on ${Helper.stringForDatetime2(
                                                            item.startDate
                                                                .toIso8601String(),
                                                          )} , ${item.startTime ?? '9 am'}'
                                                        : 'Before ${Helper.stringForDatetime(
                                                            item.expireDate
                                                                .toIso8601String(),
                                                          )}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ),
                                                UIHelper.verticalSpace(10.0),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20.0,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            item.eventImage !=
                                                                    null
                                                                ? Image.network(
                                                                    item.eventImage,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Container(),
                                                      ),
                                                      UIHelper.horizontalSpace(
                                                          12.0),
                                                      Flexible(
                                                        child: IntrinsicHeight(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  item.eventName,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              UIHelper
                                                                  .verticalSpace(
                                                                      4.0),
                                                              Flexible(
                                                                child: Text(
                                                                  item.gymName,
                                                                  maxLines: 2,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              UIHelper
                                                                  .verticalSpace(
                                                                      4.0),
                                                              Expanded(
                                                                // flex: 1,
                                                                child: Text(
                                                                  '${item.gymAddress1}, ${item.gymAddress2}',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      true,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        10.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              UIHelper
                                                                  .verticalSpace(
                                                                      8.0),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // if (item.coupon != null)
                                                //   Align(
                                                //     alignment:
                                                //         Alignment.centerRight,
                                                //     child: Container(
                                                //       padding: const EdgeInsets
                                                //           .symmetric(
                                                //         horizontal: 10.0,
                                                //         vertical: 6.0,
                                                //       ),
                                                //       margin:
                                                //           const EdgeInsets.only(
                                                //         left: 80.0,
                                                //       ),
                                                //       width: double.infinity,
                                                //       color: Colors.white
                                                //           .withOpacity(0.1),
                                                //       child: Text(
                                                //         'CODE  |  ${item.coupon}                                   ',
                                                //         style: TextStyle(
                                                //           color: Colors.white,
                                                //           fontWeight:
                                                //               FontWeight.w500,
                                                //           fontSize: 12.0,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                              ],
                                            ),
                                            // if (!item.startDate.isAfter(DateTime.now()))
                                            Positioned(
                                              right: 0.0,
                                              left: 0.0,
                                              bottom: 00.0,
                                              child: Center(
                                                child: IgnorePointer(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await store.eventCheckIn(
                                                          context: context,
                                                          eventId:
                                                              item.eventId);
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 12.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppConstants
                                                            .primaryColor,
                                                      ),
                                                      child: Text(
                                                        'View Details',
                                                        style: TextStyle(
                                                          color: AppConstants
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : Container()
            : Loading(),
      ),
    );
    return newD;
  }
}
