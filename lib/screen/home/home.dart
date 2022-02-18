import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:wtf/screen/addon/live_classes.dart';
import 'package:wtf/screen/home/categories.dart';
import 'package:wtf/screen/home/upcoming_events.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/custom_expansion_tile.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../ExplorePage.dart';
import '../event/EventDetails.dart';
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
                      height: isExplore
                          ? value.bannerList
                                      .where((element) =>
                                          element.type == 'WTF_banner')
                                      .toList()
                                      .length >
                                  0
                              ? 250.0
                              : 0.0
                          : 250.0,
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
                    text: data.type == 'addon_live'
                        ? 'Join Live Session'
                        : 'Lets WTF - Check In',
                    bgColor: AppConstants.primaryColor,
                    textColor: Colors.white,
                    textSize: 12.0,
                    height: 30.0,
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
                        context
                            .read<GymStore>()
                            .getCurrentAttendance(context: context);
                        NavigationService.navigateTo(Routes.mainAttendance);
                      }
                    },
                  )
                else
                  CustomButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    text: data.type == 'addon_live'
                        ? 'Join Live Session'
                        : 'CONTINUE',
                    bgColor: AppConstants.primaryColor,
                    textColor: Colors.white,
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
                        NavigationService.navigateTo(Routes.mySchedule);
                      }
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
                      Routes.membershipPlanPage,
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
      height: 380.0,
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
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => LiveClasses(),
                                          ),
                                        );
                                        // NavigationService.navigateTo(
                                        //     Routes.allLiveAddons);
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
      height: 280.0,
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
                                            ? int.tryParse(e.isPt) == 1
                                            : int.tryParse(e.isPt) == 0)
                                        .toList()
                                        .length >
                                    3
                                ? 4
                                : store.allAddonClasses.data
                                    .where((e) => widget.showOnlyPT
                                        ? int.tryParse(e.isPt) == 1
                                        : int.tryParse(e.isPt) == 0)
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
                                            Routes.allAddons);
                                      } else {
                                        NavigationService.navigateTo(
                                            Routes.poweredPages);
                                      }
                                    },
                                  )
                                : LiveCard(
                                    data: store.allAddonClasses.data
                                        .where((e) => widget.showOnlyPT
                                            ? int.tryParse(e.isPt) == 1
                                            : int.tryParse(e.isPt) == 0)
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
