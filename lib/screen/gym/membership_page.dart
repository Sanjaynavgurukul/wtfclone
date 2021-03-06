import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/gym_add_on.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/screen/common_widgets/flexible_app_bar.dart';
import 'package:wtf/screen/event/EventDetails.dart';
import 'package:wtf/screen/gym/arguments/gym_detail_argument.dart';
import 'package:wtf/widget/BenefitsSection.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';
import 'package:wtf/widget/auto_image_slider.dart';
import 'package:wtf/widget/processing_dialog.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/slide_button.dart';

class BuyMemberShipPage extends StatefulWidget {
  static const routeName = '/buyMemberShipPage';
  const BuyMemberShipPage();
  @override
  _BuyMemberShipPageState createState() => _BuyMemberShipPageState();
}

class _BuyMemberShipPageState extends State<BuyMemberShipPage> {
  // Local Variables :D
  bool show = false;
  bool scrollOrNot = true;
  final bool isPreview = false;
  GymStore gymStore;
  bool callMethod = true;
  final _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    gymStore = context.watch<GymStore>();
  }

  @override
  Widget build(BuildContext context) {
    final GymDetailArgument args =
    ModalRoute
        .of(context)
        .settings
        .arguments as GymDetailArgument;

    if (args.gym.userId == null) {
      return Material(
        child: Center(child: Text(
            'Something Went Wrong\nPlease Try again Later',
            style: TextStyle(color: Colors.white),textAlign:TextAlign.center,),),
      );
      //TODO call Data here because gym id
    }else{
      var gym = args.gym;
      // gymStore.selectedGymDetail = GymDetailsModel(data: gym,status: true,message: 'Gym Found');
      gymStore.selectedGymDetail = GymDetailsModel(data: gym,status: true,message: 'Gym Found');

      return Scaffold(
          body:  Consumer<GymStore>(builder: (context, gymStore, child) {
            bool isSubscribed = gymStore.checkSubscription(gym.userId);
            return gymStore.selectedGymDetail == null
                ? LoadingWithBackground()
                : gymStore.selectedGymDetail.status
                ? Scaffold(
              backgroundColor: Color(0xff0D0D0D),
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(
                    left: 16, right: 16, top: 6, bottom: 6),
                constraints: BoxConstraints(minHeight: 54, maxHeight: 60),
                child: isSubscribed ? RenewMembership(
                  gymId: gym.userId,
                ) : Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          // if(gymStore.activeSubscriptions != null){
                          //   if(gymStore.activeSubscriptions.data.gymId == widget.gymId){
                          //
                          //   }
                          // }else{
                          //
                          // }
                          if (gymStore.activeSubscriptions == null ||
                              (gymStore.activeSubscriptions != null &&
                                  gymStore.activeSubscriptions.data ==
                                      null)) {
                            gymStore.getGymPlans(
                              gymId:
                              gymStore.selectedGymDetail.data.userId,
                              context: context,
                            );

                            NavigationService.navigateTo(
                              Routes.gymMembershipPlanPage,
                            );
                          } else {
                            String selection = await showDialog<String>(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) =>
                                  SubscriptionAlreadyPresent(
                                    cancelTapped: () {
                                      Navigator.pop(context, 'no');
                                    },
                                    nextTapped: () {
                                      Navigator.pop(context, 'yes');
                                    },
                                    gymName: gymStore
                                        .activeSubscriptions.data.gymName,
                                  ),
                            );
                            if (selection != null && selection == 'yes') {
                              gymStore.getGymPlans(
                                gymId: gymStore
                                    .selectedGymDetail.data.userId,
                                context: context,
                              );
                              NavigationService.navigateTo(
                                Routes.gymMembershipPlanPage,
                              );
                            }
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 12, right: 12),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff490000),
                                    Color(0xffBA1406),
                                  ],
                                )),
                            alignment: Alignment.center,
                            child: Text('Buy Membership')),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          List<AddOnData> list = getFreeSession(
                              data: gymStore.selectedGymAddOns.data);
                          if (list.isNotEmpty && list != null) {
                            gymStore.setAddOnSlot(
                              context: context,
                              data: list[0],
                              isFree: true,
                            );
                            NavigationService.navigateTo(
                              Routes.chooseSlotScreen,
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: 'No Free trial available');
                          }
                          // gymStore.setAddOnSlot(
                          //   context: context,
                          //   data: gymStore.selectedGymAddOns.data
                          //       .where((element) => element.price == '0' && element.freeSession == 'true')
                          //       .toList()[0],
                          //   isFree: true,
                          // );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                    width: 2, color: AppConstants.tabBg)),
                            alignment: Alignment.center,
                            child: Text('Book Free Trial',
                                style: TextStyle(
                                    color: AppConstants.whitish))),
                      ),
                    ),
                  ],
                ),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await context.read<GymStore>().getGymByID(
                    context: context,
                    gymId: gym.userId,
                  );
                },
                color: AppConstants.primaryColor,
                backgroundColor: Colors.white,
                child: CustomScrollView(
                  physics: isPreview == true
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      centerTitle: false,
                      backgroundColor: AppConstants.primaryColor,
                      leading: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.white.withOpacity(0.3)),
                            shape: BoxShape.circle,
                            // color: glassyColor.withOpacity(0.3)
                          ),
                          child: Icon(Icons.close,
                              color: Colors.white.withOpacity(0.3)),
                        ),
                      ),
                      pinned: false,
                      expandedHeight: 330.0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 14, right: 16, top: 16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Color(0xff0D0D0D)
                                      ])),
                              child: gymStore
                                  .selectedGymDetail.data.distance
                                  .contains('N/A')
                                  ? SizedBox(
                                width: 0,
                              )
                                  : ListTile(
                                subtitle: Text(
                                    '${gymStore.selectedGymDetail.data
                                        .duration_text} away'),
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.directions_car,
                                      size: 18,
                                      color: AppConstants.green,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                        '${gymStore.selectedGymDetail.data
                                            .distance_text}',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.normal))
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    print('lat and lng -- ${gym.latitude} -- ${gym.longitude}');
                                    MapsLauncher.launchCoordinates(
                                      double.parse(gym.latitude),
                                        double.parse(gym.longitude)
                                      // double.tryParse(
                                      //   gym.longitude
                                      //   // gymStore.selectedGymDetail
                                      //   //     .data.latitude,
                                      // ),
                                      // double.tryParse(
                                      //   gym.longitude
                                      //   // gymStore.selectedGymDetail
                                      //   //     .data.longitude,
                                      // ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                        left: 12,
                                        right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(4)),
                                      color: Color(0xffBA1406),
                                    ),
                                    child: Text('Direction',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w400,
                                            fontStyle:
                                            FontStyle.normal)),
                                  ),
                                ),
                              )
                            // : Column(
                            //     crossAxisAlignment:
                            //         CrossAxisAlignment.end,
                            //     mainAxisSize: MainAxisSize.max,
                            //     children: <Widget>[
                            //       RichText(
                            //         text: TextSpan(
                            //           text: '',
                            //           style:
                            //               DefaultTextStyle.of(context)
                            //                   .style,
                            //           children: <WidgetSpan>[
                            //             WidgetSpan(
                            //                 child: Icon(
                            //               Icons.directions_car,
                            //               size: 18,
                            //               color: AppConstants.green,
                            //             )),
                            //             WidgetSpan(
                            //                 child: Text(
                            //                     // ' ${item.duration_text??''} away | ${item.distance_text??''}'
                            //                     ' ${gymStore.selectedGymDetail.data.duration_text ?? ''} away | ${gymStore.selectedGymDetail.data.distance_text}',
                            //                     style: TextStyle(
                            //                         fontSize: 14,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .bold))),
                            //           ],
                            //         ),
                            //       ),
                            //       SizedBox(height: 8),
                            //       InkWell(
                            //         onTap: () {
                            //           MapsLauncher.launchCoordinates(
                            //             double.tryParse(
                            //               gymStore.selectedGymDetail
                            //                   .data.latitude,
                            //             ),
                            //             double.tryParse(
                            //               gymStore.selectedGymDetail
                            //                   .data.longitude,
                            //             ),
                            //           );
                            //         },
                            //         child: Container(
                            //           padding: EdgeInsets.only(
                            //               top: 8,
                            //               bottom: 8,
                            //               left: 12,
                            //               right: 12),
                            //           decoration: BoxDecoration(
                            //             borderRadius:
                            //                 BorderRadius.all(
                            //                     Radius.circular(4)),
                            //             color: Color(0xffBA1406),
                            //           ),
                            //           child: Text('Direction',
                            //               style: TextStyle(
                            //                   fontSize: 14,
                            //                   fontWeight:
                            //                       FontWeight.w400,
                            //                   fontStyle:
                            //                       FontStyle.normal)),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                          ),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: FlexibleAppBar(
                          images: gymStore.selectedGymDetail.data.gallery,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Name and rating section :D
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                          '${gymStore.selectedGymDetail.data
                                              .gymName ?? ''}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              fontStyle: FontStyle.normal)),
                                      subtitle: Text(
                                          '${gymStore.selectedGymDetail.data
                                              .address1 + " " +
                                              gymStore.selectedGymDetail.data
                                                  .address2}'),
                                      trailing: gymStore.selectedGymDetail
                                          .data.rating
                                          .toDouble() !=
                                          null &&
                                          gymStore.selectedGymDetail.data
                                              .rating
                                              .toDouble() >
                                              0
                                          ? Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text('Rating',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                          SizedBox(height: 6),
                                          GestureDetector(
                                            behavior:
                                            HitTestBehavior.opaque,
                                            onTap: () {
                                              if (!isSubscribed) return;
                                              final _dialog =
                                              RatingDialog(
                                                // your app's name?
                                                title:
                                                'Rate ${gymStore.selectedGymDetail
                                                    .data.gymName}',
                                                // encourage your user to leave a high rating?
                                                message:
                                                'Tap a star to set your rating. Add more description here if you want.',
                                                // your app's logo?
                                                image: Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    image:
                                                    DecorationImage(
                                                      image: AssetImage(
                                                          'assets/logo/wtf_dark.png'),
                                                    ),
                                                  ),
                                                ),

                                                submitButton: 'Submit',
                                                ratingColor: Colors.red,
                                                onCancelled: () =>
                                                    print('cancelled'),
                                                onSubmitted:
                                                    (response) {
                                                  print(
                                                      'rating: ${response
                                                          .rating}, comment: ${response
                                                          .comment}');
                                                  gymStore
                                                      .giveGymFeedback(
                                                    context: context,
                                                    comment: response
                                                        .comment,
                                                    stars: double
                                                        .tryParse(response
                                                        .rating
                                                        .toString()),
                                                  );
                                                },
                                              );

                                              showDialog(
                                                context: context,
                                                barrierDismissible:
                                                true,
                                                builder: (context) =>
                                                _dialog,
                                              );
                                            },
                                            child: IgnorePointer(
                                              ignoring: true,
                                              child: RatingBar(
                                                  initialRating: gymStore
                                                      .selectedGymDetail
                                                      .data
                                                      .rating
                                                      .toDouble() ??
                                                      0.0,
                                                  direction:
                                                  Axis.horizontal,
                                                  allowHalfRating:
                                                  false,
                                                  itemCount: 5,
                                                  itemSize: 16,
                                                  ratingWidget:
                                                  RatingWidget(
                                                    full: Icon(
                                                      Icons.star,
                                                      color: AppConstants
                                                          .boxBorderColor,
                                                    ),
                                                    half: Icon(
                                                      Icons.star_half,
                                                      color: AppConstants
                                                          .boxBorderColor,
                                                    ),
                                                    empty: Icon(
                                                      Icons.star_border,
                                                      color:
                                                      AppConstants
                                                          .white,
                                                    ),
                                                  ),
                                                  itemPadding: EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      0.0),
                                                  onRatingUpdate:
                                                      (bo) {}),
                                            ),
                                          )
                                        ],
                                      )
                                          : Text('Newly Opened'),
                                    ),
                                    //Divider :D
                                    if (gymStore.selectedGymDetail.data
                                        .description !=
                                        null)
                                      Divider(
                                        thickness: 2,
                                        color: AppConstants.headingTextColor,
                                      ),
                                    //Description :D
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Padding(
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: Text('Description',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal)),
                                      ),
                                      subtitle: gymStore.selectedGymDetail
                                          .data.description !=
                                          null
                                          ? Html(
                                        data: gymStore.selectedGymDetail
                                            .data.description,
                                      )
                                          : Text(
                                          '${gymStore.selectedGymDetail.data
                                              .gymName ??
                                              ''} is one of the leading fitness center at WTF'),
                                    ),
