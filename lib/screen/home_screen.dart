import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rolling_nav_bar/indexed.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';
import 'package:wtf/controller/explore_controller_presenter.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/screen/ExplorePage.dart';
import 'package:wtf/screen/my_wtf.dart';

import 'coin/coin_screen.dart';
import 'home/home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen>, WidgetsBindingObserver {
  //Local Variables :D
  int pageIndex = 0;
  ExplorePresenter _presenter;
  GymModel _gymModel;
  bool isLoaded = false;
  GymStore store;


  List<Widget> get badgeWidgets => indexed(badges)
      .map((Indexed indexed) => indexed.value != null
          ? Text(indexed.value.toString(),
              style: TextStyle(
                color: indexed.index == store.currentIndex
                    ? indicatorColors[indexed.index]
                    : Colors.white,
              ))
          : null)
      .toList();
  var iconData = <IconData>[
//    MyFlutterApp.home,
    Icons.dashboard_customize,
    Icons.widgets,
    Icons.people,
    Icons.account_balance_wallet,
    // Icons.settings,
//    MyFlutterApp.profile,
//    MyFlutterApp.wallet,
//    MyFlutterApp.misc,
  ];

  var badges = <int>[null, null, null, null];

  var iconText = <Widget>[
    Text(
      'Dashboard',
      style: TextStyle(
        color: AppConstants.white,
        fontSize: 10.0,
        fontWeight: FontWeight.w200,
        // letterSpace: 1.5,
      ),
    ),
    Text(
      'Explore',
      style: TextStyle(
        color: AppConstants.white,
        fontSize: 10.0,
        fontWeight: FontWeight.w200,
        // letterSpace: 1.5,
      ),
    ),
    Text(
      'My WTF',
      style: TextStyle(
        color: AppConstants.white,
        fontSize: 10.0,
        fontWeight: FontWeight.w200,
        // letterSpace: 1.5,
      ),
    ),
    Text(
      'Coins',
      style: TextStyle(
        color: AppConstants.white,
        fontSize: 10.0,
        fontWeight: FontWeight.w200,
        // letterSpace: 1.5,
      ),
    ),
  ];

  var indicatorColors = <Color>[
    AppConstants.primaryColor,
    AppConstants.primaryColor,
    AppConstants.primaryColor,
    AppConstants.primaryColor,
  ];

  double scaledHeight(BuildContext context, double baseSize) {
    return baseSize * (MediaQuery.of(context).size.height / 800);
  }

  _onAnimate(AnimationUpdate update) {
    setState(() {
//      logoColor = update.color;
      logoColor = AppConstants.black;
    });
  }

  Color logoColor;

  final List<Widget> _children = [
    DashboardScreen(),
    ExplorePage(),
    MyWtf(),
    CoinScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print(
        'GIVEN DATE: ${Helper.stringForDatetime(DateTime.fromMicrosecondsSinceEpoch(1633712299).toIso8601String())}');
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    // _timerLink?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            switch (store.currentIndex) {
              case 0:
                return Helper.onWillPop(context);
              case 1:
              case 2:
              case 3:
                setState(() {
                  store.currentIndex = 0;
                });
                return false;
              default:
                return false;
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.BACK_GROUND_BG,
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    activeIcon:new SvgPicture.asset(
                        'assets/svg/nav_bar/dashboard.svg',

                        semanticsLabel: 'Dashboard Icon',
                      color: AppConstants.boxBorderColor,
                    ),
                    icon: SvgPicture.asset(
                        'assets/svg/nav_bar/dashboard.svg',

                        semanticsLabel: 'Dashboard Icon'
                    ), title: Text('Dashboard')),
                BottomNavigationBarItem(
                    activeIcon:new SvgPicture.asset(
                      'assets/svg/nav_bar/explore.svg',

                      semanticsLabel: 'Explore Icon',
                      color: AppConstants.boxBorderColor,
                    ),
                    icon: SvgPicture.asset(
                        'assets/svg/nav_bar/explore.svg',

                        semanticsLabel: 'Explore icon'
                    ), title: Text('Explore')),
                BottomNavigationBarItem(
                    activeIcon:new SvgPicture.asset(
                      'assets/svg/nav_bar/wtf.svg',

                      semanticsLabel: 'wtf icon',
                      color: AppConstants.boxBorderColor,
                    ),
                    icon: SvgPicture.asset(
                        'assets/svg/nav_bar/wtf.svg',

                        semanticsLabel: 'wtf icon'
                    ), title: Text('My WTF')),
                BottomNavigationBarItem(
                    activeIcon:new SvgPicture.asset(
                      'assets/svg/nav_bar/coin.svg',

                      semanticsLabel: 'coins icon',
                      color: AppConstants.boxBorderColor,
                    ),
                    icon: SvgPicture.asset(
                        'assets/svg/nav_bar/coin.svg',

                        semanticsLabel: 'coin icon'
                    ), title: Text('Coins')),
              ],
              currentIndex: store.currentIndex,
              fixedColor: Colors.white,
              backgroundColor: Color(0xff1A1A1A),
              selectedLabelStyle: TextStyle(color: Colors.white),
              unselectedIconTheme:
              IconThemeData(color: AppConstants.white.withOpacity(0.3)),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.green),
              onTap: (index){
                setState(() {
                  switch (index) {
                    case 0:
                      context.read<GymStore>().getBanner(context: context);
                      context.read<GymStore>().getAllEvents(context: context);
                      break;
                    case 1:
                      context
                          .read<GymStore>()
                          .getActiveSubscriptions(context: context);
                      context
                          .read<GymStore>()
                          .getMemberSubscriptions(context: context);
                      context.read<GymStore>().getTerms();
                      context.read<GymStore>().getBanner(context: context);
                      context.read<GymStore>().getAllGyms(context: context);
                      context.read<GymStore>().getAllEvents(context: context);
                      break;
                    case 2:
                      break;
                    case 3:
                      context
                          .read<GymStore>()
                          .getWTFCoinBalance(context: context);
                      context.read<GymStore>().getCoinHistory(context: context);
                      context
                          .read<GymStore>()
                          .getRedeemHistory(context: context);
                      // context.read<GymStore>().getNotifications(
                      //       context: context,
                      //       type: 'new',
                      //     );
                      break;
                  }

                  setState(() {
                    store.currentIndex = index;
                  });
                  // _pageController.animateToPage(index,
                  //     duration: Duration(milliseconds: 300), curve: Curves.ease);
                });
              },
              enableFeedback: true,
              type: BottomNavigationBarType.fixed,
            ),
            body: Column(
              children: [
                if (store.currentIndex != 2)
                  IntrinsicHeight(
                    child: CommonAppBar(),
                  ),
                Expanded(
                  flex: 4,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 550),
                    switchInCurve: Curves.easeInCubic,
                    // switchOutCurve: Curves.fastOutSlowIn,
                    child: _children[store.currentIndex],
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget oldBottomBar(){
    return SizedBox(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      child: Material(
        elevation: 12.0,
        child: RollingNavBar.iconData(
          activeBadgeColors: <Color>[
            Colors.black,
          ],
          activeIndex: store.currentIndex,
          animationCurve: Curves.linear,
          animationType: AnimationType.spinOutIn,
          baseAnimationSpeed: 250,
          badges: badgeWidgets,
          iconData: iconData,
          iconColors: <Color>[Colors.white],
          iconText: iconText,
          indicatorColors: [
            AppConstants.primaryColor
//                Color(locator<AppPrefs>().selectedPrimaryColor2.getValue()),
//                Color(locator<AppPrefs>().selectedPrimaryColor.getValue()),
//                AppConstants.white
          ],
          iconSize: 24,
          indicatorRadius: scaledHeight(context, 25),
          onAnimate: _onAnimate,
          onTap: (index) => setState(() {
            switch (index) {
              case 0:
                context.read<GymStore>().getBanner(context: context);
                context.read<GymStore>().getAllEvents(context: context);
                break;
              case 1:
                context
                    .read<GymStore>()
                    .getActiveSubscriptions(context: context);
                context
                    .read<GymStore>()
                    .getMemberSubscriptions(context: context);
                context.read<GymStore>().getTerms();
                context.read<GymStore>().getBanner(context: context);
                context.read<GymStore>().getAllGyms(context: context);
                context.read<GymStore>().getAllEvents(context: context);
                break;
              case 2:
                break;
              case 3:
                context
                    .read<GymStore>()
                    .getWTFCoinBalance(context: context);
                context.read<GymStore>().getCoinHistory(context: context);
                context
                    .read<GymStore>()
                    .getRedeemHistory(context: context);
                // context.read<GymStore>().getNotifications(
                //       context: context,
                //       type: 'new',
                //     );
                break;
            }

            setState(() {
              store.currentIndex = index;
            });
            // _pageController.animateToPage(index,
            //     duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          indicatorCornerRadius: 8.0,
          indicatorSides: 6,
          activeIconColors: [AppConstants.white],
          navBarDecoration: BoxDecoration(
            color: AppConstants.cardBg1.withOpacity(0.01),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}