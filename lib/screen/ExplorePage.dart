import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/all_events.dart';
import 'package:wtf/model/gym_add_on.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/common_widgets/common_banner.dart';
import 'package:wtf/screen/new_gym/gym/gym_list_screen.dart';
import 'package:wtf/screen/side_bar_drawer/SidebarDrawer.dart';
import 'package:wtf/widget/ComingSoonWidget.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/gym_list_search_adapter.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../main.dart';
import 'DiscoverScreen.dart';
import 'gym/arguments/gym_detail_argument.dart';
import 'gym/membership_page.dart';
import 'home/home.dart';

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
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: (){
                              FocusScope.of(context).unfocus();
                              store.determinePosition(context);
                              showSearch(
                                  context: context,
                                  delegate: GymListSearchAdapter(
                                      searchableList:
                                      store.allGyms.data,
                                      onClick: (GymModelData data){
                                    print('gym iD --- from nav ${data.userId}');
                                    NavigationService.pushName(Routes.buyMemberShipPage,argument: GymDetailArgument(gym: data, gymId: data.userId));
                                  }));
                            },
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: 0.0,
                                  left: 17,
                                ),
                                hintText: 'Search your favourite WTF gyms',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.0,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    // store.determinePosition();
                                    // NavigationService.navigateTo(
                                    //     Routes.searchScreen);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffBA1406),
                                            Color(0xff490000),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(4.0)),
                                    child: Center(
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xff2d2d2d),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(12.0),
                      Flexible(
                        child: InkWell(
                          onTap: () async {
                            store.determinePosition(context);
                            LocationResult result =
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  Helper.googleMapKey,
                                  displayLocation:
                                  LatLng(store.getLat(), store.getLng()),
                                ),
                              ),
                            );
                            print(result);
                            setState(() {
                              print('Checking selected new location ----');
                              if (result != null) {
                                print('User has choose new location -----');
                                // store.tempLat = result.latLng.latitude;
                                locator<AppPrefs>().lat.setValue(result.latLng.latitude.toString());
                                locator<AppPrefs>().lng.setValue(result.latLng.longitude.toString());
                                // store.tempLng = result.latLng.longitude;
                                context.read<GymStore>().init(context: context);
                              } else {
                                print('Same as previous location ----');
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: SvgPicture.asset('assets/svg/change.svg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: SearchBar(
                //     onClickLocation: (){
                //       context.read<GymStore>().getDiscoverNow(
                //         context: context,
                //         type: 'gym',
                //       );
                //     },
                //   ),
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 12.0,
                //     vertical: 6.0,
                //   ),
                // ),
                UIHelper.verticalSpace(10.0),
                CommonBanner(
                  bannerType: "explore",

                ),
                UIHelper.verticalSpace(30.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 1.0,
                        color: AppConstants.white,
                      ),
                    ),
                    UIHelper.horizontalSpace(4.0),
                    Text(
                      'Discover',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 22.0,
                        color: AppConstants.white,
                      ),
                    ),
                    UIHelper.horizontalSpace(4.0),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 1.0,
                        color: AppConstants.white,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'WTF Powered Gyms & Studios',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: AppConstants.white.withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 12.0,
                //   ),
                //   height: 185.0,
                //   child: ListView.builder(
                //     itemCount: 2,
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //
                //       return InkWell(
                //         onTap: () {
                //           if (index == 0) {
                //             context.read<GymStore>().getDiscoverNow(
                //                   context: context,
                //                   type: 'gym',
                //                 );
                //           } else {
                //             context.read<GymStore>().getDiscoverNow(
                //                   context: context,
                //                   type: 'studio',
                //                 );
                //           }
                //           NavigationService.navigateTo(Routes.discoverNow);
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(builder: (context) => GymListScreen()),
                //           // );
                //         },
                //         child: Container(
                //           width: MediaQuery.of(context).size.width * 0.46,
                //           height: 185.0,
                //           margin: EdgeInsets.only(right: 15),
                //           child: Stack(
                //             children: [
                //               Image.asset(index == 0?'assets/images/gym_bg.png':'assets/images/studio_bg.png'),
                //               // GradientImageWidget(
                //               //   // assets: 'assets/images/gym_cover.png',
                //               //   network:
                //               //       index == 0 ? Images.arena : Images.studio,
                //               //   gragientColor: [
                //               //     Color(0xffB0C9D6).withOpacity(0.2),
                //               //     Colors.black.withOpacity(0.9),
                //               //   ],
                //               // ),
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                   bottom: 10,
                //                   left: 10,
                //                 ),
                //                 child: Align(
                //                   alignment: Alignment.bottomCenter,
                //                   child: SvgPicture.asset(index == 0
                //                       ? 'assets/svg/you_get/gyms.svg'
                //                       : 'assets/svg/you_get/studios.svg'),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 5.0,
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Container(
                  height: 185.0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: discoverItem(
                            image1: 'assets/images/gym_bg.png',
                            image2: 'assets/svg/you_get/gyms.svg',
                            onClick: () {
                              NavigationService.navigateTo(Routes.discoverScreen);
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: discoverItem(
                            image1: 'assets/images/studio_bg.png',
                            image2: 'assets/svg/you_get/studios.svg',
                            onClick: () {
                              NavigationService.navigateTo(Routes.discoverScreen);
                            }),
                      )
                    ],
                  ),
                ),
                UIHelper.verticalSpace(25.0),
                LiveAddonWidget(),
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
                SectionHeader(
                  title: 'Challenges',
                  subTitle: 'Explore Challenges happening near you',
                ),
                UIHelper.verticalSpace(12.0),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
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
                UIHelper.verticalSpace(12.0),
                SectionHeader(
                  title: 'Events',
                  subTitle: 'Explore Events happening near you',
                ),
                UIHelper.verticalSpace(12.0),
                Container(
                  height: 240.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
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
                UIHelper.verticalSpace(30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: Text(
                    'Explore more',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: Consumer<GymStore>(
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
                ),
                UIHelper.verticalSpace(20.0),
                ComingSoonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget discoverItem({Function onClick, String image1, String image2}) {
    return Container(
      alignment: Alignment.center,
      height: 185.0,
      child: InkWell(
        onTap: onClick,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(image1),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: SvgPicture.asset(image2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const SectionHeader({
    Key key,
    this.subTitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          UIHelper.verticalSpace(5.0),
          Text(
            subTitle,
            style: TextStyle(
              color: Colors.white60,
            ),
          ),
        ],
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
              ? MediaQuery.of(context).size.width / 1.6
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

class LiveCard extends StatelessWidget {
  final AddOnData data;
  final bool isFullView;
  final bool isLiveCard;
  final bool showOnlyPt;

  const LiveCard({
    Key key,
    this.data,
    this.isFullView = false,
    this.isLiveCard = false,
    this.showOnlyPt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullView
          ? MediaQuery.of(context).size.width
          : isLiveCard
              ? 270.0
              : 270.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: isLiveCard ? 16 : 8.0,
        right: isLiveCard ? 16 : 8.0,
      ),
      child: Consumer<GymStore>(
        builder: (context, store, child) => isFullView
            ? Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220.0,
                    child: Stack(
                      children: [
                        GradientImageWidget(
                          // assets:
                          //     'assets/images/challenge.png',
                          network: data.image,
                          stops: [0.3, 1.0],
                          gragientColor: [
                            Colors.transparent,
                            Colors.transparent
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.0),
                            topRight: Radius.circular(2.0),
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
                          ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(8.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text(
                            //   data.gymName ?? '',
                            //   style: TextStyle(
                            //     color: AppConstants.white,
                            //     fontSize: 12.0,
                            //     fontWeight: FontWeight.normal,
                            //   ),
                            // ),
                            // UIHelper.verticalSpace(4.0),
                            Text(
                              data.gymName ?? '',
                              style: GoogleFonts.montserrat(
                                color: AppConstants.white.withOpacity(0.9),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            UIHelper.verticalSpace(4.0),
                            Text(
                              data.name ?? '',
                              style: TextStyle(
                                color: AppConstants.white.withOpacity(0.8),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                color: AppConstants.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomGradientWidget(
                        child: InkWell(
                          onTap: () async {
                            await store.getGymDetails(
                              gymId: data.gymId,
                              context: context,
                            );
                            store.setAddOnSlot(
                              context: context,
                              data: data,
                              gymId: data.gymId,
                            );
                            NavigationService.navigateTo(
                              Routes.chooseSlotScreen,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 14.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              gradient: LinearGradient(
                                end: Alignment.topLeft,
                                begin: Alignment.topRight,
                                colors: [
                                  Color(0xffDE0000),
                                  Color(0xff9A0E0E),
                                  // AppConstants.buttonRed2,
                                  // AppConstants.buttonRed1.withOpacity(0.7),
                                ],
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Book Now',
                              style: GoogleFonts.montserrat(
                                color: AppConstants.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        colors: [
                          AppConstants.buttonRed2,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: [
                          GradientImageWidget(
                            // assets:
                            //     'assets/images/challenge.png',
                            network: data.image,
                            gragientColor: [
                              Colors.transparent,
                              Colors.black,
                            ],
                            stops: [0.7, 1.0],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              topRight: Radius.circular(2.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                              left: 8.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/wtf_2.png',
                                ),
                                UIHelper.verticalSpace(6.0),
                                Text(
                                  data.gymName ?? '',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                                UIHelper.verticalSpace(6.0),
                                Text(
                                  data.name ?? '',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                UIHelper.verticalSpace(6.0),
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
                            ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      CustomGradientWidget(
                        child: InkWell(
                          onTap: () async {
                            await store.getGymDetails(
                              gymId: data.gymId,
                              context: context,
                            );
                            store.setAddOnSlot(
                              context: context,
                              data: data,
                              gymId: data.gymId,
                            );
                            NavigationService.navigateTo(
                              Routes.chooseSlotScreen,
                            );
                          },
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),
                              ),
                              gradient: LinearGradient(
                                end: Alignment.topLeft,
                                begin: Alignment.bottomLeft,
                                colors: [
                                  AppConstants.buttonRed2,
                                  AppConstants.buttonRed1,
                                ],
                              ),
                              // color: Color(0xff9A0E0E),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '',
                              style: TextStyle(
                                color: AppConstants.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        colors: [
                          // AppConstants.buttonRed1,
                          AppConstants.red,
                          AppConstants.buttonRed2,
                          // AppConstants.red,
                          // Colors.red,
                          // Colors.black,
                        ],
                      ),
                      Positioned(
                        top: 14.0,
                        left: 0.0,
                        right: 0.0,
                        child: Center(
                          child: Text(
                            'Book Now',
                            style: GoogleFonts.montserrat(
                              color: AppConstants.white.withOpacity(0.95),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 12.0,
        top: 20.0,
      ),
      color: AppColors.BACK_GROUND_BG,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          UIHelper.horizontalSpace(10.0),
          Expanded(
            child: Consumer<GymStore>(
              builder: (context, store, child) =>
                  store.activeSubscriptions != null
                      ? InkWell(
                          onTap: () async {
                            context.read<GymStore>().getGymDetails(
                                  context: context,
                                  gymId: store.activeSubscriptions.data.gymId,
                                );
                            NavigationService.pushName(Routes.buyMemberShipPage,argument: GymDetailArgument(gym: store.selectedGymDetail.data, gymId: store.activeSubscriptions.data.gymId));

                            // Navigator.of(context).push(
                            //   CupertinoPageRoute(
                            //     builder: (_) => BuyMemberShipPage(
                            //       gymId: store.activeSubscriptions.data.gymId,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PreferenceBuilder<String>(
                                  preference: locator<AppPrefs>().userName,
                                  builder: (context, name) {
                                    return Text(
                                      'Hi! ${name.isNotEmpty ? name.capitalize() : ""}',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    );
                                  }),
                              UIHelper.verticalSpace(4.0),
                              Row(
                                children: [
                                  Text(
                                    'Welcome to',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    )
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  store.activeSubscriptions != null &&
                                          store.activeSubscriptions.data != null
                                      ? SizedBox(
                                          width: 0,
                                        )
                                      : Image.asset(
                                          'assets/images/wtf_2.png',
                                          height: 14.0,
                                        )
                                ],
                              ),
                              UIHelper.verticalSpace(4.0),
                              if (store.activeSubscriptions != null &&
                                  store.activeSubscriptions.data != null)
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/wtf_2.png',
                                      height: 14.0,
                                    ),
                                    UIHelper.horizontalSpace(6.0),
                                    Text(
                                      store.activeSubscriptions.data.gymName
                                              .split(':')[1]
                                              .trim() ??
                                          'n/a',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        )
                      : Loader(),
            ),
          ),
          UIHelper.horizontalSpace(10.0),
          VerticalDivider(
            width: 1.0,
            color: Colors.white,
          ),
          UIHelper.horizontalSpace(10.0),
          //TODO cehck Jitsi
          // PreferenceBuilder<String>(
          //   preference: locator<AppPrefs>().dateAdded,
          //   builder: (context, snapshot) {
          //     print('date added value --- $snapshot');
          //     return snapshot != null
          //         ? Text(
          //             // '',
          //             'Joined ${Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('hour') || Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('hours') || Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('minutes') || Jiffy(snapshot).startOf(Units.DAY).fromNow().contains('minute') ? 'today' : '\n${Jiffy(snapshot).startOf(Units.DAY).fromNow()}'}',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 11.0,
          //               color: Colors.white,
          //             ),
          //           )
          //         : Container();
          //   },
          // ),
        ],
      ),
    );
  }
}
