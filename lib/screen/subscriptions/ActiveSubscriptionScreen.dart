import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/gradient_image_widget.dart';
import 'package:wtf/widget/progress_loader.dart';

class ActiveSubscriptionScreen extends StatelessWidget {
  const ActiveSubscriptionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    // DateTime exp = DateTime(
    //   int.tryParse(
    //     store.activeSubscriptions.data.expireDate.substring(7, 11),
    //   ),
    //   int.tryParse(
    //     store.activeSubscriptions.data.expireDate.substring(4, 6),
    //   ),
    //   int.tryParse(
    //     store.activeSubscriptions.data.expireDate.substring(1, 3),
    //   ),
    // );
    // Duration d = exp.difference(DateTime.now());
    // print('days: ${d.inDays}');
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        title: Text(
          'Your active subscription',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
      bottomNavigationBar: store.activeSubscriptions != null &&
              store.activeSubscriptions.data != null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  // LocalValue.GYM_ID = store.activeSubscriptions.data.gymId;
                  store.setRenew(true);
                  await store.getGymDetails(
                    context: context,
                    gymId: store.activeSubscriptions.data.gymId,
                  );
                  store.getGymPlans(
                    gymId: store.activeSubscriptions.data.gymId,
                    context: context,
                  );
                  NavigationService.navigateTo(
                    Routes.membershipPlanPage,
                  );
                },
                child: Text(
                  'Renew your membership',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(
                    primary: AppConstants.primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            )
          : Container(
              height: 0.0,
            ),
      body: Consumer<GymStore>(
        builder: (context, store, child) => store.activeSubscriptions != null
            ? store.activeSubscriptions.data != null
                ? Column(
                    children: [
                      Container(
                        height: 240.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            SizedBox(
                              height: 240.0,
                              child: GradientImageWidget(
                                borderRadius: BorderRadius.circular(16.0),
                                boxFit: BoxFit.cover,
                                network: store
                                    .activeSubscriptions.data.gymCoverImage,
                              ),
                            ),
                            Positioned(
                              bottom: 20.0,
                              left: 16.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store.activeSubscriptions.data?.gymName ??
                                        '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  Text(
                                    store.activeSubscriptions.data?.planName ??
                                        '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '₹ ${store.activeSubscriptions.data?.price}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10.0,
                              right: 16.0,
                              child: ElevatedButton(
                                child: Text(
                                  'Activated',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/clock.png',
                                  height: 30.0,
                                ),
                                UIHelper.verticalSpace(8.0),
                                Text(
                                  '${store.activeSubscriptions.data.expireDate.difference(DateTime.now()).inDays} days Left',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'No Subscription found',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  )
            : LoadingWithBackground(),
      ),
    );
  }

  whiteButton(title, onPress) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: onPress,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
          ),
        ),
      );
}