//                                   InkWell(
//                                     onTap: () {
//                                       final _dialog =
//                                       RatingDialog(
//                                         // your app's name?
//                                         title:
//                                         'Rate ${gymStore.selectedGymDetail.data.gymName}',
//                                         // encourage your user to leave a high rating?
//                                         message:
//                                         'Tap a star to set your rating. Add more description here if you want.',
//                                         // your app's logo?
//                                         image:
//                                         Container(
//                                           decoration:
//                                           BoxDecoration(
//                                             image:
//                                             DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/logo/wtf_dark.png'),
//                                             ),
//                                           ),
//                                         ),
//
//                                         submitButton:
//                                         'Submit',
//                                         ratingColor:
//                                         Colors.red,
//                                         onCancelled:
//                                             () => print(
//                                             'cancelled'),
//                                         onSubmitted:
//                                             (response) {
//                                           print(
//                                               'rating: ${response.rating}, comment: ${response.comment}');
//                                           gymStore
//                                               .giveGymFeedback(
//                                             context:
//                                             context,
//                                             comment:
//                                             response
//                                                 .comment,
//                                             stars: double.tryParse(
//                                                 response
//                                                     .rating
//                                                     .toString()),
//                                           );
//                                         },
//                                       );
//
// // show the dialog
//                                       showDialog(
//                                         context:
//                                         context,
//                                         barrierDismissible:
//                                         true,
//                                         builder:
//                                             (context) =>
//                                         _dialog,
//                                       );
//                                     },
//                                     child: Padding(
//                                       padding:
//                                       const EdgeInsets
//                                           .all(8.0),
//                                       child: Text(
//                                         '??????????????? Rate us',
//                                         textAlign:
//                                         TextAlign
//                                             .center,
//                                         style:
//                                         TextStyle(
//                                           color: Colors
//                                               .white,
//                                         ),
//                                       ),
//                                     ),
//                                   )
                                    // if (isSubscribed) GoldMembership()
                                  ],
                                ),
                              ),

                              SizedBox(height: 24),
                              //Facility Section :D
                              if (gymStore
                                  .selectedGymDetail.data.benefits.isNotEmpty)
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text('Facilities',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal)),
                                    ),
                                    SizedBox(height: 12),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                          left: 8,
                                          right: 8),
                                      decoration: BoxDecoration(
                                          color: AppConstants.bgColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(0))),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: facilityItems(
                                              data: gymStore.selectedGymDetail
                                                  .data.benefits ??
                                                  []),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 24),
                                    Text('Why to choose WTF',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(height: 12),
                                    GridView.count(
                                      primary: false,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(20),
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      physics: NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      children: <Widget>[
                                        whyWTF('Earn WTF rewards coin',
                                            'assets/svg/why_choose/coins.svg'),
                                        whyWTF('Fully Vaccinated Staff',
                                            'assets/svg/why_choose/vaccine.svg'),
                                        whyWTF('Track Fitness Journey',
                                            'assets/svg/why_choose/heart.svg'),
                                        whyWTF('Pocket Friendly Membership',
                                            'assets/svg/why_choose/money.svg'),
                                        whyWTF('Free diet Support',
                                            'assets/svg/why_choose/diet.svg'),
                                        whyWTF('Top Class Ambiance',
                                            'assets/svg/why_choose/class.svg'),
                                      ],
                                    ),
                                    BookPTWidget(),
                                    SizedBox(height: 34),
                                    //CoSpace section :D
                                    GymLiveWidget(gymId: gym.userId,),
                                    SizedBox(height: 45),
                                    // Container(
                                    //   child: SingleChildScrollView(
                                    //     scrollDirection: Axis.horizontal,
                                    //     child: Row(
                                    //       children: coSpaceWidget(),
                                    //     ),
                                    //   ),
                                    // ),
                                    GymAddonWidget(),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )
                : Center(
                child: Text(
                'Gym not Found',
                style: TextStyle(
                color: Colors.white,
            ),
            ));
          }),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    gymStore.setGymDetails(data: null);
  }

  List<AddOnData> getFreeSession({@required List<AddOnData> data}) {
    return data
        .where(
            (element) => element.price == '0' && element.freeSession == 'true')
        .toList();
  }

  //Facility List Widget :D
  List<Widget> facilityItems({List<Benfit> data}) =>
      data.isNotEmpty
          ? data
          .map((item) =>
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                item.image != null
                    ? Image.network(
                  item.image,
                  width: 60,
                  height: 60,
                )
                    : Image.asset(
                  'assets/images/benefit.png',
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ))
          .toList()
          : [Center(child: Text("No facility Available"))];

  Widget whyChooseWTFItems(String text, String icon) {
    return TextIconCard(text: text, icon: icon);
  }

  Widget whyWTF(String label, String icon) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Color(0xff292929),
          border: Border.all(width: 1, color: Color(0xffAAAAAA))),
      child: Column(
        children: [
          SizedBox(height: 12),
          SvgPicture.asset(icon ?? 'assets/svg/why_choose/class.svg',
              width: 50,
              height: 50,
              color: Colors.white,
              semanticsLabel: 'A red up arrow'),
          SizedBox(height: 18),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

//Book Pt Card
class BookPTWidget extends StatefulWidget {
  const BookPTWidget({
    Key key,
  }) : super(key: key);

  @override
  State<BookPTWidget> createState() => _BookPTWidgetState();
}

class _BookPTWidgetState extends State<BookPTWidget> {
  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.watch<GymStore>();
    return gymStore.addOnSubscriptions != null &&
        gymStore.addOnSubscriptions.length != null &&
        gymStore.addOnSubscriptions.isNotEmpty &&
        gymStore.addOnSubscriptions
            .where((e) =>
        gymStore.selectedGymDetail.data.userId == e.gymId &&
            e.type == 'addon_pt' &&
            e.expireDate.isAfter(DateTime.now()) &&
            e.completedSession.toString() != e.nSession.toString())
            .toList()
            .length >
            0
        ? Container()
        : gymStore.selectedGymAddOns.data
        .where((element) => element.isPt == 1)
        .toList()
        .length >
        0
        ? Column(
      children: [
        SizedBox(height: 12),
        //Personal Training
        Container(
          padding: EdgeInsets.only(
              top: 20, bottom: 20, left: 12, right: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff3C3B3F),
                  Color(0xff603C3C),
                ],
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/wtf_light.png',
                    width: 50,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                      '${gymStore.selectedGymAddOns.data.where((
                          element) => element.isPt == 1).toList()[0].name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700))
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Text(
                      '${gymStore.selectedGymAddOns.data.where((
                          element) => element.isPt == 1).toList()[0]
                          .description}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400))),
              SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                  if (gymStore.activeSubscriptions != null &&
                      gymStore.activeSubscriptions.data != null) {
                    gymStore.setAddOnSlot(
                      context: context,
                      data: gymStore.selectedGymAddOns.data
                          .where((element) => element.isPt == 1)
                          .toList()[0],
                    );
                    NavigationService.navigateTo(
                      Routes.ptIntro,
                    );
                  } else {
                    FlashHelper.informationBar(
                      context,
                      message:
                      'In order to buy PT, First you need to Buy Membership of this gym first',
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(8)),
                      color: Colors.white),
                  child: Text('Book Now',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ],
    )
        : SizedBox(
      height: 0,
    );
  }
}

