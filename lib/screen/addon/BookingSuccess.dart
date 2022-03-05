import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/slide_button.dart';

class PurchaseDone extends StatefulWidget {
  PurchaseDone({Key key}) : super(key: key);

  @override
  _PurchaseDoneState createState() => new _PurchaseDoneState();
}

class _PurchaseDoneState extends State<PurchaseDone> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 1300), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PurchaseDoneSummary()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xff922224),
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: new Text(
            'Your Order is successful',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Hero(
          tag: 'summaryAnimation',
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/svg/success_bg.svg',
                    semanticsLabel: 'Acme Logo'),
                Image.asset(
                  'assets/gif/payment_done.gif',
                  width: 260,
                ),
              ],
            ),
          ),
        ));
  }
}

class PurchaseDoneSummary extends StatelessWidget {
  const PurchaseDoneSummary({Key key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   GymStore gymStore = context.read<GymStore>();
  //   bool isFromAddon = gymStore.selectedSlotData != null ? true : false;
  //   return WillPopScope(
  //     onWillPop: () async {
  //       Navigator.of(NavigationService.navigatorKey.currentContext)
  //           .popUntil((route) => route.settings.name == Routes.homePage);
  //       return true;
  //     },
  //     child: Scaffold(
  //       // backgroundColor: AppColors.BACK_GROUND_BG,
  //       extendBodyBehindAppBar: true,
  //       appBar: AppBar(
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         title: Text(
  //           'Booking Detail',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 16.0,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
        // bottomNavigationBar: SlideButton(
        //   text:"Let\'s WTF",
        //   onTap:() {
        //     Navigator.of(NavigationService.navigatorKey.currentContext)
        //         .popUntil((route) => route.settings.name == Routes.homePage);
        //     NavigationService.navigatorKey.currentContext
        //         .read<GymStore>()
        //         .init(context: context);
        //     NavigationService.navigatorKey.currentContext
        //         .read<GymStore>()
        //         .changeNavigationTab(index: 2);
        //   },
        // ),
  //       body: SingleChildScrollView(
  //         child: Scaffold(
  //           child: Column(children: [
  //             Stack(
  //               children: <Widget>[
  //                 Hero(
  //                     tag: 'summaryAnimation',
  //                     child: Container(
  //                       height: 360,
  //                       color: Color(0xff922224),
  //                       padding: EdgeInsets.only(bottom: 100),
  //                       alignment: Alignment.center,
  //                       child: SafeArea(
  //                         child: Stack(
  //                           alignment: Alignment.center,
  //                           children: [
  //                             SvgPicture.asset('assets/svg/success_bg.svg',
  //                                 semanticsLabel: 'Acme Logo'),
  //                             Image.asset(
  //                               'assets/gif/payment_done.gif',
  //                               width: 120,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     )),
  //                 Container(
  //                   //color: Colors.white,
  //                   padding: EdgeInsets.only(top: 310, left: 16, right: 16),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(8)),
  //                         color: Color(0xff292929)),
  //                     padding:
  //                     EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
  //                     child: Column(
  //                       children: [
  //                         amountLabel(label: 'Booked at', value: 'Mass Monster'),
  //                         SizedBox(height: 8),
  //                         amountLabel(label: 'Booked at', value: 'Mass Monster'),
  //                         SizedBox(height: 8),
  //                         amountLabel(label: 'Booked at', value: 'Mass Monster'),
  //                         SizedBox(height: 8),
  //                         amountLabel(label: 'Booked at', value: 'Mass Monster'),
  //                         SizedBox(height: 8),
  //                         amountLabel(label: 'Booked at', value: 'Mass Monster'),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(left: 16, right: 16),
  //               margin: EdgeInsets.only(bottom: 0,top: 20),
  //               child: Text.rich(
  //                 TextSpan(
  //                   children: <WidgetSpan>[
  //                     WidgetSpan(child: Icon(Icons.add)),
  //                     WidgetSpan(child: Text('Coins Earned - ',style:TextStyle(fontSize: 14,fontWeight:FontWeight.w400))),
  //                     WidgetSpan(child: Text('500',style:TextStyle(fontSize: 14,fontWeight:FontWeight.w400))),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(left: 16, right: 16),
  //               margin: EdgeInsets.only(bottom: 12,top: 4),
  //               child: Text('Total Coins balance - 13500',style:TextStyle(fontSize: 14,fontWeight:FontWeight.w400)),
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(left: 16, right: 16),
  //               margin: EdgeInsets.only(left: 16, right: 16, top: 18),
  //               child: InkWell(
  //                 onTap: () {},
  //                 borderRadius: BorderRadius.all(Radius.circular(100)),
  //                 child: Container(
  //                     width: double.infinity,
  //                     padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
  //                     alignment: Alignment.center,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(100)),
  //                         color: AppConstants.boxBorderColor),
  //                     child: Text("Redeem", style: TextStyle(fontSize: 16))),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.only(left: 16, right: 16),
  //               margin: EdgeInsets.only(left: 16, right: 16, top: 18),
  //               child: InkWell(
  //                 onTap: () {},
  //                 borderRadius: BorderRadius.all(Radius.circular(100)),
  //                 child: Container(
  //                     width: double.infinity,
  //                     padding:
  //                     EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
  //                     alignment: Alignment.center,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(100)),
  //                         border: Border.all(
  //                             width: 1, color: AppConstants.boxBorderColor)),
  //                     child: Text("Back to home", style: TextStyle(fontSize: 16))),
  //               ),
  //             )
  //           ]),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.read<GymStore>();
    bool isFromAddon = gymStore.selectedSlotData != null ? true : false;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(NavigationService.navigatorKey.currentContext)
            .popUntil((route) => route.settings.name == Routes.homePage);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            AppBar(
              backgroundColor: Color(0xff922224),
              elevation: 0,
              title: Text(
                'Booking Detail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Hero(
                    tag: 'summaryAnimation',
                    child: Container(
                      height: 360,
                      color: Color(0xff922224),
                      padding: EdgeInsets.only(bottom: 100),
                      alignment: Alignment.center,
                      child: SafeArea(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/success_bg.svg',
                                semanticsLabel: 'Acme Logo'),
                            Image.asset(
                              'assets/gif/payment_done.gif',
                              width: 120,
                            ),
                          ],
                        ),
                      ),
                    )),
                Container(
                  //color: Colors.white,
                  padding: EdgeInsets.only(top: 310, left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xff292929)),
                    padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
                    child:isFromAddon?Column(
                      children: [
                        amountLabel(label: 'Booked at:', value: '${gymStore.selectedGymDetail.data.gymName ??''}'),
                        SizedBox(height: 12),
                        amountLabel(label: 'AddOn:', value: '${gymStore.selectedAddOnSlot.name??''}'),
                        SizedBox(height: 12),
                        amountLabel(label: 'Date Added:', value: '${Helper.stringForDatetime2(gymStore.selectedAddOnSlot.dateAdded) ??''}'),
                        SizedBox(height: 12),
                        amountLabel(label: 'End Date:', value: gymStore.isFreeSession
                            ? "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.toIso8601String())}"
                            : "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.add(
                          Duration(
                              days: int.tryParse(gymStore
                                  .selectedSession.duration)),
                        ).toIso8601String())}"),
                        SizedBox(height: 12),
                        amountLabel(label: 'Begin Time:', value: '${gymStore.selectedSlotData.startTime??''}'),
                        SizedBox(height: 12),
                        amountLabel(label: 'Session count:', value: '${gymStore.selectedSlotData.slot??''}'),
                        SizedBox(height: 12),
                      ],
                    ): Column(
                      children: [
                        amountLabel(label: 'Booked at:', value: '${gymStore.selectedGymDetail.data.gymName ??''}'),
                        SizedBox(height: 12),
                        amountLabel(label: 'Membership:', value: 'WTF Arena Membership'),
                        SizedBox(height: 12),
                        amountLabel(label: 'Plan:', value: '${gymStore.selectedGymPlan.plan_name ?? ''}'),
                        SizedBox(height: 12),
                        amountLabel(label: 'Begin Date:', value: '${Helper.stringForDatetime2(gymStore
                            .selectedStartingDate
                            .toIso8601String())??''}'),
                        SizedBox(height: 12),
                        amountLabel(label: 'End Date:', value: '${Helper.stringForDatetime2(gymStore.selectedStartingDate.add(
                          Duration(
                            days: int.tryParse(
                              gymStore.selectedGymPlan.duration,
                            ),
                          ),
                        ).toIso8601String())??''}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              margin: EdgeInsets.only(left: 16, right: 16, top: 18),
              child: InkWell(
                onTap: () {
                  NavigationService.navigateToReplacement(
                      Routes.allcoin);
                  Navigator.of(NavigationService.navigatorKey.currentContext)
                      .popUntil((route) => route.settings.name == Routes.homePage);
                  NavigationService.navigatorKey.currentContext
                      .read<GymStore>()
                      .init(context: context);
                  // NavigationService.navigatorKey.currentContext
                  //     .read<GymStore>()
                  //     .changeNavigationTab(index: 2);
                },
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Container(
                    width: double.infinity,
                    padding:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: AppConstants.boxBorderColor),
                    child: Text("Redeem", style: TextStyle(fontSize: 16))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              margin: EdgeInsets.only(left: 16, right: 16, top: 18),
              child: InkWell(
                onTap: () {
                  Navigator.of(NavigationService.navigatorKey.currentContext)
                      .popUntil((route) => route.settings.name == Routes.homePage);
                  NavigationService.navigatorKey.currentContext
                      .read<GymStore>()
                      .init(context: context);
                  NavigationService.navigatorKey.currentContext
                      .read<GymStore>()
                      .changeNavigationTab(index: 2);
                },
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Container(
                    width: double.infinity,
                    padding:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        border: Border.all(
                            width: 1, color: AppConstants.boxBorderColor)),
                    child: Text("Back to home", style: TextStyle(fontSize: 16))),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget amountLabel({String label, String value}) {
    return Row(
      children: [
        Text(label ?? '',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        Spacer(),
        Text('${value ?? ''}')
      ],
    );
  }

  Widget oldUI(GymStore gymStore){
    bool isFromAddon = gymStore.selectedSlotData != null ? true : false;
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            UIHelper.verticalSpace(12.0),
            CircleAvatar(
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 50,
              ),
              backgroundColor: Colors.green,
              radius: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Booking successful',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40.0, vertical: 20),
              child: Consumer<GymStore>(
                builder: (context, store, child) => Text(
                  isFromAddon
                      ? 'Your ${gymStore.selectedAddOnSlot.name ?? ''} sessions at the ${gymStore.selectedGymDetail.data.gymName ?? ''} is confirmed on ${gymStore.selectedSlotData.startTime}'
                      : 'Your ${gymStore.selectedGymPlan.plan_name ?? ''} subscription at the ${gymStore.selectedGymDetail.data.gymName ?? ''} is confirmed on ${Helper.formatDate(gymStore.selectedStartingDate.toIso8601String())}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: gymStore.selectedGymPlan != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booked at:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Flexible(
                        child: Text(
                          gymStore.selectedGymDetail.data.gymName,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Membership:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "WTF Arena Membership",
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plan:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        gymStore.selectedGymPlan.plan_name ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Begin Date:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        Helper.stringForDatetime2(gymStore
                            .selectedStartingDate
                            .toIso8601String()),
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "End Date:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${Helper.stringForDatetime2(gymStore.selectedStartingDate.add(
                          Duration(
                            days: int.tryParse(
                              gymStore.selectedGymPlan.duration,
                            ),
                          ),
                        ).toIso8601String())}",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booked at:",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        gymStore.selectedGymDetail.data.gymName,
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AddOn :",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text:
                            '${gymStore.selectedAddOnSlot.name} ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                            children: [
                              if (gymStore.selectedSession != null)
                                TextSpan(
                                  text:
                                  ' (${gymStore.selectedSession.nSession} Sessions)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  if (gymStore.selectedTrainer != null)
                    Divider(
                      thickness: 0.7,
                      color: Colors.white,
                    ),
                  if (gymStore.selectedTrainer != null)
                    SizedBox(height: 4.0),
                  if (gymStore.selectedTrainer != null)
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trainer :",
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${gymStore.selectedTrainer.name} ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                            children: [
                              // if (gymStore.selectedSession != null)
                              //   TextSpan(
                              //     text:
                              //         ' (${gymStore.selectedSession.nSession} Sessions)',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 15.0,
                              //     ),
                              //   ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  if (gymStore.selectedTrainer != null)
                    SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Begin Time: ",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        gymStore.selectedSlotData.startTime,
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Begin Date:",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.toIso8601String())}",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Date:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        gymStore.isFreeSession
                            ? "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.toIso8601String())}"
                            : "${Helper.stringForDatetime2(gymStore.selectedSlotData.date.add(
                          Duration(
                              days: int.tryParse(gymStore
                                  .selectedSession.duration)),
                        ).toIso8601String())}",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  stepsItem(string) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 3,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                string,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}

class EventPurchaseDone extends StatelessWidget {
  const EventPurchaseDone({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GymStore gymStore = context.read<GymStore>();
    return WillPopScope(
      onWillPop: () async {
        gymStore.init(context: context);
        Navigator.of(NavigationService.navigatorKey.currentContext)
            .popUntil((route) => route.settings.name == Routes.homePage);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(
            'Booking Detail',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: SlideButton(
          text:"Let\'s WTF",
          onTap:() {
            Navigator.of(NavigationService.navigatorKey.currentContext)
                .popUntil((route) => route.isFirst);
            NavigationService.navigatorKey.currentContext
                .read<GymStore>()
                .init(context: context);
            NavigationService.navigatorKey.currentContext
                .read<GymStore>()
                .changeNavigationTab(index: 2);
            // NavigationService.navigateTo(Routes.scheduleSlotPage);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UIHelper.verticalSpace(20.0),
            CircleAvatar(
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 50,
              ),
              backgroundColor: Colors.green,
              radius: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Booking successful',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: Text(
                'You\'ve successfully taken participation in - ${gymStore.selectedEventData.name ?? ''}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event :",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${gymStore.selectedEventData.name}",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Duration:",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${gymStore.selectedEventData.timeFrom} to ${gymStore.selectedEventData.timeTo}',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Date:",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        Helper.stringForDatetime2(
                                gymStore.selectedEventData.date) ??
                            '',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Divider(
                    thickness: 0.7,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   color: Color(0xff333333),
            //   alignment: Alignment.center,
            //   width: double.maxFinite,
            //   child: Text(
            //     'Steps to unlock your session',
            //     style: TextStyle(
            //       fontSize: 20,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // for (int i = 0; i < 3; i++)
            //   stepsItem(
            //       'Navigate to unlock your booking slider on home screen'),
            // Spacer(),
            // Spacer(),

            Spacer(),
          ],
        ),
      ),
    );
  }


  Widget oldUI(BuildContext context,GymStore gymStore){
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Booking Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: SlideButton(
        text:"Let\'s WTF",
        onTap:() {
          Navigator.of(NavigationService.navigatorKey.currentContext)
              .popUntil((route) => route.isFirst);
          NavigationService.navigatorKey.currentContext
              .read<GymStore>()
              .init(context: context);
          NavigationService.navigatorKey.currentContext
              .read<GymStore>()
              .changeNavigationTab(index: 2);
          // NavigationService.navigateTo(Routes.scheduleSlotPage);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UIHelper.verticalSpace(20.0),
          CircleAvatar(
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: 50,
            ),
            backgroundColor: Colors.green,
            radius: 40,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Booking successful',
            style: TextStyle(
              fontSize: 20,
              color: Colors.green,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: Text(
              'You\'ve successfully taken participation in - ${gymStore.selectedEventData.name ?? ''}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(height: 4.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event :",
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "${gymStore.selectedEventData.name}",
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Divider(
                  thickness: 0.7,
                  color: Colors.white,
                ),
                SizedBox(height: 4.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event Duration:",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${gymStore.selectedEventData.timeFrom} to ${gymStore.selectedEventData.timeTo}',
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Divider(
                  thickness: 0.7,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event Date:",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      Helper.stringForDatetime2(
                          gymStore.selectedEventData.date) ??
                          '',
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Divider(
                  thickness: 0.7,
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          // Container(
          //   padding: EdgeInsets.all(10),
          //   color: Color(0xff333333),
          //   alignment: Alignment.center,
          //   width: double.maxFinite,
          //   child: Text(
          //     'Steps to unlock your session',
          //     style: TextStyle(
          //       fontSize: 20,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // for (int i = 0; i < 3; i++)
          //   stepsItem(
          //       'Navigate to unlock your booking slider on home screen'),
          // Spacer(),
          // Spacer(),

          Spacer(),
        ],
      ),
    );
  }
  stepsItem(string) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 3,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                string,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
