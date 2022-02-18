import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/ExplorePage.dart';
import 'package:wtf/widget/glass_morphism.dart';
import 'package:wtf/widget/gradient_scaffold.dart';
import 'package:wtf/widget/progress_loader.dart';

class PTPages extends StatefulWidget {
  @override
  _PTPagesState createState() => _PTPagesState();
}

class _PTPagesState extends State<PTPages> {
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
                Flexible(
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Image.asset('assets/images/trainer.png'),
                      Positioned(
                        bottom: 5.0,
                        child: Column(
                          children: [
                            Container(
                              height: 36.0,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 4.0,
                                      color: AppConstants.white,
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(8.0),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Train from',
                                      style: GoogleFonts.dancingScript(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 24.0,
                                        color:
                                            AppConstants.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 4.0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 4.0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  UIHelper.horizontalSpace(8.0),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'anywhere',
                                      style: GoogleFonts.dancingScript(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 48.0,
                                        color:
                                            AppConstants.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 4.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(24.0),
                PagePriceTag(
                  text1: 'Start only from ',
                  text2: '99 Rs.',
                ),
                UIHelper.verticalSpace(22.0),
                Align(
                  alignment: Alignment.centerLeft,
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
                    SvgPicture.asset('assets/svg/you_get/skilled_trainer.svg'),
                    SvgPicture.asset('assets/svg/you_get/tailored_diet.svg'),
                    SvgPicture.asset('assets/svg/you_get/support.svg'),
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

class PagePriceTag extends StatelessWidget {
  final String text1;
  final String text2;
  const PagePriceTag({
    Key key,
    this.text1,
    this.text2,
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
              child: SvgPicture.asset('assets/svg/let_dot.svg'),
            ),
          ),
          Positioned(
            top: -8.0,
            right: -10.0,
            child: Opacity(
              opacity: 0.6,
              child: SvgPicture.asset('assets/svg/right_dot.svg'),
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