//Live Session at gym
class GymLiveWidget extends StatefulWidget {
  final String gymId;
  const GymLiveWidget({
    Key key,
    this.gymId
  }) : super(key: key);

  @override
  State<GymLiveWidget> createState() => _GymLiveWidgetState();
}

class _GymLiveWidgetState extends State<GymLiveWidget> {

  GymStore gymStore;
  bool callMethod = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    gymStore = context.watch<GymStore>();
  }

  void callData() {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        gymStore.getAddOnForGym(context: context,gymId: widget.gymId);
      }
    });
  }

  List<AddOnData> getData(List<AddOnData> data) =>
      data.where((element) => element.isLive).toList();

  @override
  Widget build(BuildContext context) {
    callData();

    return Consumer<GymStore>(builder: (context, gymStore, child) {
      if (gymStore.selectedGymAddOns == null ||
          gymStore.selectedGymAddOns.data == null) {
        return Loading();
      } else if (getData(gymStore.selectedGymAddOns.data).isNotEmpty &&
          gymStore.selectedGymAddOns.data != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Train Live from Your co_space',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontStyle: FontStyle.normal)),
            SizedBox(height: 12),
            Container(
              color: Color(0xff277B30),
              padding: EdgeInsets.all(8),
              child: Text('Starting only at 99',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white)),
            ),
            SizedBox(height: 16),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: getData(gymStore.selectedGymAddOns.data)
                      .map((item) =>
                      Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          width: 118,
                          child: Column(
                            children: [
                              Container(
                                width: 118,
                                height: 76,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8)),
                                      color: Colors.transparent,
                                    ),
                                    child: Image.network(
                                      item.image ??
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwcUlbvtXLjiLOIREI6GlAW7xLjoiYMqoeMg&usqp=CAU',
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                      loadingBuilder: (context, _, chunk) =>
                                      chunk == null
                                          ? _
                                          : RectangleShimmering(
                                        height: 76,
                                        width: double.infinity,
                                        radius: 16.0,
                                      ),
                                    ),
                                    // height: 350.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text('${item.name ?? ''}'),
                              SizedBox(height: 6),
                              InkWell(
                                onTap: () {
                                  gymStore.setAddOnSlot(
                                    context: context,
                                    data: item,
                                    getTrainers: true,
                                  );
                                  NavigationService.navigateTo(
                                    Routes.chooseSlotScreen,
                                  );
                                },
                                child: Container(
                                  width: 118,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      left: 14,
                                      right: 14,
                                      bottom: 6,
                                      top: 6),
                                  decoration: BoxDecoration(
                                      color: AppConstants.boxBorderColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2))),
                                  child: Text('Book now'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    }
      // gymStore.selectedGymAddOns!=null&& gymStore.selectedGymAddOns.data != null&&gymStore.selectedGymAddOns.data.isNotEmpty?getData(gymStore.selectedGymAddOns.data).isNotEmpty
      //
      //         ? Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text('Train Live from Your co_space',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w600,
      //                       fontSize: 14,
      //                       fontStyle: FontStyle.normal)),
      //               SizedBox(height: 12),
      //               Container(
      //                 color: Color(0xff277B30),
      //                 padding: EdgeInsets.all(8),
      //                 child: Text('Starting only at 99',
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w300,
      //                         color: Colors.white)),
      //               ),
      //               SizedBox(height: 16),
      //               Container(
      //                 child: SingleChildScrollView(
      //                   scrollDirection: Axis.horizontal,
      //                   child: Row(
      //                     children: getData(gymStore.selectedGymAddOns.data)
      //                         .map((item) => Container(
      //                               padding: EdgeInsets.only(left: 8, right: 8),
      //                               child: Container(
      //                                 width: 118,
      //                                 child: Column(
      //                                   children: [
      //                                     Container(
      //                                       width: 118,
      //                                       height: 76,
      //                                       child: ClipRRect(
      //                                         borderRadius: BorderRadius.only(
      //                                             topRight: Radius.circular(8),
      //                                             topLeft: Radius.circular(8)),
      //                                         child: Container(
      //                                           decoration: BoxDecoration(
      //                                             borderRadius:
      //                                                 BorderRadius.only(
      //                                                     topRight: Radius
      //                                                         .circular(8),
      //                                                     topLeft:
      //                                                         Radius.circular(
      //                                                             8)),
      //                                             color: Colors.transparent,
      //                                           ),
      //                                           child: Image.network(
      //                                             item.image ??
      //                                                 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwcUlbvtXLjiLOIREI6GlAW7xLjoiYMqoeMg&usqp=CAU',
      //                                             width: double.infinity,
      //                                             fit: BoxFit.fill,
      //                                             height: double.infinity,
      //                                             loadingBuilder: (context, _,
      //                                                     chunk) =>
      //                                                 chunk == null
      //                                                     ? _
      //                                                     : RectangleShimmering(
      //                                                         width: double
      //                                                             .infinity,
      //                                                         radius: 16.0,
      //                                                       ),
      //                                           ),
      //                                           // height: 350.0,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     SizedBox(height: 6),
      //                                     Text('${item.name ?? ''}'),
      //                                     SizedBox(height: 6),
      //                                     InkWell(
      //                                       onTap: () {
      //                                         gymStore.setAddOnSlot(
      //                                           context: context,
      //                                           data: item,
      //                                           getTrainers: true,
      //                                         );
      //                                         NavigationService.navigateTo(
      //                                           Routes.chooseSlotScreen,
      //                                         );
      //                                       },
      //                                       child: Container(
      //                                         width: 118,
      //                                         alignment: Alignment.center,
      //                                         padding: EdgeInsets.only(
      //                                             left: 14,
      //                                             right: 14,
      //                                             bottom: 6,
      //                                             top: 6),
      //                                         decoration: BoxDecoration(
      //                                             color: AppConstants
      //                                                 .boxBorderColor,
      //                                             borderRadius:
      //                                                 BorderRadius.all(
      //                                                     Radius.circular(8))),
      //                                         child: Text('Book now'),
      //                                       ),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ))
      //                         .toList(),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           )
      //         : SizedBox(width:0)
      //     : Loading(),
    );
  }

}

