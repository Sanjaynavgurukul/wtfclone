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

import 'buy_subscription_screen.dart';

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
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        centerTitle: true,
        title: Row(
          children: [
            // Image.asset('assets/images/wtf_2.png'),
            // UIHelper.horizontalSpace(4.0),
            Flexible(
              child: Text(
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
          ],
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

  @override
  void dispose() {
    store.selectedGymPlans = null;
    super.dispose();
  }
}
