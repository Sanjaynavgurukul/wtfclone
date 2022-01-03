import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/auto_image_slider.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/slide_button.dart';

import '../main.dart';
import 'membership_page.dart';

class EventDetails extends StatefulWidget {
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  GymStore gymStore;

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      bottomNavigationBar: Container(
        height: 122.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Consumer<GymStore>(
          builder: (context, store, child) => store.selectedEventData != null &&
                  -DateTime.now()
                          .difference(
                              DateTime.parse(store.selectedEventData.validFrom))
                          .inSeconds >
                      0
              ? Column(
                  children: [
                    UIHelper.verticalSpace(12.0),
                    Text(
                        'Events Registration starts on: ${Helper.stringForDatetime2(store?.selectedEventData?.validFrom) ?? ''}'),
                    CustomButton(
                      height: 48.0,
                      onTap: () {},
                      bgColor: Colors.white,
                      textColor: Colors.red,
                      radius: 12.0,
                      text: 'Coming Soon!!',
                    ),
                  ],
                )
              : Column(
                  children: [
                    UIHelper.verticalSpace(12.0),
                    if (gymStore.selectedEventData != null &&
                        gymStore.selectedEventData.validTo != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/trending.png',
                            width: 15.0,
                            height: 20.0,
                          ),
                          Text(
                              '${DateTime.now().difference(DateTime.parse(gymStore.selectedEventData.validTo)).inHours.isNegative ? -DateTime.now().difference(DateTime.parse(gymStore.selectedEventData.validTo)).inHours < 24 ? '1 Day left' : '${-DateTime.now().difference(DateTime.parse(gymStore.selectedEventData.validTo)).inDays + 1 % 24} Days left' : '${DateTime.now().difference(DateTime.parse(gymStore.selectedEventData.validTo)).inHours} Days left'}'),
                        ],
                      ),
                    UIHelper.verticalSpace(2.0),
                    Consumer<GymStore>(
                      builder: (context, store, child) => store
                                  .selectedEventData !=
                              null
                          ? store.isEventParticipated
                              ? CustomButton(
                                  height: 40.0,
                                  onTap: () {
                                    if (Helper.formatDate2(
                                            DateTime.now().toIso8601String()) ==
                                        Helper.formatDate2(
                                            store.selectedEventData.date)) {
                                      if (store.eventParticipation != null &&
                                          store.eventParticipation.data !=
                                              null &&
                                          store.eventParticipation.data
                                                  .dateCheckedin !=
                                              null) {
                                        FlashHelper.informationBar(
                                          context,
                                          message: 'Event already checked-in',
                                        );
                                      } else {
                                        gymStore.eventCheckIn(
                                            context: context,
                                            eventId:
                                                store.selectedEventData.uid);
                                      }
                                    } else {
                                      FlashHelper.errorBar(
                                        context,
                                        message: 'cannot start now',
                                      );
                                    }
                                  },
                                  textColor: Colors.white,
                                  bgColor: AppConstants.primaryColor,
                                  radius: 12.0,
                                  text: Helper.formatDate2(DateTime.now()
                                              .toIso8601String()) ==
                                          Helper.formatDate2(
                                              store.selectedEventData.date)
                                      ? store.eventParticipation != null &&
                                              store.eventParticipation.data !=
                                                  null &&
                                              store.eventParticipation.data
                                                      .dateCheckedin !=
                                                  null
                                          ? 'Event Checked-In at ${Helper.stringForDatetime(store.eventParticipation.data.dateCheckedin.toIso8601String())}'
                                          : 'Check - In'
                                      : 'Events starts on: ${Helper.stringForDatetime2(store?.selectedEventData?.date) ?? ''}',
                                )
                              : SlideButton(
                                  gymStore.selectedEventData != null
                                      ? "Book now for Rs. ${gymStore.selectedEventData.price}"
                                      : 'Book now',
                                  () async {
                                    if (int.tryParse(
                                            gymStore.selectedEventData.price) >
                                        0) {
                                      store.getAllGymOffers(
                                        gymId: store.selectedEventData.gymId,
                                        context: context,
                                      );
                                      NavigationService.navigateTo(
                                          Routes.bookingSummaryEvent);
                                    } else {
                                      var body = {
                                        "gym_id":
                                            gymStore.selectedEventData.gymId,
                                        "user_id": locator<AppPrefs>()
                                            .memberId
                                            .getValue(),
                                        "price": '0',
                                        "type": 'event',
                                        "tax_percentage": "18",
                                        "tax_amount": '0',
                                        "slot_id": '',
                                        "addon": '',
                                        'event_id':
                                            gymStore.selectedEventData.uid,
                                        'remark':
                                            gymStore.selectedEventData.uid,
                                        "start_date": Helper.stringForDatetime3(
                                                gymStore.selectedEventData.date)
                                            .trim(),
                                        "expire_date":
                                            Helper.stringForDatetime3(gymStore
                                                    .selectedEventData.date)
                                                .trim(),
                                        'trx_id': 'pay_free',
                                        'trx_status': 'done',
                                        'order_status': 'done',
                                      };
                                      bool isDone =
                                          await gymStore.addSubscription(
                                              context: context, body: body);
                                      if (isDone) {
                                        gymStore.addEventParticipation(
                                            context: context);
                                      } else {
                                        FlashHelper.errorBar(
                                          context,
                                          message: 'Please try again',
                                        );
                                      }
                                    }
                                    // NavigationService.navigateTo(Routes.scheduleSlotPage);
                                  },
                                )
                          : Container(
                              height: 0.0,
                            ),
                    ),
                  ],
                ),
        ),
      ),
      body: SafeArea(
        child: Consumer<GymStore>(
          builder: (context, gymStore, child) => gymStore.selectedEventData ==
                  null
              ? LoadingWithBackground()
              : gymStore.selectedEventData != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (gymStore.selectedEventData.image != null &&
                                gymStore.selectedEventData.image.isNotEmpty)
                              AutoImageSlider(
                                mainContainerHeight:
                                    MediaQuery.of(context).size.height / 2.3,
                                childContainerHeight:
                                    MediaQuery.of(context).size.height / 2.28,
                                items: [gymStore.selectedEventData.image],
                                dotSize: 8.0,
                                activeMarkerColor: Colors.red,
                                inActiveMarkerColor:
                                    Colors.white.withOpacity(0.4),
                                markerType: PositionMarkerType.dots,
                                positionedMarker: true,
                                showDelete: false,
                                showBorderDots: true,
                                autoScroll: false,
                              )
                            else
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.3,
                                color: Colors.white.withOpacity(0.1),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gymStore.selectedEventData.mode ==
                                            'challenge'
                                        ? "Challenge"
                                        : "Events",
                                    // 'WTF Team Core',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  UIHelper.verticalSpace(6.0),
                                  Text(
                                    gymStore.selectedEventData.name ?? '',
                                    // 'WTF Team Core',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  UIHelper.verticalSpace(6.0),
                                  InkWell(
                                    onTap: () {
                                      context.read<GymStore>().getGymDetails(
                                            context: context,
                                            gymId: gymStore
                                                .selectedEventData.gymId,
                                          );
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (_) => BuyMemberShipPage(
                                            gymId: gymStore
                                                .selectedEventData.gymId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'By ${gymStore.selectedEventData.gymName}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpace(20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/calendar.svg',
                                        color: Colors.white.withOpacity(0.7),
                                        height: 24.0,
                                      ),
                                      UIHelper.horizontalSpace(12.0),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Helper.stringWeekDay(gymStore
                                                    .selectedEventData.date
                                                    .toString()) ??
                                                '',
                                            // 'WTF Team Core',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          UIHelper.verticalSpace(6.0),
                                          Text(
                                            ' ${gymStore.selectedEventData.timeFrom} to ${gymStore.selectedEventData.timeTo}',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpace(12.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              size: 20.0,
                                            ),
                                            UIHelper.horizontalSpace(12.0),
                                            Flexible(
                                              child: Text(
                                                '${gymStore.selectedEventData.gymAddress1 ?? ''}, ${gymStore.selectedEventData.gymAddress2}' ??
                                                    '',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GetDirectionButton(
                                        lat: double.tryParse(
                                          gymStore.selectedEventData.gymLat,
                                        ),
                                        lng: double.tryParse(
                                          gymStore.selectedEventData.gymLong,
                                        ),
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpace(30.0),
                                  Html(
                                    data: gymStore
                                            .selectedEventData.description ??
                                        '',
                                    // padding: EdgeInsets.all(8.0),
                                    // customRender: (node, children) {
                                    //   if (node is dom.Element) {
                                    //     switch (node.localName) {
                                    //       case "custom_tag": // using this, you can handle custom tags in your HTML
                                    //         return Column(children: children);
                                    //     }
                                    //   }
                                    // },
                                  ),
                                  SizedBox(
                                    height: 14.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Event Details not available.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    gymStore.setEventsData(data: null);
    super.dispose();
  }
}

class GetDirectionButton extends StatelessWidget {
  final double lat;
  final double lng;

  GetDirectionButton({this.lat, this.lng});

  _launchMaps() async {
    print('lat $lat --- lng: $lng');
    MapsLauncher.launchCoordinates(
      lat,
      lng,
    );
    // String googleUrl = 'comgooglemaps://?center=$lat,$lng';
    // String appleUrl = 'https://maps.apple.com/?sll=$lat,$lng';
    // if (await canLaunch(uri.toString()) {
    //   print('launching com googleUrl');
    //   await launch(googleUrl);
    // } else if (await canLaunch(appleUrl)) {
    //   print('launching apple url');
    //   await launch(appleUrl);
    // } else {
    //   throw 'Could not launch url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchMaps,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Transform.rotate(
                angle: -0.8,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Get Directions',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