//Free Session at gym
class GymAddonWidget extends StatelessWidget {
  const GymAddonWidget({
    Key key,
  }) : super(key: key);

  //&& element.isPt == 0
  List<AddOnData> getData(List<AddOnData> data) =>
      data
          .where((element) =>
      !element.isLive &&
          element.isPt == 0 &&
          element.freeSession == 'false')
          .toList();

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(builder: (context, gymStore, child) {
      if (gymStore.selectedGymAddOns == null ||
          gymStore.selectedGymAddOns.data == null) {
        return Loading();
      } else if (getData(gymStore.selectedGymAddOns.data).isNotEmpty &&
          gymStore.selectedGymAddOns.data != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fun Session at GYM',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontStyle: FontStyle.normal)),
            SizedBox(height: 12),
            Container(
              color: Color(0xff27447B),
              padding: EdgeInsets.all(8),
              child: Text('Starting only at 99',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white)),
            ),
            SizedBox(height: 16),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: getData(gymStore.selectedGymAddOns.data)
                      .map((item) =>
                      Container(
                        width: 118,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          children: [
                            Container(
                              width: 118,
                              height: 76,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8)),
                                    color: Colors.transparent,
                                  ),
                                  child: Image.network(
                                    item.image ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwcUlbvtXLjiLOIREI6GlAW7xLjoiYMqoeMg&usqp=CAU',
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    height: double.infinity,
                                    loadingBuilder: (context, _, chunk) =>
                                    chunk == null
                                        ? _
                                        : RectangleShimmering(
                                      width: double.infinity,
                                      radius: 16.0,
                                    ),
                                  ),
                                  // height: 350.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text('${item.name ?? ''}'),
                            SizedBox(height: 6),
                            InkWell(
                              onTap: () {
                                gymStore.setAddOnSlot(
                                  context: context,
                                  data: item,
                                  getTrainers: true,
                                );
                                NavigationService.navigateTo(
                                  Routes.chooseSlotScreen,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 14, right: 14, bottom: 6, top: 6),
                                decoration: BoxDecoration(
                                    color: AppConstants.boxBorderColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(2))),
                                child: Text('Book now'),
                              ),
                            )
                          ],
                        ),
                      ))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    }
      // builder: (context, gymStore, child) => gymStore.selectedGymAddOns != null
      //     ? gymStore.selectedGymAddOns.data != null &&
      //             gymStore.selectedGymAddOns.data.isNotEmpty &&
      //             gymStore.selectedGymAddOns.data
      //                     .where((e) =>
      //                         e.isPt == 0 && e.price != '0' && !e.isLive)
      //                     .toList()
      //                     .length >
      //                 0
      //         ? Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text('Fun Session at GYM',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w600,
      //                       fontSize: 14,
      //                       fontStyle: FontStyle.normal)),
      //               SizedBox(height: 12),
      //               Container(
      //                 color: Color(0xff27447B),
      //                 padding: EdgeInsets.all(8),
      //                 child: Text('Starting only at 99',
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w300,
      //                         color: Colors.white)),
      //               ),
      //               SizedBox(height: 16),
      //               Container(
      //                 child: SingleChildScrollView(
      //                   scrollDirection: Axis.horizontal,
      //                   child: Row(
      //                     children: gymStore.selectedGymAddOns.data
      //                         .map((item) => Container(
      //                               width: 118,
      //                               padding: EdgeInsets.only(left: 8, right: 8),
      //                               child: Column(
      //                                 children: [
      //                                   Container(
      //                                     width: 118,
      //                                     height: 76,
      //                                     child: ClipRRect(
      //                                       borderRadius: BorderRadius.only(
      //                                           topRight: Radius.circular(8),
      //                                           topLeft: Radius.circular(8)),
      //                                       child: Container(
      //                                         decoration: BoxDecoration(
      //                                           borderRadius: BorderRadius.only(
      //                                               topRight:
      //                                                   Radius.circular(8),
      //                                               topLeft:
      //                                                   Radius.circular(8)),
      //                                           color: Colors.transparent,
      //                                         ),
      //                                         child: Image.network(
      //                                           item.image ??
      //                                               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwcUlbvtXLjiLOIREI6GlAW7xLjoiYMqoeMg&usqp=CAU',
      //                                           width: double.infinity,
      //                                           fit: BoxFit.fill,
      //                                           height: double.infinity,
      //                                           loadingBuilder: (context, _,
      //                                                   chunk) =>
      //                                               chunk == null
      //                                                   ? _
      //                                                   : RectangleShimmering(
      //                                                       width:
      //                                                           double.infinity,
      //                                                       radius: 16.0,
      //                                                     ),
      //                                         ),
      //                                         // height: 350.0,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   SizedBox(height: 6),
      //                                   Text('${item.name ?? ''}'),
      //                                   SizedBox(height: 6),
      //                                   InkWell(
      //                                     onTap: () {
      //                                       gymStore.setAddOnSlot(
      //                                         context: context,
      //                                         data: item,
      //                                         getTrainers: true,
      //                                       );
      //                                       NavigationService.navigateTo(
      //                                         Routes.chooseSlotScreen,
      //                                       );
      //                                     },
      //                                     child: Container(
      //                                       padding: EdgeInsets.only(
      //                                           left: 14,
      //                                           right: 14,
      //                                           bottom: 6,
      //                                           top: 6),
      //                                       decoration: BoxDecoration(
      //                                           color:
      //                                               AppConstants.boxBorderColor,
      //                                           borderRadius: BorderRadius.all(
      //                                               Radius.circular(8))),
      //                                       child: Text('Book now'),
      //                                     ),
      //                                   )
      //                                 ],
      //                               ),
      //                             ))
      //                         .toList(),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           )
      //         : SizedBox(width: 0,)
      //     : Loading(),
    );
  }
}

