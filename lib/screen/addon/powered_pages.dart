import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/gym_add_on.dart';
import 'package:wtf/screen/ExplorePage.dart';
import 'package:wtf/widget/glass_morphism.dart';
import 'package:wtf/widget/progress_loader.dart';

class PoweredPages extends StatefulWidget {
  @override
  _PoweredPagesState createState() => _PoweredPagesState();
}

class _PoweredPagesState extends State<PoweredPages>
    with TickerProviderStateMixin {
  GymStore store;
  ScrollController controller;
  TabController _tabController;
  double tabBarRadius = 4.0;
  var _selectedIndex = 0;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {});
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    // _tabController = TabController(length: 2, vsync: this,initialIndex: 0)
    //   ..addListener(() {
    //     setState(() {
    //       _selectedIndex = _tabController.index;
    //     });
    //   });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      body: RefreshIndicator(onRefresh: () async {
        store.getAllLiveClasses(context: context);
      }, child: Consumer<GymStore>(builder: (context, store, child) {
        return NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                              Color(0xff046A58).withOpacity(0.5),
                              BlendMode.dstIn,
                            ),
                            image: AssetImage(
                              'assets/images/powered_bg.png',
                            ),
                          ),
                        ),
                        height: 400.0,
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
                    image2: 'right_dot_blue',
                    image1: 'left_dot_blue',
                  ),
                  UIHelper.verticalSpace(22.0),
                  PageSectionHeader(
                    onFilterTap: () {
                      //todo:
                    },
                    sectionHeading: 'Activities',
                  ),
                  UIHelper.verticalSpace(12.0),
                ],
              )),
              SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xff2d2d2d),
                      borderRadius: BorderRadius.circular(tabBarRadius),
                      border:
                      Border.all(width: 1.0, color: const Color(0xff2f363d)),
                    ),
                    padding: EdgeInsets.all(2),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(tabBarRadius),
                        color: AppConstants.bgColor,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppConstants.white,
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(
                            'Paid',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(
                            'Free',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ];
          },
          body: Container(
            child: TabBarView(
              controller: _tabController,
              children: [
                getList(data: store.allAddonClasses,isPaid: true),
                getList(data: store.allAddonClasses,isPaid: false),
              ],
            ),
          ),
        );
      })),
    );
  }

  Widget getList({@required GymAddOn data, bool isPaid = true}) {
    return store.allAddonClasses != null
        ? store.allAddonClasses.data != null &&
        store.allAddonClasses.data.isNotEmpty &&
        getFilterList(data: store.allAddonClasses.data,isPaid: isPaid) != null &&
        getFilterList(data: store.allAddonClasses.data,isPaid: isPaid).isNotEmpty
        ? ListView.builder(
      // shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          itemCount:
          getFilterList(data: store.allAddonClasses.data,isPaid: isPaid).length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            AddOnData item =
            getFilterList(data: store.allAddonClasses.data,isPaid: isPaid)[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: LiveCard(
                data: item,
                isFullView: true,
              ),
            );
          },
    )
        : Center(
      child: Text(
        'No live Classes found',
      ),
    )
        : Loading();
  }

  Widget oldUi() {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            store.getAllLiveClasses(context: context);
          },
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height - 24,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                              Color(0xff046A58).withOpacity(0.5),
                              BlendMode.dstIn,
                            ),
                            image: AssetImage(
                              'assets/images/powered_bg.png',
                            ),
                          ),
                        ),
                        height: 400.0,
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
                    image2: 'right_dot_blue',
                    image1: 'left_dot_blue',
                  ),
                  UIHelper.verticalSpace(22.0),
                  PageSectionHeader(
                    onFilterTap: () {
                      //todo:
                    },
                    sectionHeading: 'Activities',
                  ),
                  UIHelper.verticalSpace(12.0),
                  // PreferredSize(
                  //     preferredSize: Size.fromHeight(70),
                  //     child: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: Container(
                  //           // width: MediaQuery.of(context).size.width / 1.5,
                  //           child: TabBar(
                  //             isScrollable: true,
                  //               indicatorColor: Colors.white,
                  //               unselectedLabelColor: Colors.blue,
                  //               indicatorSize: TabBarIndicatorSize.label,
                  //               padding: EdgeInsets.all(0),
                  //               controller: _tabController,
                  //
                  //               indicator: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(tabBarRadius),
                  //                   color: Colors.blue),
                  //               tabs: [
                  //                 Tab(
                  //                   text: 'Home',
                  //                 ),
                  //                 Tab(
                  //                   text: 'Home',
                  //                 ),
                  //               ]),
                  //         ))),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xff2d2d2d),
                        borderRadius: BorderRadius.circular(tabBarRadius),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff2f363d)),
                      ),
                      padding: EdgeInsets.all(2),
                      child: TabBar(
                        controller: _tabController,
                        // give the indicator a decoration (color and border radius)
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(tabBarRadius),
                          color: AppConstants.bgColor,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: AppConstants.white,
                        tabs: [
                          // first tab [you can add an icon using the icon property]
                          Tab(
                            child: Text(
                              'Paid',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // second tab [you can add an icon using the icon property]
                          Tab(
                            child: Text(
                              'Free',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // tab bar view her
                  // Expanded(
                  //   child: TabBarView(
                  //     controller: _tabController,
                  //     children: [
                  //       // Container(
                  //       //padding: EdgeInsets.symmetric(vertical: 25, horizontal: 32),
                  //       //height: 50,
                  //       //child:
                  //      Text('one'),
                  //      Text('twwwo')
                  //     ],
                  //   ),
                  // ),
                  RefreshIndicator(
                    onRefresh: () async {
                      store.getAllLiveClasses(context: context);
                    },
                    color: AppConstants.white,
                    child: Consumer<GymStore>(
                      builder: (context, store, child) =>
                      store
                          .allAddonClasses !=
                          null
                          ? store.allAddonClasses.data != null &&
                          store.allAddonClasses.data.isNotEmpty &&
                          getFilterList(
                              data: store.allAddonClasses.data) !=
                              null &&
                          getFilterList(
                              data: store.allAddonClasses.data)
                              .isNotEmpty
                          ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: getFilterList(
                            data: store.allAddonClasses.data)
                            .length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          AddOnData item = getFilterList(
                              data:
                              store.allAddonClasses.data)[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: LiveCard(
                              data: item,
                              isFullView: true,
                            ),
                          );
                        },
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
      ),
    );
  }

  List<AddOnData> getFilterList({@required List<AddOnData> data,bool isPaid = false}) {
    if(isPaid){
      print('is Paid -- $isPaid');
      return data.where((element) => element.isPt == 0 && int.parse(element.price ?? '0') != 0).toList();
    }else{
      print('is Paid -- $isPaid');
      return data.where((element) => element.isPt == 0 && int.parse(element.price ?? '0') == 0).toList();
    }
    return data.where((element) => element.isPt == 0 && isPaid ? int.parse(element.price??'0') > 0:int.parse(element.price??'0') ==0).toList();
  }

// @override
// // TODO: implement wantKeepAlive
// bool get wantKeepAlive => true;
}

class PagePriceTag extends StatelessWidget {
  final String text1;
  final String text2;
  final String image1;
  final String image2;

  const PagePriceTag({
    Key key,
    this.text1,
    this.text2,
    this.image1,
    this.image2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
              child: SvgPicture.asset('assets/svg/$image1.svg'),
            ),
          ),
          Positioned(
            top: -8.0,
            right: -10.0,
            child: Opacity(
              opacity: 0.6,
              child: SvgPicture.asset('assets/svg/$image2.svg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GlassMorphism(
              end: 0.5,
              start: 0.2,
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
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
  final bool showText;

  const PageAppBar({
    Key key,
    this.isLive = false,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () => NavigationService.goBack,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: AppConstants.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ),
          // if (showText)
          //   Expanded(
          //     flex: 2,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Row(
          //           children: [
          //             Image.asset('assets/images/wtf_2.png'),
          //             UIHelper.horizontalSpace(4.0),
          //             Text(
          //               'Powered',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.normal,
          //                 fontSize: 24.0,
          //                 color: AppConstants.white.withOpacity(0.8),
          //               ),
          //             ),
          //           ],
          //         ),
          //         if (isLive) ...{
          //           UIHelper.verticalSpace(2.0),
          //           GradientText(
          //             text: 'Live Class',
          //             colors: <Color>[Colors.redAccent, Colors.white],
          //             style: TextStyle(
          //               fontSize: 24.0,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         }
          //       ],
          //     ),
          //   ),
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
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionHeading,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            // InkWell(
            //   onTap: onFilterTap,
            //   child: Container(
            //     // padding: const EdgeInsets.symmetric(
            //     //   vertical: 6.0,
            //     //   horizontal: 8.0,
            //     // ),
            //     padding: EdgeInsets.all(6),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(2)),
            //       color: Color(0xff383838),
            //     ),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text(
            //           'Filter',
            //           style: TextStyle(
            //             fontSize: 16.0,
            //           ),
            //         ),
            //         UIHelper.horizontalSpace(6.0),
            //         SvgPicture.asset(
            //           'assets/svg/filter.svg',
            //           height: 10.0,
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
