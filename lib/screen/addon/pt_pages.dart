import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/ExplorePage.dart';
import 'package:wtf/screen/addon/powered_pages.dart';
import 'package:wtf/screen/common_widgets/common_banner.dart';
import 'package:wtf/screen/gym/membership_page.dart';
import 'package:wtf/widget/progress_loader.dart';
class PTPages extends StatefulWidget {
  @override
  _PTPagesState createState() => _PTPagesState();
}

class _PTPagesState extends State<PTPages> {
  //Local Variables :D
  GymStore store;
  bool show = false;
  bool scrollOrNot = true;
  final bool isPreview = false;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight,
                  colors: [
                    Color(0xff6B5B04).withOpacity(0.4),
                    Colors.black,
                    Color(0xff6B5B04).withOpacity(0.4),
                    Colors.black,
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 24,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          height: 350.0,
                          child: CommonBanner(bannerType: 'PT_banner',height: 350,fraction: 1,),
                        ),

                        // Positioned(
                        //   top: 66.0,
                        //   left: 0.0,
                        //   right: 0.0,
                        //   child: Column(
                        //     children: [
                        //       // SvgPicture.asset(
                        //       //   'assets/svg/train_with_best.svg',
                        //       // ),
                        //       UIHelper.verticalSpace(20.0),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Image.asset('assets/images/wtf_2.png'),
                        //           UIHelper.horizontalSpace(4.0),
                        //           Text(
                        //             'Powered',
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.normal,
                        //               fontSize: 18.0,
                        //               color:
                        //               AppConstants.white.withOpacity(0.8),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       UIHelper.verticalSpace(2.0),
                        //       GradientText(
                        //         text: 'Personal Training',
                        //         colors: <Color>[
                        //           Colors.deepOrange,
                        //           Colors.yellow
                        //         ],
                        //         style: TextStyle(
                        //           fontSize: 24.0,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     top: 50.0,
                        //     left: 12.0,
                        //     right: 12.0,
                        //   ),
                        //   child: PageAppBar(
                        //     isLive: false,
                        //     showText: false,
                        //   ),
                        // ),
                      ],
                    ),
                    UIHelper.verticalSpace(24.0),
                    PagePriceTag(
                      text1: 'Start only from ',
                      text2: '799 Rs.',
                      image1: 'left_dot_gold',
                      image2: 'right_dot_gold',
                    ),
                    UIHelper.verticalSpace(36.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextIconCard(
                            textColor: AppConstants.black,
                            bgColor: AppConstants.white,
                            text: 'Skilled Trainer',
                            icon: 'assets/images/you_get/skilled_trainer.png',
                          ),
                          TextIconCard(
                            textColor: AppConstants.black,
                            bgColor: AppConstants.white,
                            text: '24 X 7 Support',
                            icon: 'assets/images/you_get/support.png',
                          ),
                          TextIconCard(
                            textColor: AppConstants.black,
                            bgColor: AppConstants.white,
                            text: 'Pocket Friendly',
                            icon: 'assets/images/you_get/pocket_friendly.png',
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: PageSectionHeader(
                        onFilterTap: () {
                          //todo:
                        },
                        sectionHeading: 'Personal Training Activities',
                      ),
                    ),
                    UIHelper.verticalSpace(12.0),
                    RefreshIndicator(
                      onRefresh: () async {
                        store.getAllLiveClasses(context: context);
                      },
                      color: AppConstants.white,
                      child: Consumer<GymStore>(
                        builder: (context, store, child) => store
                            .allAddonClasses !=
                            null
                            ? store.allAddonClasses.data != null &&
                            store.allAddonClasses.data.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: store.allAddonClasses.data
                              .where((element) => element.isPt == 1)
                              .toList()
                              .length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: LiveCard(
                              data: store.allAddonClasses.data
                                  .where((element) =>
                              element.isPt == 1)
                                  .toList()[index],
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
          ],
        ),
      ),
    );
  }


}