class TextIconCard extends StatelessWidget {
  const TextIconCard({
    Key key,
    this.text,
    this.icon,
    this.bgColor = Colors.black,
    this.textColor = Colors.white,
    this.isSvg = false,
  }) : super(key: key);

  final String text;
  final String icon;
  final Color bgColor;
  final Color textColor;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: isSvg
                ? SvgPicture.asset(
              icon,
              width: 36.0,
              height: 36.0,
            )
                : icon.startsWith('http')
                ? Image.network(
              icon,
              color: textColor,
              width: 36.0,
              height: 36.0,
            )
                : Image.asset(
              icon,
              width: 36.0,
              height: 36.0,
            ),
          ),
          UIHelper.verticalSpace(6.0),
          Expanded(
            flex: 1,
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BookLiveWidget extends StatelessWidget {
  const BookLiveWidget({
    Key key,
  }) : super(key: key);

  List<AddOnData> getData(List<AddOnData> data) =>
      data.where((element) => element.isLive && element.isPt == 0).toList();

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.watch<GymStore>();
    return gymStore.selectedGymAddOns.data == null ||
        gymStore.selectedGymAddOns == null
        ? Container()
        : Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: gymStore.selectedGymAddOns.data
          .where((element) =>
      element.isLive != null && element.isLive == true)
          .toList()
          .length >
          0
          ? EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 2.0,
      )
          : EdgeInsets.zero,
      color: Colors.grey[800],
      child: gymStore.selectedGymAddOns.data
          .where((element) =>
      element.isLive != null && element.isLive == true)
          .toList()
          .length >
          0
          ? Column(
        children: [
          Text(
            gymStore.selectedGymAddOns.data
                .where((element) =>
            element.isLive != null &&
                element.isLive == true)
                .toList()[0]
                .name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          UIHelper.verticalSpace(8.0),
          Text(
            gymStore.selectedGymAddOns.data
                .where((element) =>
            element.isLive != null &&
                element.isLive == true)
                .toList()[0]
                .description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (gymStore.activeSubscriptions != null &&
                  gymStore.activeSubscriptions.data != null) {
                gymStore.setAddOnSlot(
                  context: context,
                  data: gymStore.selectedGymAddOns.data
                      .where((element) =>
                  element.isLive != null &&
                      element.isLive == true)
                      .toList()[0],
                );
                NavigationService.navigateTo(
                  Routes.ptIntro,
                );
              } else {
                FlashHelper.informationBar(
                  context,
                  message:
                  'In order to buy Live Training sessions, First you need to Buy Membership of this gym first',
                );
              }
            },
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Book Live Training',
                    // '${gymStore.selectedGymAddOns.data .where((element) => element.isLive != null && element.isLive == true).toList()[0].name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : Container(),
    );
  }
}

class RenewMembership extends StatelessWidget {
  const RenewMembership({
    Key key,
    @required this.gymId,
  }) : super(key: key);

  final String gymId;

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.watch<GymStore>();
    return InkWell(
      onTap: () {
        gymStore.getGymPlans(
          gymId: gymId,
          context: context,
        );
        gymStore.setRenew(true);
        NavigationService.navigateTo(
          Routes.gymMembershipPlanPage,
        );
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 8, bottom: 8, left: 12, right: 12),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(4)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff490000),
                Color(0xffBA1406),
              ],
            )),
        alignment: Alignment.center,
        child: Text(
          'Renew membership now',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
      ),
    );
    // return Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 15),
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: 6,
    //           ),
    //           Divider(
    //             color: Colors.white70,
    //             thickness: 1,
    //           ),
    //           SizedBox(
    //             height: 6,
    //           ),
    //           Text(
    //             'Renew Membership',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontWeight: FontWeight.bold,
    //               fontSize: 20,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 8,
    //           ),
    //           Text('If you are looking to renew your membership\nclick here',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                   color: Colors.white,
    //
    //                   // fontWeight: FontWeight.bold,
    //                   fontSize: 13)),
    //           SizedBox(
    //             height: 15,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               gymStore.getGymPlans(
    //                 gymId: gymId,
    //                 context: context,
    //               );
    //               gymStore.setRenew(true);
    //               NavigationService.navigateTo(
    //                 Routes.membershipPlanPage,
    //               );
    //             },
    //             child: Container(
    //               padding: EdgeInsets.only(
    //                   top: 8, bottom: 8, left: 12, right: 12),
    //               decoration: BoxDecoration(
    //                   borderRadius:
    //                   BorderRadius.all(Radius.circular(4)),
    //                   gradient: LinearGradient(
    //                     begin: Alignment.topLeft,
    //                     end: Alignment.bottomRight,
    //                     colors: [
    //                       Color(0xff490000),
    //                       Color(0xffBA1406),
    //                     ],
    //                   )),
    //               alignment: Alignment.center,
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 // crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     'renew membership now'.toUpperCase(),
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 6,
    //           ),
    //           Divider(
    //             color: Colors.white70,
    //             thickness: 1,
    //           ),
    //           SizedBox(
    //             height: 6,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}

class AddonCard extends StatelessWidget {
  final AddOnData data;

  const AddonCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(builder: (context, gymStore, child) {
      return InkWell(
        onTap: () {
          gymStore.setAddOnSlot(
            context: context,
            data: data,
            getTrainers: true,
          );
          NavigationService.navigateTo(
            Routes.chooseSlotScreen,
          );
        },
        child: Container(
          height: 120,
          width: 250,
          margin: EdgeInsets.only(left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          // padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  data.name ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              UIHelper.verticalSpace(6.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Price Starts ",
                    ),
                    TextSpan(
                      text: "from",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "\u20B9 ${data.price}",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                child: Text(
                  'Book Session',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class GoldMembership extends StatelessWidget {
  const GoldMembership({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 14.0,
            ),
          ),
          UIHelper.verticalSpace(2.0),
          ShaderMask(
            blendMode: BlendMode.srcATop, // Add this
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: <Color>[
                  Color(0xffFFD700),
                  Colors.red.withOpacity(0.5),
                ],
                end: Alignment.center,
                begin: Alignment.center,
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: const Text(
              'GOLD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          UIHelper.verticalSpace(2.0),
          Text(
            'Membership',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
