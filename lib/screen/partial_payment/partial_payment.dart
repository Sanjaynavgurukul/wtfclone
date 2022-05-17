import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/model/partial_payment_model.dart';
import 'package:wtf/screen/common_widgets/time_line.dart';
import 'package:wtf/screen/subscriptions/argument/payment_process_argument.dart';
import 'package:wtf/screen/subscriptions/payment_process.dart';
import 'package:wtf/widget/progress_loader.dart';

import '../../main.dart';

class PartialPaymentScreen extends StatefulWidget {
  static const String routeName = '/partialPaymentScreen';

  const PartialPaymentScreen({Key key}) : super(key: key);

  @override
  State<PartialPaymentScreen> createState() => _PartialPaymentScreenState();
}

class _PartialPaymentScreenState extends State<PartialPaymentScreen> {
  //Local Variables :D
  GymStore store;
  bool callMethod = true;

  void callData({String subscription_id}) {
    print('called -----');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callMethod) {
        this.callMethod = false;
        store.getPartialPaymentStatus(subscription_id: subscription_id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Consumer<GymStore>(builder: (context, store, child) {
      if (store.activeSubscriptions.data.uid == null ||
          store.activeSubscriptions.data.uid.isEmpty) {
        return Center(
          child: Text('You don\'t have any subscription'),
        );
      } else {
        callData(subscription_id: store.activeSubscriptions.data.uid);
        if (store.partialPaymentModel == null) {
          return Loading();
        } else {
          if (store.partialPaymentModel.data.isEmpty ||
              store.partialPaymentModel.data == null) {
            return Center(child: Text('No Data Found'));
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.BACK_GROUND_BG,
                  title: Text('Partial Payment'),
                  // actions: [
                  //   TextButton(
                  //     onPressed: () {},
                  //     child: Text('Pay All', style: TextStyle(color: Colors.white)),
                  //   )
                  // ],
                ),
                body: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      Timeline(
                          padding: EdgeInsets.all(0),
                          lineColor: AppConstants.boxBorderColor,
                          children: store.partialPaymentModel.data
                              .asMap()
                              .entries
                              .map((e) => ListTile(
                                    leading: Image.asset(
                                      'assets/images/calender.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    title: Text('${getHeading(e.key)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                    subtitle: Text('\u{20B9}' + e.value.amount,
                                        style: TextStyle(
                                            color: AppConstants.greenDark,
                                            fontSize: 16)),
                                    trailing: e.value.status.toLowerCase() ==
                                            'pending'
                                        ? InkWell(
                                            onTap: () {
                                              store.selectedPartialPaymentData =
                                                  e.value;
                                              paySingle(item: e.value);
                                            },
                                            child: Container(
                                              constraints:
                                                  BoxConstraints(minWidth: 80),
                                              padding: EdgeInsets.only(
                                                  left: 12,
                                                  right: 12,
                                                  top: 6,
                                                  bottom: 6),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppConstants
                                                          .bgColor)),
                                              child: Text(
                                                e.key == 2
                                                    ? e.value.status
                                                                .toLowerCase() ==
                                                            'pending'
                                                        ? 'Pay in advance'
                                                        : 'Pay Now'
                                                    : "Pay Now",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            constraints:
                                                BoxConstraints(minWidth: 80),
                                            padding: EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                                top: 6,
                                                bottom: 6),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey
                                                        .withOpacity(0.5))),
                                            child: Text(
                                              "Paid",
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                  ))
                              .toList(),
                          indicators: store.partialPaymentModel.data
                              .asMap()
                              .entries
                              .map((e) => Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 12,
                                  ))
                              .toList()
                          // indicators: store.partialPaymentModel.data.map((e) => Icon(
                          //   Icons.circle,
                          //   color: Colors.white,
                          //   size: 12,
                          // )).toList()
                          )
                    ],
                  ),
                ));
          }
        }
      }
    });
  }

  String getHeading(int index) {
    switch (index) {
      case 1:
        return 'Second Payment';
        break;
      case 2:
        return 'Third Payment';
        break;
      default:
        return 'First Payment';
        break;
    }
  }

  void payAll() {
    //   {
    //     "uid":"",
    //   "status":"",
    //   "order_id":"",
    //   "payment_id":""
    // }
  }

  void paySingle({@required PartialPaymentData item}) async {
    double amount = double.parse(item.amount) * 100;

    Map<String,dynamic> paymentIdMap = {
      "amount": amount.toString(),
      "user_id": locator<AppPrefs>().memberId.getValue(),
      'value': {},
      'transaction_type': 'partial',
    };

    //Creating order Id from our DB
    String orderId = await store.generateRazorPayId(
        context: context, amount: amount.toString(), subBody: paymentIdMap);

    if (orderId == null || orderId.isEmpty) {
      print('checking partial null check --- null');
      showToast('Failed Create Order ID!!');
      return;
    } else {
      print('checking partial null check --- not null');
      //Data Map
      Map<String,dynamic> data = {
        "uid": item.uid,
        "status": "",
        "order_id": paymentIdMap,
        "payment_id": ""
      };
      print('checking partial null check --- after data');
      NavigationService.pushName(Routes.paymentProcess,
          argument: PaymentProcessArgument(
              data: data,
              paymentType: PaymentType.PAYMENT_PARTIAL,
              price: amount.toString(),
              orderId: orderId));
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message ?? 'Provide Message');
  }

  void processToPay() {}
}
