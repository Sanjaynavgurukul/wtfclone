import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/auto_image_slider.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../subscriptions/buy_subscription_screen.dart';

class GymMembershipPlanPage extends StatefulWidget {
  @override
  _GymMembershipPlanPageState createState() => _GymMembershipPlanPageState();
}

class _GymMembershipPlanPageState extends State<GymMembershipPlanPage> {
  GymStore store;

  PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController(
      initialPage: currentIndex,
      keepPage: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.read<GymStore>();
    return oldUi();
  }

  Widget prizeItem({bool recomended = false}) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: recomended ? 16 : 0, bottom: 23),
            padding: EdgeInsets.only(
                left: 12, right: 12, top: recomended ? 24 : 12, bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff6FAF81),
                    Color(0xff598966),
                  ],
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PLAN 1'),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  title: Row(
                    children: [
                      Image.asset(
                        'assets/logo/wtf_light.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Consistent',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800))
                    ],
                  ),
                  trailing: Container(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                    decoration: BoxDecoration(
                        color: Color(0xff6FAF81),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      '\u{20B9}999',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
                ListTile(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    title: Text(
                      'Best for person who frequently travel',
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(left: 12,top: 12,bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• 1 Month membership'),
                          Text('• Trainer Support'),
                          Text('• Access to free diet plans'),
                        ],
                      ),
                    ),)
              ],
            ),
          ),
          if (recomended)
            Container(
              padding: EdgeInsets.only(left: 60, top: 6, bottom: 6, right: 12),
              constraints: BoxConstraints(minWidth: 134),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
              child: Text(
                'Recommended',
                style: TextStyle(
                    color: AppConstants.black,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal),
              ),
            ),
        ],
      ),
    );
  }

  Widget oldUi() {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        centerTitle: false,
        title: Text(
          store.selectedGymDetail.data.gymName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          store.getGymPlans(context: context);
        },
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Consumer<GymStore>(
            builder: (context, store, child) => store.selectedGymPlans != null
                ? store.selectedGymPlans.data != null &&
                        store.selectedGymPlans.data.isNotEmpty
                    ? CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 1.0,
                                    color: AppConstants.white,
                                  ),
                                ),
                                UIHelper.horizontalSpace(6.0),
                                Text(
                                  'Membership Options',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                UIHelper.horizontalSpace(6.0),
                                Flexible(
                                  child: Container(
                                    height: 1.0,
                                    color: AppConstants.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 12.0,
                                right: 12.0,
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      itemBuilder: (context, index) =>
                                          Container(
                                        color: AppConstants.primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 20.0,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/plan1.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35,
                                            ),
                                            UIHelper.verticalSpace(20.0),
                                            Text(
                                              store.selectedGymPlans.data[index]
                                                  .planName,
                                              style: TextStyle(
                                                color:
                                                    AppConstants.offPinkColor,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            UIHelper.verticalSpace(6.0),
                                            Text(
                                              '₹ ${store.selectedGymPlans.data[index].planPrice}',
                                              style: TextStyle(
                                                color:
                                                    AppConstants.offPinkColor,
                                                fontSize: 36.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            UIHelper.verticalSpace(100.0),
                                            CustomButton(
                                              height: 48.0,
                                              textColor: AppConstants.white,
                                              bgColor:
                                                  AppConstants.darkPrimaryColor,
                                              text: 'Book Now',
                                              onTap: () {
                                                context
                                                        .read<GymStore>()
                                                        .selectedStartingDate =
                                                    null;
                                                // int days = e.planName ==
                                                //         'Half yearly'
                                                //     ? 6 * 30 + 3
                                                //     : e.planName == 'Yearly'
                                                //         ? 365
                                                //         : 30;
                                                setState(() {
                                                  context
                                                          .read<GymStore>()
                                                          .selectedGymPlan =
                                                      store.selectedGymPlans
                                                          .data[index];
                                                });
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BuySubscriptionScreen(),
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          store.selectedGymPlans.data.length,
                                      pageSnapping: true,
                                      onPageChanged: (index) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                    ),
                                    AnimatedPositioned(
                                      bottom: 50.0,
                                      left: 0.0,
                                      right: 0.0,
                                      height: 30.0,
                                      child: Center(
                                        child: PositionMarker(
                                          activeMarkerColor:
                                              AppConstants.offPinkColor,
                                          inActiveMarkerColor:
                                              AppConstants.darkPrimaryColor,
                                          index: currentIndex,
                                          length: store
                                              .selectedGymPlans.data.length,
                                          markerType: PositionMarkerType.dots,
                                          size: 8.0,
                                          showBorderDots: false,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 800),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Note: The above prices are exclusive of GST',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.TEXT_DARK,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Text(
                          'No Plans found',
                        ),
                      )
                : Loading(),
          ),
        ),
      ),
    );
  }

  Widget newUi(){
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        centerTitle: false,
        title: Text('Choose Your Plan'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          store.getGymPlans(context: context);
        },
        backgroundColor: Colors.white,
        child: Container(
          child: ListView(
            children: [
              ListTile(title: Text('One Membership for all your fitness need')),
              ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  padding:
                  EdgeInsets.only(left: 32, right: 32, top: 54, bottom: 54),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    bool r = index == 1;
                    return prizeItem(recomended: r);
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    store.selectedGymPlans = null;
    super.dispose();
  }
}
