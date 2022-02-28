import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/screen/common_widgets/flexible_app_bar.dart';

class GtmDetail extends StatefulWidget {
  const GtmDetail({Key key}) : super(key: key);

  @override
  _GtmDetailState createState() => _GtmDetailState();
}

class _GtmDetailState extends State<GtmDetail> {
  //Local Variables :D
  bool scrollOrNot = true;
  final bool isPreview = false;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 6,bottom: 6),
        constraints: BoxConstraints(
            minHeight: 54,maxHeight: 60
        ),
        child: Row(
          children: [
            Expanded(child: InkWell(
              onTap:()async{
                // if (gymStore.activeSubscriptions ==
                //     null ||
                //     (gymStore.activeSubscriptions !=
                //         null &&
                //         gymStore.activeSubscriptions
                //             .data ==
                //             null)) {
                //   gymStore
                //       .getGymPlans(
                //     gymId: gymStore
                //         .selectedGymDetail
                //         .data
                //         .userId,
                //     context: context,
                //   );
                //
                //   NavigationService
                //       .navigateTo(
                //     Routes
                //         .membershipPlanPage,
                //   );
                // } else {
                //   String selection =
                //   await showDialog<
                //       String>(
                //     context: context,
                //     barrierDismissible:
                //     true,
                //     builder: (context) =>
                //         SubscriptionAlreadyPresent(
                //           cancelTapped:
                //               () {
                //             Navigator.pop(
                //                 context,
                //                 'no');
                //           },
                //           nextTapped: () {
                //             Navigator.pop(
                //                 context,
                //                 'yes');
                //           },
                //           gymName: gymStore
                //               .activeSubscriptions
                //               .data
                //               .gymName,
                //         ),
                //   );
                //   if (selection !=
                //       null &&
                //       selection ==
                //           'yes') {
                //     gymStore
                //         .getGymPlans(
                //       gymId: gymStore
                //           .selectedGymDetail
                //           .data
                //           .userId,
                //       context:
                //       context,
                //     );
                //     NavigationService
                //         .navigateTo(
                //       Routes
                //           .membershipPlanPage,
                //     );
                //   }
                // }
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
          // await context.read<GymStore>().getGymDetails(
          //   context: context,
          //   gymId: widget.gymId,
          // );
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
                background: FlexibleAppBar(
                  images: [],
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
                      // Container(
                      //   padding: EdgeInsets.only(
                      //       top: 12, bottom: 12, left: 8, right: 8),
                      //   decoration: BoxDecoration(
                      //       color: AppConstants.bgColor,
                      //       borderRadius:
                      //       BorderRadius.all(Radius.circular(8))),
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: facilityItems(),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 24),
                      Text('Why to choose WTF',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontStyle: FontStyle.normal)),
                      SizedBox(height: 12),
                      // GridView.count(
                      //   primary: false,
                      //   shrinkWrap: true,
                      //   padding: const EdgeInsets.all(20),
                      //   crossAxisSpacing: 10,
                      //   mainAxisSpacing: 10,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   crossAxisCount: 2,
                      //   children: <Widget>[
                      //     whyWTF('Earn WTF rewards coin'),
                      //     whyWTF('Fully Vaccinated Staff'),
                      //     whyWTF('Track Fitness Journey'),
                      //     whyWTF('Pocket Friendly Membership'),
                      //     whyWTF('Free diet Support'),
                      //     whyWTF('Top Class Ambiance'),
                      //   ],
                      // ),
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
                      // Container(
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: coSpaceWidget(),
                      //     ),
                      //   ),
                      // ),
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
                      // Container(
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: coSpaceWidget(),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 12),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
