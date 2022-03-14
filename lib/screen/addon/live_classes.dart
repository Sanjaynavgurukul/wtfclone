import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/gym_add_on.dart';
import 'package:wtf/screen/ExplorePage.dart';
import 'package:wtf/screen/addon/powered_pages.dart';
import 'package:wtf/screen/common_widgets/common_banner.dart';
import 'package:wtf/screen/gym/membership_page.dart';
import 'package:wtf/screen/home/home.dart';
import 'package:wtf/widget/gradient_scaffold.dart';
import 'package:wtf/widget/progress_loader.dart';

class LiveClasses extends StatefulWidget {
  @override
  _LiveClassesState createState() => _LiveClassesState();
}

class _LiveClassesState extends State<LiveClasses> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return SafeArea(
      child: ScaffoldGradientBackground(
        gradient: LinearGradient(
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
          colors: [
            AppConstants.buttonRed3.withOpacity(0.4),
            Colors.black,
            AppConstants.buttonRed3.withOpacity(0.4),
            Colors.black,
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Banner Section
              Container(
                height: 400,
                child: Stack(
                  children: [
                    CommonBanner(
                      bannerType: 'LIVE_banner',
                      width: double.infinity,
                      height: 400,
                      fraction: 1,
                    ),
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      actions: [
                        Container(
                          padding: EdgeInsets.only(right: 12),
                          child: Row(
                            children: [
                              Text('Live'),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 2, color: AppConstants.boxBorderColor)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    // Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: Padding(
                    //       padding: EdgeInsets.only(top: 12),
                    //         child: Image.asset(
                    //             'assets/images/live_class_banner.png'))),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: Column(
                  children: [
                    PagePriceTag(
                      text1: 'Start only from ',
                      text2: '99 Rs.',
                      image1: 'let_dot',
                      image2: 'right_dot',
                    ),
                    UIHelper.verticalSpace(22.0),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'What you get',
                          style: GoogleFonts.montserrat(
                            fontSize: 36.0,
                          ),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextIconCard(
                          textColor: AppConstants.black,
                          bgColor: AppConstants.white,
                          text: 'Skilled Trainer',
                          // isSvg: true,
                          icon: 'assets/images/you_get/skilled_trainer.png',
                        ),
                        TextIconCard(
                          textColor: AppConstants.black,
                          bgColor: AppConstants.white,
                          text: 'Tailored DIet Plan',
                          // isSvg: true,
                          icon: 'assets/images/you_get/tailored_diet.png',
                        ),
                        TextIconCard(
                          textColor: AppConstants.black,
                          bgColor: AppConstants.white,
                          text: 'Workout Videos',
                          // isSvg: true,
                          icon: 'assets/images/you_get/workout_videos.png',
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(12.0),
                    PageSectionHeader(
                      onFilterTap: () {
                        //todo:
                      },
                      sectionHeading: 'Live Sessions',
                    ),
                    UIHelper.verticalSpace(12.0),
                    RefreshIndicator(
                      onRefresh: () async {
                        store.getAllLiveClasses(context: context);
                      },
                      color: AppConstants.white,
                      child: Consumer<GymStore>(
                        builder: (context, store, child) => store
                                    .allLiveClasses !=
                                null
                            ? store.allLiveClasses.data != null &&
                                    store.allLiveClasses.data.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: store.allLiveClasses.data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      child: LiveCard(
                                        data: store.allLiveClasses.data[index],
                                        isFullView: true,
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
                    ),
                    UIHelper.verticalSpace(120.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget oldUI() {
    return SafeArea(
      child: ScaffoldGradientBackground(
        gradient: LinearGradient(
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
          colors: [
            AppConstants.buttonRed3.withOpacity(0.4),
            Colors.black,
            AppConstants.buttonRed3.withOpacity(0.4),
            Colors.black,
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height - 24,
          padding: const EdgeInsets.only(
            top: 50.0,
            left: 12.0,
            right: 12.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PageAppBar(isLive: true),
                UIHelper.verticalSpace(40.0),
                // Flexible(
                //   child: Stack(
                //     fit: StackFit.loose,
                //     children: [
                //       Image.asset('assets/images/trainer.png'),
                //       Positioned(
                //         bottom: 5.0,
                //         child: Column(
                //           children: [
                //             Container(
                //               height: 36.0,
                //               width: MediaQuery.of(context).size.width,
                //               alignment: Alignment.bottomCenter,
                //               child: Row(
                //                 mainAxisSize: MainAxisSize.max,
                //                 children: [
                //                   Expanded(
                //                     child: Container(
                //                       height: 4.0,
                //                       color: AppConstants.white,
                //                     ),
                //                   ),
                //                   UIHelper.horizontalSpace(8.0),
                //                   Expanded(
                //                     flex: 3,
                //                     child: Text(
                //                       'Train from',
                //                       style: GoogleFonts.dancingScript(
                //                         fontWeight: FontWeight.normal,
                //                         fontSize: 24.0,
                //                         color:
                //                             AppConstants.white.withOpacity(0.8),
                //                       ),
                //                     ),
                //                   ),
                //                   Expanded(
                //                     child: Container(
                //                       height: 4.0,
                //                       color: Colors.transparent,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Container(
                //               height: 60.0,
                //               width: MediaQuery.of(context).size.width,
                //               alignment: Alignment.topCenter,
                //               child: Row(
                //                 mainAxisSize: MainAxisSize.max,
                //                 children: [
                //                   Expanded(
                //                     flex: 1,
                //                     child: Container(
                //                       height: 4.0,
                //                       color: Colors.transparent,
                //                     ),
                //                   ),
                //                   UIHelper.horizontalSpace(8.0),
                //                   Expanded(
                //                     flex: 3,
                //                     child: Text(
                //                       'anywhere',
                //                       style: GoogleFonts.dancingScript(
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 48.0,
                //                         color:
                //                             AppConstants.white.withOpacity(0.8),
                //                       ),
                //                     ),
                //                   ),
                //                   Expanded(
                //                     flex: 2,
                //                     child: Container(
                //                       height: 4.0,
                //                       color: Colors.white,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                CommonBanner(
                  bannerType: "LIVE_banner",
                ),
                UIHelper.verticalSpace(24.0),
                PagePriceTag(
                  text1: 'Start only from ',
                  text2: '99 Rs.',
                  image1: 'let_dot',
                  image2: 'right_dot',
                ),
                UIHelper.verticalSpace(22.0),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'What you get',
                      style: GoogleFonts.montserrat(
                        fontSize: 36.0,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextIconCard(
                      textColor: AppConstants.black,
                      bgColor: AppConstants.white,
                      text: 'Skilled Trainer',
                      // isSvg: true,
                      icon: 'assets/images/you_get/skilled_trainer.png',
                    ),
                    TextIconCard(
                      textColor: AppConstants.black,
                      bgColor: AppConstants.white,
                      text: 'Tailored DIet Plan',
                      // isSvg: true,
                      icon: 'assets/images/you_get/tailored_diet.png',
                    ),
                    TextIconCard(
                      textColor: AppConstants.black,
                      bgColor: AppConstants.white,
                      text: 'Workout Videos',
                      // isSvg: true,
                      icon: 'assets/images/you_get/workout_videos.png',
                    ),
                  ],
                ),
                UIHelper.verticalSpace(12.0),
                PageSectionHeader(
                  onFilterTap: () {
                    //todo:
                  },
                  sectionHeading: 'Live Sessions',
                ),
                UIHelper.verticalSpace(12.0),
                RefreshIndicator(
                  onRefresh: () async {
                    store.getAllLiveClasses(context: context);
                  },
                  color: AppConstants.white,
                  child: Consumer<GymStore>(
                    builder: (context, store, child) =>
                        store.allLiveClasses != null
                            ? store.allLiveClasses.data != null &&
                                    store.allLiveClasses.data.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: store.allLiveClasses.data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      child: LiveCard(
                                        data: store.allLiveClasses.data[index],
                                        isFullView: true,
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
                ),
                UIHelper.verticalSpace(120.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
