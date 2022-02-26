import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:wtf/screen/event/EventDetails.dart';
import 'package:wtf/widget/BenefitsSection.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';
import 'package:wtf/widget/auto_image_slider.dart';
import 'package:wtf/widget/processing_dialog.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/slide_button.dart';

class BuyMemberShipPage extends StatefulWidget {
  final String gymId;

  const BuyMemberShipPage({this.gymId});

  @override
  _BuyMemberShipPageState createState() => _BuyMemberShipPageState();
}

class _BuyMemberShipPageState extends State<BuyMemberShipPage> {
  // Local Variables :D
  bool show = false;
  bool scrollOrNot = true;
  final bool isPreview = false;
  GymStore gymStore;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    gymStore.setGymDetails(data: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GymStore>(
        builder: (context, gymStore, child) => gymStore.selectedGymDetail ==
            null
            ? LoadingWithBackground()
            : gymStore.selectedGymDetail.status
            ? Scaffold(
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 16,right: 16,top: 6,bottom: 6),
            constraints: BoxConstraints(
                minHeight: 54,maxHeight: 60
            ),
            child: Row(
              children: [
                Expanded(child: InkWell(
                  onTap:()async{
                    if (gymStore.activeSubscriptions ==
                        null ||
                        (gymStore.activeSubscriptions !=
                            null &&
                            gymStore.activeSubscriptions
                                .data ==
                                null)) {
                      gymStore
                          .getGymPlans(
                        gymId: gymStore
                            .selectedGymDetail
                            .data
                            .userId,
                        context: context,
                      );

                      NavigationService
                          .navigateTo(
                        Routes
                            .membershipPlanPage,
                      );
                    } else {
                      String selection =
                      await showDialog<
                          String>(
                        context: context,
                        barrierDismissible:
                        true,
                        builder: (context) =>
                            SubscriptionAlreadyPresent(
                              cancelTapped:
                                  () {
                                Navigator.pop(
                                    context,
                                    'no');
                              },
                              nextTapped: () {
                                Navigator.pop(
                                    context,
                                    'yes');
                              },
                              gymName: gymStore
                                  .activeSubscriptions
                                  .data
                                  .gymName,
                            ),
                      );
                      if (selection !=
                          null &&
                          selection ==
                              'yes') {
                        gymStore
                            .getGymPlans(
                          gymId: gymStore
                              .selectedGymDetail
                              .data
                              .userId,
                          context:
                          context,
                        );
                        NavigationService
                            .navigateTo(
                          Routes
                              .membershipPlanPage,
                        );
                      }
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff490000),
                              Color(0xffBA1406),
                            ],
                          )),
                      alignment: Alignment.center,
                      child:Text('Buy Membership')
                  ),
                ),),SizedBox(width:12),
                Expanded(child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border:Border.all(width:2,color: AppConstants.tabBg)
                    ),
                    alignment: Alignment.center,
                    child:Text('Book Free Trial',style:TextStyle(color:AppConstants.whitish))
                ),),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await context.read<GymStore>().getGymDetails(
                context: context,
                gymId: widget.gymId,
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
                  expandedHeight: 300.0,
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
                                  Color(0xff272727)
                                ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: '',
                                style:
                                DefaultTextStyle.of(context).style,
                                children: const <WidgetSpan>[
                                  WidgetSpan(
                                      child: Icon(
                                        Icons.directions_car,
                                        size: 18,
                                        color: AppConstants.green,
                                      )),
                                  WidgetSpan(
                                      child: Text(
                                          ' 15 Mins away | 1 Km',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.bold))),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: 12,
                                  right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)),
                                color: Color(0xffBA1406),
                              ),
                              child: Text('Direction',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: MyFlexiableAppBar(
                      images: gymStore.selectedGymDetail.data.gallery,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16,bottom: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Name and rating section :D
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text('Mass Monster',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontStyle: FontStyle.normal)),
                            subtitle: Text('Noida Sector 8, C Bloc'),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Rating',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(height: 6),
                                RatingBar(
                                    initialRating: 4,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 16,
                                    ratingWidget: RatingWidget(
                                      full: Icon(
                                        Icons.star,
                                        color: AppConstants.boxBorderColor,
                                      ),
                                      half: Icon(
                                        Icons.star_half,
                                        color: AppConstants.boxBorderColor,
                                      ),
                                      empty: Icon(
                                        Icons.star_border,
                                        color: AppConstants.white,
                                      ),
                                    ),
                                    itemPadding: EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    }),
                              ],
                            ),
                          ),
                          //Divider :D
                          Divider(
                            thickness: 2,
                            color: AppConstants.headingTextColor,
                          ),
                          //Description :D
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text('Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal)),
                            subtitle: Text(
                                '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim lacus curabitur massa sed. At maecenas nibh aliquet ipsum gravida massa turpis. Id duis consequat urna, pulvinar erat fusce sed lacus, eu. Ornare ullamcorper dictum diam ipsum volutpat dignissim purus, varius at. A, commodo amet sed mattis augue luctus quam.'),
                          ),
                          SizedBox(height: 24),
                          //Facility Section :D
                          Text('Facilities',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal)),
                          SizedBox(height: 12),
                          //Facility List :D
                          Container(
                            padding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 8, right: 8),
                            decoration: BoxDecoration(
                                color: AppConstants.bgColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: facilityItems(),
                              ),
                            ),
                          ),
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
                              whyWTF('Earn WTF rewards coin'),
                              whyWTF('Fully Vaccinated Staff'),
                              whyWTF('Track Fitness Journey'),
                              whyWTF('Pocket Friendly Membership'),
                              whyWTF('Free diet Support'),
                              whyWTF('Top Class Ambiance'),
                            ],
                          ),
                          SizedBox(height: 24),
                          Text('Train Live from Yout co_space',
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
                          //CoSpace section :D
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: coSpaceWidget(),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
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
                          //CoSpace section :D
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: coSpaceWidget(),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
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
          ),
        ),
      ),
    );
  }

  Widget whyWTF(String label) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff490000),
              Color(0xffBA1406),
            ],
          )),
      child: Column(
        children: [
          Image.asset(
            'assets/images/my_wtf.png',
            width: 60,
            height: 60,
          ),
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

  //Facility List Widget :D
  List<Widget> facilityItems() => FacilityModel.getList()
      .map((item) => Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                Image.asset(item.imagePath),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ))
      .toList();

  List<Widget> coSpaceWidget()=> CoSpaceModel.getList()
      .map((item) => Container(
    padding: EdgeInsets.only(left: 8, right: 8),
    child: Column(
      children: [
        Container(
          width: 118,
            height: 76,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                  color: Colors.transparent,
                ),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwcUlbvtXLjiLOIREI6GlAW7xLjoiYMqoeMg&usqp=CAU',
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  loadingBuilder: (context, _, chunk) => chunk == null
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
        SizedBox(height:6),
        InkWell(
          onTap:(){},
          child: Container(
            padding: EdgeInsets.only(left:14,right:14,bottom: 6,top: 6),
            decoration: BoxDecoration(
              color: AppConstants.boxBorderColor,
              borderRadius:BorderRadius.all(Radius.circular(8))
            ),
            child: Text('Book now'),
          ),
        )
      ],
    ),
  ))
      .toList();

  Widget abc() {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SafeArea(
        child: Consumer<GymStore>(
          builder: (context, gymStore, child) => gymStore.selectedGymDetail ==
                  null
              ? LoadingWithBackground()
              : gymStore.selectedGymDetail.status
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await context.read<GymStore>().getGymDetails(
                              context: context,
                              gymId: widget.gymId,
                            );
                      },
                      color: AppConstants.primaryColor,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  AutoImageSlider(
                                    mainContainerHeight:
                                        MediaQuery.of(context).size.height /
                                            2.3,
                                    childContainerHeight:
                                        MediaQuery.of(context).size.height /
                                            2.28,
                                    items: gymStore
                                        .selectedGymDetail.data.gallery
                                        .map((e) => e.images != null
                                            ? e.images.replaceAll(
                                                'https://wtfupme-images-1435.s3.ap-south-1.amazonaws.com',
                                                'https://d1e9q0asw0l2kk.cloudfront.net')
                                            : 'https://www.mensjournal.com/wp-content/uploads/2018/05/1380-dumbbell-curl1.jpg?quality=86&strip=all')
                                        .toList(),
                                    dotSize: 2.0,
                                    activeMarkerColor: Colors.red,
                                    inActiveMarkerColor: Colors.black,
                                    markerType: PositionMarkerType.dots,
                                    positionedMarker: true,
                                    showDelete: false,
                                    showBorderDots: true,
                                    autoScroll: false,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                gymStore.selectedGymDetail.data
                                                    .gymName,
                                                // 'WTF Team Core',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Consumer<GymStore>(
                                                builder: (context, gymStore,
                                                        child) =>
                                                    gymStore.isSelectedGymSubscribed
                                                        ? InkWell(
                                                            onTap: () {
                                                              final _dialog =
                                                                  RatingDialog(
                                                                // your app's name?
                                                                title:
                                                                    'Rate ${gymStore.selectedGymDetail.data.gymName}',
                                                                // encourage your user to leave a high rating?
                                                                message:
                                                                    'Tap a star to set your rating. Add more description here if you want.',
                                                                // your app's logo?
                                                                image:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/logo/wtf_dark.png'),
                                                                    ),
                                                                  ),
                                                                ),

                                                                submitButton:
                                                                    'Submit',
                                                                ratingColor:
                                                                    Colors.red,
                                                                onCancelled:
                                                                    () => print(
                                                                        'cancelled'),
                                                                onSubmitted:
                                                                    (response) {
                                                                  print(
                                                                      'rating: ${response.rating}, comment: ${response.comment}');
                                                                  gymStore
                                                                      .giveGymFeedback(
                                                                    context:
                                                                        context,
                                                                    comment:
                                                                        response
                                                                            .comment,
                                                                    stars: double.tryParse(
                                                                        response
                                                                            .rating
                                                                            .toString()),
                                                                  );
                                                                },
                                                              );

// show the dialog
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    true,
                                                                builder:
                                                                    (context) =>
                                                                        _dialog,
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '✩✩✩✩✩ Rate us',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          gymStore.selectedGymDetail.data
                                              .description,
                                          // "Being physically and mentally is necessary for an individual to liva a happy, long life. Typically exercise is one of the best way to keep person healthy, hence no metter how busy you are, it always best to find time to do a workout routine.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: LayoutBuilder(
                                  builder: (context, constraints) => Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Text(
                                                          "${gymStore.selectedGymDetail.data.address1}, ${gymStore.selectedGymDetail.data.address2}",
                                                          // 'Sector 12 Dwarka(New Delhi)',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.5)),
                                                    ),
                                                    Spacer(),
                                                    Consumer<GymStore>(
                                                      builder: (context,
                                                              gymStore,
                                                              child) =>
                                                          gymStore.isSelectedGymSubscribed
                                                              ? GoldMembership()
                                                              : Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0,
                                                ),
                                                child: GetDirectionButton(
                                                  lat: double.tryParse(
                                                    gymStore.selectedGymDetail
                                                        .data.latitude,
                                                  ),
                                                  lng: double.tryParse(
                                                    gymStore.selectedGymDetail
                                                        .data.longitude,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Divider(
                                            color: Colors.white70,
                                            thickness: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (gymStore.selectedGymDetail
                                                            .data.benefits !=
                                                        null &&
                                                    gymStore
                                                        .selectedGymDetail
                                                        .data
                                                        .benefits
                                                        .isNotEmpty)
                                                  Text(
                                                    "Benefits",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                if (gymStore.selectedGymDetail
                                                            .data.benefits !=
                                                        null &&
                                                    gymStore
                                                        .selectedGymDetail
                                                        .data
                                                        .benefits
                                                        .isNotEmpty)
                                                  BenefitsSection(),
                                                if (gymStore.selectedGymDetail
                                                            .data.benefits !=
                                                        null &&
                                                    gymStore
                                                        .selectedGymDetail
                                                        .data
                                                        .benefits
                                                        .isNotEmpty)
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                if (gymStore.selectedGymDetail
                                                            .data.benefits !=
                                                        null &&
                                                    gymStore
                                                        .selectedGymDetail
                                                        .data
                                                        .benefits
                                                        .isNotEmpty)
                                                  Divider(
                                                    color: Colors.white70,
                                                    thickness: 1,
                                                  ),
                                                SizedBox(
                                                  height: 6,
                                                ),

                                                // Book Free session Container
                                              ],
                                            ),
                                          ),
                                          if (gymStore.selectedGymAddOns !=
                                                  null &&
                                              gymStore.selectedGymAddOns.data !=
                                                  null &&
                                              gymStore.selectedGymAddOns.data
                                                  .isNotEmpty &&
                                              !gymStore
                                                  .isSelectedGymSubscribed &&
                                              gymStore.showTrailOffer)
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: gymStore
                                                          .selectedGymAddOns
                                                          .data
                                                          .where((element) =>
                                                              element.price ==
                                                              '0')
                                                          .toList()
                                                          .length >
                                                      0
                                                  ? EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 2.0,
                                                    )
                                                  : EdgeInsets.zero,
                                              color: Colors.grey[800],
                                              child: gymStore.selectedGymAddOns
                                                          .data
                                                          .where((element) =>
                                                              element.price ==
                                                              '0')
                                                          .toList()
                                                          .length >
                                                      0
                                                  ? Column(
                                                      children: [
                                                        Text(
                                                          gymStore
                                                              .selectedGymAddOns
                                                              .data
                                                              .where((element) =>
                                                                  element
                                                                      .price ==
                                                                  '0')
                                                              .toList()[0]
                                                              .name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                        UIHelper.verticalSpace(
                                                            8.0),
                                                        Text(
                                                          gymStore
                                                              .selectedGymAddOns
                                                              .data
                                                              .where((element) =>
                                                                  element
                                                                      .price ==
                                                                  '0')
                                                              .toList()[0]
                                                              .description,
                                                          textAlign:
                                                              TextAlign.center,
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
                                                            gymStore
                                                                .setAddOnSlot(
                                                              context: context,
                                                              data: gymStore
                                                                  .selectedGymAddOns
                                                                  .data
                                                                  .where((element) =>
                                                                      element
                                                                          .price ==
                                                                      '0')
                                                                  .toList()[0],
                                                              isFree: true,
                                                            );
                                                            // gymStore.getSlotDetails(
                                                            //   context: context,
                                                            //   date: Helper.formatDate2(
                                                            //     DateTime.now()
                                                            //         .toIso8601String(),
                                                            //   ),
                                                            //   addOnId: gymStore
                                                            //       .selectedAddOnSlot.uid,
                                                            //   trainerId: null,
                                                            // );
                                                            // NavigationService.navigateTo(
                                                            //   Routes.chooseSlotScreenAddon,
                                                            // );
                                                            NavigationService
                                                                .navigateTo(
                                                              Routes
                                                                  .chooseSlotScreen,
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 10,
                                                              vertical: 8,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppConstants
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  'Book Free Session',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                            ),
                                          UIHelper.verticalSpace(10.0),
                                          Consumer<GymStore>(
                                            builder: (context, store, child) =>
                                                store.whyChooseWtf != null
                                                    ? store.whyChooseWtf.data !=
                                                                null &&
                                                            store.whyChooseWtf
                                                                .data.isNotEmpty
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 4,
                                                                ),
                                                              ),
                                                            ),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            child: Column(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "Why Choose WTF?",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 13,
                                                                ),
                                                                Wrap(
                                                                  runSpacing:
                                                                      12.0,
                                                                  spacing: 12.0,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .start,
                                                                  children: store
                                                                      .whyChooseWtf
                                                                      .data
                                                                      .map((e) => whyChooseWTFItems(
                                                                          e.name,
                                                                          e.icon))
                                                                      .toList(),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container()
                                                    : Loading(),
                                          ),
                                          // Book Session
                                          if (gymStore.selectedGymAddOns !=
                                                  null &&
                                              gymStore.selectedGymAddOns.data !=
                                                  null &&
                                              gymStore.selectedGymAddOns.data
                                                  .isNotEmpty)
                                            BookPTWidget(),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          GymLiveWidget(),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          GymAddonWidget(),
                                          // Gymnastic
                                          Consumer<GymStore>(
                                            builder: (context, gymStore,
                                                    child) =>
                                                gymStore.isSelectedGymSubscribed
                                                    ? RenewMembership(
                                                        gymId: widget.gymId,
                                                      )
                                                    : SlideButton(
                                                        text:
                                                            "Buy your membership",
                                                        onTap: () async {
                                                          if (gymStore.activeSubscriptions ==
                                                                  null ||
                                                              (gymStore.activeSubscriptions !=
                                                                      null &&
                                                                  gymStore.activeSubscriptions
                                                                          .data ==
                                                                      null)) {
                                                            gymStore
                                                                .getGymPlans(
                                                              gymId: gymStore
                                                                  .selectedGymDetail
                                                                  .data
                                                                  .userId,
                                                              context: context,
                                                            );

                                                            NavigationService
                                                                .navigateTo(
                                                              Routes
                                                                  .membershipPlanPage,
                                                            );
                                                          } else {
                                                            String selection =
                                                                await showDialog<
                                                                    String>(
                                                              context: context,
                                                              barrierDismissible:
                                                                  true,
                                                              builder: (context) =>
                                                                  SubscriptionAlreadyPresent(
                                                                cancelTapped:
                                                                    () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      'no');
                                                                },
                                                                nextTapped: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      'yes');
                                                                },
                                                                gymName: gymStore
                                                                    .activeSubscriptions
                                                                    .data
                                                                    .gymName,
                                                              ),
                                                            );
                                                            if (selection !=
                                                                    null &&
                                                                selection ==
                                                                    'yes') {
                                                              gymStore
                                                                  .getGymPlans(
                                                                gymId: gymStore
                                                                    .selectedGymDetail
                                                                    .data
                                                                    .userId,
                                                                context:
                                                                    context,
                                                              );
                                                              NavigationService
                                                                  .navigateTo(
                                                                Routes
                                                                    .membershipPlanPage,
                                                              );
                                                            }
                                                          }
                                                          // NavigationService.navigateTo(Routes.scheduleSlotPage);
                                                        },
                                                      ),
                                          ),
                                          // Gymnastic
                                          // Buy memberShip button
                                        ],
                                      ),
                                      if (gymStore
                                              .selectedGymDetail.data.status ==
                                          'inactive')
                                        ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 6.0,
                                              sigmaY: 6.0,
                                            ),
                                            child: Opacity(
                                              opacity: 0.01,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Flexible(
                                                              flex: 2,
                                                              child: Text(
                                                                  "${gymStore.selectedGymDetail.data.address1}, ${gymStore.selectedGymDetail.data.address2}",
                                                                  // 'Sector 12 Dwarka(New Delhi)',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 4,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12.5)),
                                                            ),
                                                            Spacer(),
                                                            Consumer<GymStore>(
                                                              builder: (context,
                                                                      gymStore,
                                                                      child) =>
                                                                  gymStore.isSelectedGymSubscribed
                                                                      ? GoldMembership()
                                                                      : Container(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 8.0,
                                                        ),
                                                        child:
                                                            GetDirectionButton(
                                                          lat: double.tryParse(
                                                            gymStore
                                                                .selectedGymDetail
                                                                .data
                                                                .latitude,
                                                          ),
                                                          lng: double.tryParse(
                                                            gymStore
                                                                .selectedGymDetail
                                                                .data
                                                                .longitude,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Divider(
                                                    color: Colors.white70,
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                      vertical: 10,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (gymStore
                                                                    .selectedGymDetail
                                                                    .data
                                                                    .benefits !=
                                                                null &&
                                                            gymStore
                                                                .selectedGymDetail
                                                                .data
                                                                .benefits
                                                                .isNotEmpty)
                                                          Text(
                                                            "Benefits",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        if (gymStore
                                                                    .selectedGymDetail
                                                                    .data
                                                                    .benefits !=
                                                                null &&
                                                            gymStore
                                                                .selectedGymDetail
                                                                .data
                                                                .benefits
                                                                .isNotEmpty)
                                                          BenefitsSection(),
                                                        if (gymStore
                                                                    .selectedGymDetail
                                                                    .data
                                                                    .benefits !=
                                                                null &&
                                                            gymStore
                                                                .selectedGymDetail
                                                                .data
                                                                .benefits
                                                                .isNotEmpty)
                                                          SizedBox(
                                                            height: 6,
                                                          ),
                                                        if (gymStore
                                                                    .selectedGymDetail
                                                                    .data
                                                                    .benefits !=
                                                                null &&
                                                            gymStore
                                                                .selectedGymDetail
                                                                .data
                                                                .benefits
                                                                .isNotEmpty)
                                                          Divider(
                                                            color:
                                                                Colors.white70,
                                                            thickness: 1,
                                                          ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),

                                                        // Book Free session Container
                                                      ],
                                                    ),
                                                  ),
                                                  if (gymStore.selectedGymAddOns != null &&
                                                      gymStore.selectedGymAddOns
                                                              .data !=
                                                          null &&
                                                      gymStore.selectedGymAddOns
                                                          .data.isNotEmpty &&
                                                      !gymStore
                                                          .isSelectedGymSubscribed)
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: gymStore
                                                                  .selectedGymAddOns
                                                                  .data
                                                                  .where((element) =>
                                                                      element
                                                                          .price ==
                                                                      '0')
                                                                  .toList()
                                                                  .length >
                                                              0
                                                          ? EdgeInsets
                                                              .symmetric(
                                                              vertical: 15,
                                                              horizontal: 2.0,
                                                            )
                                                          : EdgeInsets.zero,
                                                      color: Colors.grey[800],
                                                      child: gymStore
                                                                  .selectedGymAddOns
                                                                  .data
                                                                  .where((element) =>
                                                                      element
                                                                          .price ==
                                                                      '0')
                                                                  .toList()
                                                                  .length >
                                                              0
                                                          ? Column(
                                                              children: [
                                                                Text(
                                                                  gymStore
                                                                      .selectedGymAddOns
                                                                      .data
                                                                      .where((element) =>
                                                                          element
                                                                              .price ==
                                                                          '0')
                                                                      .toList()[
                                                                          0]
                                                                      .name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                                UIHelper
                                                                    .verticalSpace(
                                                                        8.0),
                                                                Text(
                                                                  gymStore
                                                                      .selectedGymAddOns
                                                                      .data
                                                                      .where((element) =>
                                                                          element
                                                                              .price ==
                                                                          '0')
                                                                      .toList()[
                                                                          0]
                                                                      .description,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    gymStore
                                                                        .setAddOnSlot(
                                                                      context:
                                                                          context,
                                                                      data: gymStore
                                                                          .selectedGymAddOns
                                                                          .data
                                                                          .where((element) =>
                                                                              element.price ==
                                                                              '0')
                                                                          .toList()[0],
                                                                      isFree:
                                                                          true,
                                                                    );
                                                                    // gymStore.getSlotDetails(
                                                                    //   context: context,
                                                                    //   date: Helper.formatDate2(
                                                                    //     DateTime.now()
                                                                    //         .toIso8601String(),
                                                                    //   ),
                                                                    //   addOnId: gymStore
                                                                    //       .selectedAddOnSlot.uid,
                                                                    //   trainerId: null,
                                                                    // );
                                                                    // NavigationService.navigateTo(
                                                                    //   Routes.chooseSlotScreenAddon,
                                                                    // );
                                                                    NavigationService
                                                                        .navigateTo(
                                                                      Routes
                                                                          .chooseSlotScreen,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          8,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppConstants
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Text(
                                                                          'Book Free Session',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                    ),
                                                  UIHelper.verticalSpace(10.0),
                                                  Consumer<GymStore>(
                                                    builder: (context, store,
                                                            child) =>
                                                        store.whyChooseWtf !=
                                                                null
                                                            ? store.whyChooseWtf
                                                                            .data !=
                                                                        null &&
                                                                    store
                                                                        .whyChooseWtf
                                                                        .data
                                                                        .isNotEmpty
                                                                ? Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        top:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.black12,
                                                                          width:
                                                                              4,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            12),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            "Why Choose WTF?",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              13,
                                                                        ),
                                                                        Wrap(
                                                                          runSpacing:
                                                                              12.0,
                                                                          spacing:
                                                                              12.0,
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.start,
                                                                          children: store
                                                                              .whyChooseWtf
                                                                              .data
                                                                              .map((e) => whyChooseWTFItems(e.name, e.icon))
                                                                              .toList(),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container()
                                                            : Loading(),
                                                  ),
                                                  // Book Session
                                                  if (gymStore.selectedGymAddOns != null &&
                                                      gymStore.selectedGymAddOns
                                                              .data !=
                                                          null &&
                                                      gymStore.selectedGymAddOns
                                                          .data.isNotEmpty)
                                                    BookPTWidget(),
                                                  SizedBox(
                                                    height: 12.0,
                                                  ),
                                                  GymLiveWidget(),
                                                  SizedBox(
                                                    height: 12.0,
                                                  ),
                                                  GymAddonWidget(),
                                                  // Gymnastic
                                                  Consumer<GymStore>(
                                                    builder: (context, gymStore,
                                                            child) =>
                                                        gymStore.isSelectedGymSubscribed
                                                            ? RenewMembership(
                                                                gymId: widget
                                                                    .gymId,
                                                              )
                                                            : SlideButton(
                                                                text:
                                                                    "Buy your membership",
                                                                onTap:
                                                                    () async {
                                                                  if (gymStore.activeSubscriptions ==
                                                                          null ||
                                                                      (gymStore.activeSubscriptions !=
                                                                              null &&
                                                                          gymStore.activeSubscriptions.data ==
                                                                              null)) {
                                                                    gymStore
                                                                        .getGymPlans(
                                                                      gymId: gymStore
                                                                          .selectedGymDetail
                                                                          .data
                                                                          .userId,
                                                                      context:
                                                                          context,
                                                                    );
                                                                    NavigationService
                                                                        .navigateTo(
                                                                      Routes
                                                                          .membershipPlanPage,
                                                                    );
                                                                  } else {
                                                                    String
                                                                        selection =
                                                                        await showDialog<
                                                                            String>(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          true,
                                                                      builder:
                                                                          (context) =>
                                                                              SubscriptionAlreadyPresent(
                                                                        cancelTapped:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context,
                                                                              'no');
                                                                        },
                                                                        nextTapped:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context,
                                                                              'yes');
                                                                        },
                                                                        gymName: gymStore
                                                                            .activeSubscriptions
                                                                            .data
                                                                            .gymName,
                                                                      ),
                                                                    );
                                                                    if (selection !=
                                                                            null &&
                                                                        selection ==
                                                                            'yes') {
                                                                      gymStore
                                                                          .getGymPlans(
                                                                        gymId: gymStore
                                                                            .selectedGymDetail
                                                                            .data
                                                                            .userId,
                                                                        context:
                                                                            context,
                                                                      );
                                                                      NavigationService
                                                                          .navigateTo(
                                                                        Routes
                                                                            .membershipPlanPage,
                                                                      );
                                                                    }
                                                                  }
                                                                  // NavigationService.navigateTo(Routes.scheduleSlotPage);
                                                                },
                                                              ),
                                                  ),
                                                  // Gymnastic
                                                  // Buy memberShip button
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (gymStore
                                              .selectedGymDetail.data.status ==
                                          'inactive')
                                        Positioned(
                                          top: 120.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Center(
                                            child: Container(
                                              height: 140.0,
                                              child: Image.asset(
                                                  'assets/images/coming_soon.png'),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Gym not Found',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget whyChooseWTFItems(String text, String icon) {
    return TextIconCard(text: text, icon: icon);
  }
}

//Facility Model
class FacilityModel {
  String label;
  String imagePath;

  FacilityModel({this.label, this.imagePath});

  static List<FacilityModel> getList() => [
        FacilityModel(
            label: 'Modern\nEqipments',
            imagePath: 'assets/images/active_subscription.png'),
        FacilityModel(
            label: 'Modern\nEqipments',
            imagePath: 'assets/images/active_subscription.png'),
        FacilityModel(
            label: 'Modern\nEqipments',
            imagePath: 'assets/images/active_subscription.png'),
        FacilityModel(
            label: 'Modern\nEqipments',
            imagePath: 'assets/images/active_subscription.png'),
        FacilityModel(
            label: 'Modern\nEqipments',
            imagePath: 'assets/images/active_subscription.png'),
      ];
}

class CoSpaceModel{
  String imageUrl;
  CoSpaceModel();
  static List<CoSpaceModel> getList()=>[CoSpaceModel(),CoSpaceModel(),CoSpaceModel(),CoSpaceModel(),CoSpaceModel()];
}

class MyFlexiableAppBar extends StatelessWidget {
  final List<Gallery> images;
  final Color color;

  final double appBarHeight = 66.0;

  const MyFlexiableAppBar({this.images, this.color});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      color: color,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: CarouselSlider(
            options: CarouselOptions(
              height: 300.0,
              viewportFraction: 1,
              enlargeCenterPage: false,
              autoPlay: true,
              pageSnapping: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ),
            items: images.map(
              (i) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Builder(
                    builder: (BuildContext context) {
                      if (i.images == null) {
                        return Center(
                          child: Text("No image data"),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Image.network(
                          i.images,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, _, chunk) => chunk == null
                              ? _
                              : RectangleShimmering(
                                  width: double.infinity,
                                  height: 180.0,
                                ),
                        ),
                      );
                    },
                  ),
                );
              },
            ).toList()),
      ),
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

class BookPTWidget extends StatelessWidget {
  const BookPTWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.watch<GymStore>();
    return gymStore.addOnSubscriptions != null &&
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
        : Container(
            width: MediaQuery.of(context).size.width,
            padding: gymStore.selectedGymAddOns.data
                        .where((element) => element.isPt == '1')
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
                        .where((element) => element.isPt == '1')
                        .toList()
                        .length >
                    0
                ? Column(
                    children: [
                      Text(
                        gymStore.selectedGymAddOns.data
                            .where((element) => element.isPt == '1')
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
                            .where((element) => element.isPt == '1')
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
                                  .where((element) => element.isPt == '1')
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
                                'Book Personal Training',
                                // '${gymStore.selectedGymAddOns.data.where((element) => element.isPt == '1').toList()[0].name}',
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

class BookLiveWidget extends StatelessWidget {
  const BookLiveWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.watch<GymStore>();
    return Container(
      width: MediaQuery.of(context).size.width,
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
                          element.isLive != null && element.isLive == true)
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
                          element.isLive != null && element.isLive == true)
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 6,
              ),
              Divider(
                color: Colors.white70,
                thickness: 1,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Renew Membership',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('If you are looking to renew your membership\nclick here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,

                      // fontWeight: FontWeight.bold,
                      fontSize: 13)),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  gymStore.getGymPlans(
                    gymId: gymId,
                    context: context,
                  );
                  gymStore.setRenew(true);
                  NavigationService.navigateTo(
                    Routes.membershipPlanPage,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'renew membership now'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Divider(
                color: Colors.white70,
                thickness: 1,
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GymAddonWidget extends StatelessWidget {
  const GymAddonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          collapsedBackgroundColor: Colors.grey[800],
          iconColor: Colors.white,
          // tilePadding: EdgeInsets.zero,
          initiallyExpanded: true,
          controlAffinity: ListTileControlAffinity.platform,
          children: [
            Consumer<GymStore>(
              builder: (context, gymStore, child) =>
                  gymStore.selectedGymAddOns != null
                      ? gymStore.selectedGymAddOns.data != null &&
                              gymStore.selectedGymAddOns.data.isNotEmpty &&
                              gymStore.selectedGymAddOns.data
                                      .where((e) =>
                                          e.isPt == '0' &&
                                          e.price != '0' &&
                                          !e.isLive)
                                      .toList()
                                      .length >
                                  0
                          ? Container(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    gymStore.selectedGymAddOns.data.length,
                                itemBuilder: (context, index) {
                                  return gymStore.selectedGymAddOns.data[index]
                                                  .price ==
                                              '0' ||
                                          gymStore.selectedGymAddOns.data[index]
                                                  .isPt ==
                                              '1' ||
                                          gymStore.selectedGymAddOns.data[index]
                                              .isLive
                                      ? Container()
                                      : AddonCard(
                                          data: gymStore
                                              .selectedGymAddOns.data[index],
                                        );
                                },
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  'No ADDON Available',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            )
                      : Loading(),
            ),
          ],
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Book ${context.read<GymStore>().selectedGymDetail.data.gymName} Addons',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // Icon(
                  //   Icons.keyboard_arrow_up_sharp,
                  //   color: Colors.white,
                  //   size: 30,
                  // )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class GymLiveWidget extends StatelessWidget {
  const GymLiveWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          collapsedBackgroundColor: Colors.grey[800],
          iconColor: Colors.white,
          // tilePadding: EdgeInsets.zero,
          initiallyExpanded: true,
          controlAffinity: ListTileControlAffinity.platform,
          children: [
            Consumer<GymStore>(
              builder: (context, gymStore, child) =>
                  gymStore.selectedGymAddOns != null
                      ? gymStore.selectedGymAddOns.data != null &&
                              gymStore.selectedGymAddOns.data.isNotEmpty &&
                              gymStore.selectedGymAddOns.data
                                      .where((e) => e.isLive)
                                      .toList()
                                      .length >
                                  0
                          ? Container(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    gymStore.selectedGymAddOns.data.length,
                                itemBuilder: (context, index) {
                                  return gymStore
                                          .selectedGymAddOns.data[index].isLive
                                      ? AddonCard(
                                          data: gymStore
                                              .selectedGymAddOns.data[index],
                                        )
                                      : Container();
                                },
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  'No ADDON Available',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            )
                      : Loading(),
            ),
          ],
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Book ${context.read<GymStore>().selectedGymDetail.data.gymName} Live Sessions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // Icon(
                  //   Icons.keyboard_arrow_up_sharp,
                  //   color: Colors.white,
                  //   size: 30,
                  // )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
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
          // gymStore.getSlotDetails(
          //   context: context,
          //   date: Helper.formatDate2(
          //     DateTime.now().toIso8601String(),
          //   ),
          //   addOnId:
          //       gymStore.selectedAddOnSlot.uid,
          //   trainerId: null,
          // );
          // NavigationService.navigateTo(
          //   Routes.chooseSlotScreenAddon,
          // );
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
