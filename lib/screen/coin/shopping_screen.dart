import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/widget/custom_action_button.dart';
import 'package:wtf/widget/progress_loader.dart';

class ShoppingScreen extends StatefulWidget {
  ShoppingScreen({Key key}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(store.offerCategory),
          backgroundColor: AppConstants.primaryColor,
        ),
        backgroundColor: AppConstants.appBackground,
        body: store.offers != null
            ? store.offers.data != null && store.offers.data.isNotEmpty
                ? Container(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: store.offers.data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          minVerticalPadding: 5,
                          visualDensity: VisualDensity.comfortable,
                          enabled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                store.offers.data[i].mobileImageLink ??
                                    store.offers.data[i].imageLink),
                            radius: 40,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 0.0, bottom: 5),
                            child: Text(
                              store.offers.data[i].title.trim(),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            Helper()
                                .parseHtmlString(
                                    store.offers.data[i].description)
                                .trim(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: Colors.white54,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              // flutter defined function
                              showDialog(
                                useSafeArea: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        side: new BorderSide(
                                            width: 2,
                                            color: AppConstants.boxBorderColor),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(5))),
                                    backgroundColor: AppConstants.stcoinbgColor,
                                    elevation: 10,
                                    title:
                                        new Text("You are about to view code",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )),
                                    content: new Text(
                                        "Viewing code will deduct your 200 WTF Coins",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        )),
                                    actions: <Widget>[
                                      new ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                          shadowColor: Colors.black87,
                                          fixedSize: Size(
                                              ScreenUtil().screenWidth / 2 -
                                                  70.sp,
                                              0),
                                        ),
                                        child: new Text(
                                          "Continue",
                                          style: TextStyle(
                                            color: AppConstants.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          bool res = await store.saveRedeem(
                                              context: context,
                                              description: Helper()
                                                  .parseHtmlString(store.offers
                                                      .data[i].description)
                                                  .trim(),
                                              offername:
                                                  store.offers.data[i].title,
                                              offercode:
                                                  store.offers.data[i].code);
                                          if (res) {
                                            store.getCoinHistory(
                                                context: context);
                                            store.getRedeemHistory(
                                                context: context);
                                            _showDialog(store, i);
                                          } else {
                                            _showFailureDialog();
                                            // Fluttertoast.showToast(
                                            //     msg:
                                            //         "Your WTF Balance is not Sufficient to view this code");
                                          }
                                        },
                                      ),
                                      new ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                          elevation: 10,
                                          shadowColor: Colors.black87,
                                          fixedSize: Size(
                                              ScreenUtil().screenWidth / 2 -
                                                  70.sp,
                                              0),
                                        ),
                                        child: new Text(
                                          "Close",
                                          style: TextStyle(
                                            color: AppConstants.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: CustomActionButton(
                              label: "View Code",
                              height: 30,
                              width: 70,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return Container(
                          width: double.infinity,
                          child: Divider(color: Colors.white24),
                        );
                      },
                    ),
                  )
                : store.offerCategory == ""
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Loading(),
                      )
                    : Center(
                        child: Text(
                          'No Offers Available!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white70),
                        ),
                      )
            : Align(
                alignment: Alignment.topCenter,
                child: Loading(),
              ),
      ),
    );
  }

  void _showDialog(GymStore store, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppConstants.boxBorderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  AppConstants.stcoinbgColor,
                  AppConstants.primaryColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    height: .68.sh,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text('Offer terms:'),
                        Html(
                          data: store.offers.data[i].termAndCondition ?? '',
                          onAnchorTap: (url, context, attributes, element) =>
                              launch(url),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('How to avail for offer:'),
                        Html(
                          data: store.offers.data[i].redemptionProcess ?? '',
                          onAnchorTap: (url, context, attributes, element) =>
                              launch(url),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: AppConstants.bgColor,
                    ),
                    height: .05.sh,
                    width: .8.sw,
                    child: Center(
                      child: Text(store.offers.data.first.code,
                          style: TextStyle(
                            fontFamily: Fonts.ROBOTO,
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                              ClipboardData(text: store.offers.data.first.code))
                          .then((result) {
                        Fluttertoast.showToast(msg: "Coupon code copied");
                      });
                    },
                    child: Container(
                      height: .05.sh,
                      width: .8.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppConstants.stcoinbgColor,
                              AppConstants.primaryColor,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(0, 2), // Shadow position
                            )
                          ]),
                      child: Center(
                        child: Text(
                          "Copy Code",
                          style: TextStyle(
                            fontSize: 14.0,
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
      },
    );
  }

  void _showFailureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppConstants.boxBorderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  AppConstants.stcoinbgColor,
                  AppConstants.primaryColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 15, right: 15),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: .10.sh,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                            'Your WTF Balance is not Sufficient to view this code',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  //Spacer(),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationService.goBack;
                    },
                    child: Container(
                      height: .05.sh,
                      width: .8.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppConstants.stcoinbgColor,
                              AppConstants.primaryColor,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(0, 2), // Shadow position
                            )
                          ]),
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(
                            fontSize: 14.0,
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
      },
    );
  }
}
