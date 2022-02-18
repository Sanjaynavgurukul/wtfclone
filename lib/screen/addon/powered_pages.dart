import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/ExplorePage.dart';
import 'package:wtf/widget/glass_morphism.dart';
import 'package:wtf/widget/progress_loader.dart';

class PoweredPages extends StatefulWidget {
  @override
  _PoweredPagesState createState() => _PoweredPagesState();
}

class _PoweredPagesState extends State<PoweredPages> {
  GymStore store;
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      
    });
    super.initState();
  }
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
                    Color(0xff046A58).withOpacity(0.4),
                    Colors.black,
                    Color(0xff046A58).withOpacity(0.4),
                    Colors.black,
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 24,
              // padding: const EdgeInsets.only(
              //   top: 50.0,
              //   left: 12.0,
              //   right: 12.0,
              // ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        // Image.asset(
                        //   'assets/images/powered_bg.png',
                        //   width: double.infinity,
                        //   fit: BoxFit.fill,
                        //   color: Color(0xff0d69ff).withOpacity(1.0),
                        //   colorBlendMode: BlendMode.softLight,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                  Color(0xff0d69ff).withOpacity(0.1),
                                  BlendMode.softLight),
                              image: AssetImage(
                                'assets/images/powered_bg.png',
                              ),
                            ),
                          ),
                          height: 350.0,
                        ),
                        Positioned(
                          top: 150.0,
                          left: 20.0,
                          child: SvgPicture.asset(
                            'assets/svg/fitness_fullstop.svg',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 50.0,
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: PageAppBar(isLive: false),
                        ),
                        // Positioned(
                        //   top: 10.0,
                        //   left: 0.0,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: RadialGradient(
                        //         colors: [
                        //           Color(0xff046A58).withOpacity(0.6),
                        //           Colors.black,
                        //           Color(0xff046A58).withOpacity(0.6),
                        //           Colors.black,
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Positioned(
                        //   top: 10.0,
                        //   right: 0.0,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: RadialGradient(
                        //         colors: [
                        //           Color(0xff046A58).withOpacity(0.6),
                        //           Colors.black,
                        //           Color(0xff046A58).withOpacity(0.6),
                        //           Colors.black,
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    UIHelper.verticalSpace(24.0),
                    PagePriceTag(
                      text1: 'Start only from ',
                      text2: '199 Rs.',
                      isBlue: true,
                    ),
                    UIHelper.verticalSpace(22.0),
                    PageSectionHeader(
                      onFilterTap: () {
                        //todo:
                      },
                      sectionHeading: 'Activities',
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
                                    itemCount:
                                        store.allAddonClasses.data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      child: LiveCard(
                                        data: store.allAddonClasses.data[index],
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
            // Positioned(
            //   top: 0.0,
            //   left: 0.0,
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       gradient: RadialGradient(
            //           center: Alignment.center,
            //           radius: 2.0,
            //           colors: [
            //             Color(0xff09C0E8).withOpacity(0.3),
            //             Color(0xff09C0E8).withOpacity(0.8),
            //             Color(0xff09C0E8).withOpacity(0.2),
            //           ]),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(color: Color(0xff093AE8), blurRadius: 2.0),
            //       ],
            //       // gradient: RadialGradient(
            //       //   focalRadius: 0.5,
            //       //   colors: [
            //       //     Color(0xff093AE8).withOpacity(0.6),
            //       //     Color(0xff093AE8).withOpacity(0.6),
            //       //   ],
            //       // ),
            //     ),
            //   ),
            // ),
            Container(
              height: 350.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xff046A58).withOpacity(0.4),
                    Color(0xff09C0E8).withOpacity(0.4),
                    Color(0xff093AE8).withOpacity(0.4),
                    Color(0xff046A58).withOpacity(0.4),
                    Color(0xff046A58).withOpacity(0.4),
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

class PagePriceTag extends StatelessWidget {
  final String text1;
  final String text2;
  final bool isBlue;
  const PagePriceTag({
    Key key,
    this.text1,
    this.text2,
    this.isBlue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0.0,
            left: -6.0,
            child: Opacity(
              opacity: 0.6,
              child: SvgPicture.asset(
                  'assets/svg/${isBlue ? 'left_dot_blue' : 'let_dot'}.svg'),
            ),
          ),
          Positioned(
            top: -8.0,
            right: -10.0,
            child: Opacity(
              opacity: 0.6,
              child: SvgPicture.asset(
                  'assets/svg/${isBlue ? 'right_dot_blue' : 'right_dot'}.svg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GlassMorphism(
              end: 0.5,
              start: 0.2,
              child: Container(
                height: 100.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: text1,
                        style: TextStyle(
                          color: AppConstants.white.withOpacity(0.8),
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                        ),
                        children: [
                          TextSpan(
                            text: text2,
                            style: TextStyle(
                              color: AppConstants.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageAppBar extends StatelessWidget {
  final bool isLive;
  const PageAppBar({
    Key key,
    this.isLive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppConstants.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/wtf_2.png'),
                    UIHelper.horizontalSpace(4.0),
                    Text(
                      'Powered',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 24.0,
                        color: AppConstants.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                if (isLive) ...{
                  UIHelper.verticalSpace(2.0),
                  GradientText(
                    text: 'Live Class',
                    colors: <Color>[Colors.redAccent, Colors.white],
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                }
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class PageSectionHeader extends StatelessWidget {
  final String sectionHeading;
  final GestureTapCallback onFilterTap;
  final GestureTapCallback onHeaderTap;

  PageSectionHeader({
    @required this.sectionHeading,
    @required this.onFilterTap,
    this.onHeaderTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onHeaderTap != null ? onHeaderTap : null,
      child: Container(
        height: 36.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 6.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionHeading,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            InkWell(
              onTap: onFilterTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ),
                color: Color(0xff383838),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    UIHelper.horizontalSpace(6.0),
                    SvgPicture.asset(
                      'assets/svg/filter.svg',
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
