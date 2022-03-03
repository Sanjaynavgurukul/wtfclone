import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/explore_controller_presenter.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/screen/home/more_categories/categories_item.dart';
import 'package:wtf/widget/Shimmer/widgets/coincategories.dart';
import 'package:wtf/widget/progress_loader.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen();

  @override
  _CoinScreenState createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<GymStore>().getWTFCoinBalance(context: context);
          context.read<GymStore>().getCoinHistory(context: context);
          context.read<GymStore>().getRedeemHistory(context: context);
        },
        color: AppConstants.primaryColor,
        backgroundColor: Colors.white,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(10.r),
            child: Container(
              child: store.coinBalance != null
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: .18.sh,
                          width: double.infinity,
                          child: Row(
                            children: [
                              CoinBalanceWidget(
                                gradient: false,
                                headerText: 'WTF YPay \nBalance',
                                amount: '0',
                                buttonText: "Coming Soon",
                              ),
                              Spacer(),
                              store.coinBalance.data != null
                                  ? CoinBalanceWidget(
                                      gradient: true,
                                      headerText: 'WTF Coin \nBalance',
                                      amount: store
                                          .coinBalance.data.first.wtfCoins
                                          .toString(),
                                      buttonText: "Redeem Now",
                                      onTap: () => NavigationService.navigateTo(
                                          Routes.allcoin),
                                    )
                                  : CoinBalanceWidget(
                                      gradient: true,
                                      headerText: 'WTF Coin \nBalance',
                                      amount: '0',
                                      buttonText: "Redeem Now",
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: .06.sh,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Categories :",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  )),
                              GestureDetector(
                                onTap: () => NavigationService.navigateTo(
                                    Routes.allcoin),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "See ALL",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: AppConstants.boxBorderColor
                                              .withOpacity(.7),
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        store.shoppingCategories != null
                            ? GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                controller:
                                    ScrollController(keepScrollOffset: false),
                                crossAxisSpacing: .02.sw,
                                mainAxisSpacing: .015.sh,
                                crossAxisCount: 3,
                                children: [
                                  CoinCategoriesIcon(
                                    categoryName: store.shoppingCategories.data
                                        .elementAt(0)
                                        .keyword,
                                    categoryImage: store.shoppingCategories.data
                                        .elementAt(0)
                                        .icon,
                                  ),
                                  CoinCategoriesIcon(
                                    categoryName: store.shoppingCategories.data
                                        .elementAt(1)
                                        .keyword,
                                    categoryImage: store.shoppingCategories.data
                                        .elementAt(1)
                                        .icon,
                                  ),
                                  CoinCategoriesIcon(
                                    categoryName: store.shoppingCategories.data
                                        .elementAt(2)
                                        .keyword,
                                    categoryImage: store.shoppingCategories.data
                                        .elementAt(2)
                                        .icon,
                                  ),
                                  CoinCategoriesIcon(
                                    categoryName: store.shoppingCategories.data
                                        .elementAt(3)
                                        .keyword,
                                    categoryImage: store.shoppingCategories.data
                                        .elementAt(3)
                                        .icon,
                                  ),
                                  CoinCategoriesIcon(
                                    categoryName: store.shoppingCategories.data
                                        .elementAt(4)
                                        .keyword,
                                    categoryImage: store.shoppingCategories.data
                                        .elementAt(4)
                                        .icon,
                                  ),
                                  CoinCategoriesIcon(
                                    categoryName: store.shoppingCategories.data
                                        .elementAt(5)
                                        .keyword,
                                    categoryImage: store.shoppingCategories.data
                                        .elementAt(5)
                                        .icon,
                                  ),
                                ],
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: Loading(),
                              ),
                        SizedBox(
                          height: 30.h,
                        ),
                        // GridView(
                        //   padding: EdgeInsets.zero,
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   gridDelegate:
                        //       SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //     childAspectRatio: 2,
                        //   ),
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         NavigationService.navigateTo(
                        //             Routes.pointHistory);
                        //       },
                        //       child: CategoriesItem(
                        //         itemName: "Coin History",
                        //         img: "assets/images/wtf.png",
                        //       ),
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         NavigationService.navigateTo(
                        //             Routes.redeemHistory);
                        //       },
                        //       child: CategoriesItem(
                        //         itemName: "Redeem History",
                        //         img: "assets/images/wtf.png",
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child:GestureDetector(
                                onTap: () {
                                  NavigationService.navigateTo(
                                      Routes.pointHistory);
                                },
                                child: Column(children: [
                                  Image.asset('assets/images/wtf.png'),SizedBox(height: 6,),Text('Coin History')
                                ],)

                              ) ,
                            ),
                            Expanded(
                              flex: 1,
                              child:GestureDetector(
                                  onTap: () {
                                    NavigationService.navigateTo(
                                        Routes.redeemHistory);
                                  },
                                  child: Column(children: [
                                    Image.asset('assets/images/wtf.png'),
                                    SizedBox(height: 6,),
                                    Text('Redeem History')
                                  ],)
                                // CategoriesItem(
                                //   itemName: "Coin History",
                                //   img: "assets/images/wtf.png",
                                // ),
                              ) ,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     // CustomButton(
                        //     //   onTap: () {
                        //     //     NavigationService.navigateTo(Routes.pointHistory);
                        //     //   },
                        //     //   text: 'Coin History',
                        //     //   textSize: 20,
                        //     //   bgColor: AppConstants.primaryColor,
                        //     //   textColor: Colors.white,
                        //     //   radius: 30.0,
                        //     // ),
                        //     // CustomButton(
                        //     //   onTap: () {
                        //     //     NavigationService.navigateTo(Routes.pointHistory);
                        //     //   },
                        //     //   text: 'Redeem History',
                        //     //   textSize: 20,
                        //     //   bgColor: AppConstants.primaryColor,
                        //     //   textColor: Colors.white,
                        //     //   radius: 30.0,
                        //     // ),
                        //   ],
                        // )
                      ],
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Loading(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class CoinBalanceWidget extends StatelessWidget {
  final String headerText;
  final String amount;
  final String buttonText;
  final Function onTap;
  final bool gradient;
  const CoinBalanceWidget({
    Key key,
    this.headerText,
    this.amount,
    this.buttonText,
    this.onTap,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppConstants.cardBg2,
            gradient: gradient
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppConstants.stcoinbgColor,
                      AppConstants.primaryColor,
                    ],
                  )
                : null,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        width: MediaQuery.of(context).size.width / 2 - 12,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 14, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headerText,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 22.0.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                amount,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 30.0.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 10.r),
                child: Container(
                  height: .03.sh,
                  width: .4.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: AppConstants.cardBg2,
                    gradient: gradient
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppConstants.stcoinbgColor,
                              AppConstants.primaryColor,
                            ],
                          )
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        offset: Offset(0, 2), // Shadow position
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 15.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
