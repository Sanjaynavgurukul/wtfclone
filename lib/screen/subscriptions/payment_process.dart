import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/src/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rxdart/subjects.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/VerifyPayment.dart';
import 'package:wtf/screen/purchase_done/BookingSuccess.dart';
import 'package:wtf/screen/purchase_done/argument/purchase_done_argument.dart';
import 'package:wtf/screen/subscriptions/argument/payment_process_argument.dart';
import 'package:wtf/widget/processing_dialog.dart';

enum PaymentType { PAYMENT_PARTIAL, PAYMENT_REGULAR }

class PaymentProcess extends StatefulWidget {
  const PaymentProcess({Key key}) : super(key: key);
  static const String routeName = '/paymentProcess';

  @override
  _PaymentProcessState createState() => _PaymentProcessState();
}

class _PaymentProcessState extends State<PaymentProcess> {
  static const platform = const MethodChannel("razorpay_flutter");
  bool isOpen = false;
  Razorpay _razorpay;
  GymStore store;
  Map<String, dynamic> paymentBody = {};
  PaymentProcessArgument _paymentProcessArgument;

  final uiStream = BehaviorSubject<PaymentStatusModel>();

  Function(PaymentStatusModel) get setUiStream => uiStream.sink.add;

  Stream<PaymentStatusModel> get getUiStream => uiStream.stream;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    store = context.watch<GymStore>();
  }

  @override
  void initState() {
    super.initState();
    setUiStream(getStatusModel(PaymentStatus.PROGRESS));
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
    uiStream.close();
  }

  void openCheckout(PaymentProcessArgument value) async {
    this.isOpen = true;
    var options = {
      "key": Helper.razorPayKey,
      "amount": value.price.toString(),
      'currency': 'INR',
      'description':
          'Pay to buy ${value.data['type'] == 'regular' ? 'Gym' : value.data['type'] == 'event' ? 'Event' : value.data['type'] == 'addon' ? 'Addon' : 'PT'} Subscription',
      'order_id': value.orderId,
      "name": 'WTF',
      'prefill': {
        "contact": locator<AppPrefs>().phoneNumber.getValue(),
        "email": locator<AppPrefs>().userEmail.getValue(),
      },
    };
    // var options = {
    //   'key': 'rzp_live_ILgsfZCZoFIKMb',
    //   'amount': 100,
    //   'name': 'Acme Corp.',
    //   'description': 'Fine T-Shirt',
    //   'retry': {'enabled': true, 'max_count': 1},
    //   'send_sms_hash': true,
    //   'prefill': {'contact': '7761826600', 'email': 'aminemshaw@gmail.com'},
    //   'external': {
    //     'wallets': ['paytm']
    //   }
    // };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('razor error ---  Success Response: $response');
    // this._pStatus = getStatusModel(PaymentStatus.VERIFY_PAYMENT);
    setUiStream(getStatusModel(PaymentStatus.VERIFY_PAYMENT));
    await store
        .verifyRazorPayPayment(response.paymentId, wantDialog: false)
        .then((verifyPayment) {
      if (verifyPayment != null &&
          verifyPayment.data != null &&
          verifyPayment.data.status == 'captured') {
        verifyPaymentInDB(response: response, paymentFailed: false);
      } else {
        verifyPaymentInDB(response: response, paymentFailed: true);
      }
    });
    // await store.verifyRazorPayPayment(response.paymentId)
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print('razor error --- Error Response: $response');
    setUiStream(getStatusModel(PaymentStatus.FAILED));
    var map = _paymentProcessArgument.data;
    if (_paymentProcessArgument.paymentType == PaymentType.PAYMENT_PARTIAL) {
      map['payment_id'] = '';
      map['status'] = 'failed';
      await store.updatePartialPaymentStatus(body:map);
      navigateFailed();
    } else {
      map['trx_id'] = '';
      map['trx_status'] = 'failed';
      map['order_status'] = 'failed';
      await store.addSubscription(
        body: map,
      );
      navigateFailed();
    }
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('razor error --- External SDK Response: $response');
    // this._pStatus = getStatusModel(PaymentStatus.CANCEL);
    setUiStream(getStatusModel(PaymentStatus.CANCEL));
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  Future<VerifyPayment> verifyRazorPayPayment(String razorPayPaymentId) async {
    // showDialog(
    //   context: paymentContext,
    //   builder: (context) => ProcessingDialog(
    //     message: 'Creating your order,  Please wait...',
    //   ),
    // );
    Map<String, dynamic> body = {'razorpay_payment_id': razorPayPaymentId};
    VerifyPayment verifyPayment =
        await RestDatasource().verifyRazorPayPayment(body: body);
    // Navigator.pop(paymentContext);
    return verifyPayment;
  }

  void verifyPayment(
      {@required PaymentSuccessResponse response,
      @required bool failed}) async {
    var map = _paymentProcessArgument.data;
    setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER));
    map['trx_id'] = response.paymentId;
    map['trx_status'] = 'done';
    map['order_status'] = 'done';

    //Making Subscription :D
    bool isDone = await store.addSubscription(
      body: map,
    );

    if (isDone) {
      //_nullData();
      if (map['type'] == 'event') {
        await store.addEventParticipation(context: context).then((value) {
          if (value) {
            setUiStream(getStatusModel(PaymentStatus.EVENT_ORDER_SUCCESS));
            navigateToEventPurchaseDone();
          } else {
            setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_FAILED));
            navigateFailed();
          }
        });
      } else {
        setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_SUCCESS));
        navigateToPurchaseDone();
      }
      store.init(context: context);
    } else {
      //TODO failed Purchase Order not in payment :D
      setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_FAILED));
      navigateFailed();
      // FlashHelper.errorBar(paymentContext,
      //     message:
      //     'Failed to subscribe, Please contact support for resolution');
    }
  }

  void verifyPaymentInDB(
      {@required PaymentSuccessResponse response,
      @required bool paymentFailed}) async {
    // if(paymentFailed){
    //   setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER));
    // }else{
    //   setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER));
    // }
    setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER));

    var map = _paymentProcessArgument.data;
    setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER));

    //Partial purchase Payment
    if (_paymentProcessArgument.paymentType == PaymentType.PAYMENT_PARTIAL) {
      map['payment_id'] = response.paymentId;
      map['status'] = paymentFailed ? "failed" : 'completed';
      bool isDone = await store.updatePartialPaymentStatus(body:map);
      if(isDone){
        setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_SUCCESS));
        Future.delayed(const Duration(seconds: 3), () {
          NavigationService.navigateToReplacement(Routes.purchaseDone,argument: PurchaseDoneArgument(purchaseDoneType: PurchaseDoneType.PURCHASE_DONE_PARTIAL));
        });
      }else{
        setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_FAILED));
        navigateFailed();
      }
    } else {
      //Regular Purchase Payment
      map['trx_id'] = response.paymentId;
      map['trx_status'] = paymentFailed ? "failed" : 'done';
      map['order_status'] = paymentFailed ? "failed" : 'done';

      //Making Subscription :D
      bool isDone = await store.addSubscription(
        body: map,
      );
      if (isDone) {
        //_nullData();
        if (map['type'] == 'event') {
          await store.addEventParticipation(context: context).then((value) {
            if (value) {
              setUiStream(getStatusModel(PaymentStatus.EVENT_ORDER_SUCCESS));
              navigateToEventPurchaseDone();
            } else {
              setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_FAILED));
              navigateFailed();
            }
          });
        } else {
          setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_SUCCESS));
          navigateToPurchaseDone();
        }
        store.init(context: context);
      } else {
        //TODO failed Purchase Order not in payment :D
        setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_FAILED));
        navigateFailed();
        // FlashHelper.errorBar(paymentContext,
        //     message:
        //     'Failed to subscribe, Please contact support for resolution');
      }
    }
  }

  // void verifyRazorPayPaymentVerified({@required PaymentSuccessResponse response})async{
  //   var map = _paymentProcessArgument.data;
  //   setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER));
  //   map['trx_id'] = response.paymentId;
  //   map['trx_status'] = 'done';
  //   map['order_status'] = 'done';
  //
  //   //Making Subscription :D
  //   bool isDone = await store.addSubscription(
  //     body: map,
  //   );
  //
  //   if (isDone) {
  //     //_nullData();
  //     if (map['type'] == 'event') {
  //       await store.addEventParticipation(context: context).then((value){
  //         if(value){
  //           setUiStream(getStatusModel(PaymentStatus.EVENT_ORDER_SUCCESS));
  //           navigateToEventPurchaseDone();
  //         }else{
  //           setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_FAILED));
  //           navigateFailed();
  //         }
  //       });
  //     } else {
  //       setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_SUCCESS));
  //       navigateToPurchaseDone();
  //     }
  //     store.init(context: context);
  //   } else {
  //     //TODO failed Purchase Order not in payment :D
  //     setUiStream(getStatusModel(PaymentStatus.MAKING_ORDER_FAILED));
  //     navigateFailed();
  //     // FlashHelper.errorBar(paymentContext,
  //     //     message:
  //     //     'Failed to subscribe, Please contact support for resolution');
  //   }
  // }

  void navigateToPurchaseDone() {
    Future.delayed(const Duration(seconds: 3), () {
      NavigationService.navigateToReplacement(Routes.purchaseDone);
    });
  }

  void navigateToEventPurchaseDone() {
    Future.delayed(const Duration(seconds: 3), () {
      NavigationService.navigateToReplacement(Routes.eventPurchaseDone);
    });
  }

  void navigateFailed() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final PaymentProcessArgument args =
        ModalRoute.of(context).settings.arguments as PaymentProcessArgument;

    if (args == null ||
        args.price == null ||
        args.data == null ||
        args.orderId == null ||
        args.orderId.isEmpty) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            ),
            // SpinKitRipple(
            //   color: Colors.white,
            //   size: 80.0,
            // ),
            lottieImage(name: 'failed', width: 100, repeat: false),
            ListTile(
              title: Text(
                'Payment Failed',
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'Something Went wrong please try again later',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else {
      this._paymentProcessArgument = args;
      if (!isOpen) {
        Future.delayed(const Duration(seconds: 2), () {
          openCheckout(args);
        });
      }
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Container(
          child: StreamBuilder(
            stream: uiStream,
            initialData: getStatusModel(PaymentStatus.PROGRESS),
            builder: (BuildContext context,
                AsyncSnapshot<PaymentStatusModel> snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  // SpinKitRipple(
                  //   color: Colors.white,
                  //   size: 80.0,
                  // ),
                  lottieImage(
                      name: snapshot.data.animationName,
                      width: 100,
                      repeat: snapshot.data.animationName == 'failed'
                          ? false
                          : true),
                  ListTile(
                    title: Text(
                      '${snapshot.data.heading}',
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      '${snapshot.data.subHeading}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // ElevatedButton(onPressed: openCheckout, child: Text('Open')),
                ],
              );
            },
          ),
        )),
      );
    }
  }

  Widget lottieImage(
      {@required String name, double width = 80, bool repeat = true}) {
    return Container(
      width: width,
      height: width,
      child: Lottie.asset('assets/lottie/$name.json', repeat: repeat),
    );
  }

  // Widget oldUI() {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Razorpay Sample App'),
  //     ),
  //     body: Center(
  //         child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //           ElevatedButton(onPressed: openCheckout, child: Text('Open')),
  //           SpinKitRipple(
  //             color: Colors.white,
  //             size: 50.0,
  //           )
  //         ])),
  //   );
  // }

  PaymentStatusModel getStatusModel(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.SUCCESS:
        return PaymentStatusModel(
            heading: 'Congratulation',
            subHeading: 'Your order has been confirmed',
            message: 'Some Message',
            animationName: 'done');
      case PaymentStatus.FAILED:
        return PaymentStatusModel(
            heading: 'Payment Failed',
            subHeading: 'Something went wrong ',
            message: 'Some Message',
            animationName: 'failed');
      case PaymentStatus.CANCEL:
        return PaymentStatusModel(
            heading: 'Payment Cancelled',
            subHeading:
                'You payment has been cancelled please try again later ',
            message: 'Some Message',
            animationName: 'failed');
      case PaymentStatus.MAKING_ORDER:
        return PaymentStatusModel(
            heading: 'Ordering',
            subHeading: 'Please wait while we are making your order ',
            message: 'Some Message',
            animationName: 'progress');
      case PaymentStatus.MAKING_ORDER_FAILED:
        return PaymentStatusModel(
            heading: 'Order Failed',
            subHeading: 'We are unable to place your order!',
            message: 'If your amount deduct please contact WTF Support Center',
            animationName: 'failed');
      case PaymentStatus.MAKING_ORDER_SUCCESS:
        return PaymentStatusModel(
            heading: 'Order Completed',
            subHeading: 'Your Order SuccessFully Placed',
            message: 'If your amount deduct please contact WTF Support Center',
            animationName: 'done');
      case PaymentStatus.EVENT_ORDER_FAILED:
        return PaymentStatusModel(
            heading: 'Order Failed',
            subHeading: 'We are unable to place your event order!',
            message: 'If your amount deduct please contact WTF Support Center',
            animationName: 'failed');
      case PaymentStatus.EVENT_ORDER_SUCCESS:
        return PaymentStatusModel(
            heading: 'Order Completed',
            subHeading: 'Your Order SuccessFully Placed',
            message: 'Some Description :D',
            animationName: 'done');
      case PaymentStatus.VERIFY_PAYMENT:
        return PaymentStatusModel(
            heading: 'Verifying your payment',
            subHeading: 'Please wait while we verifying payment',
            message: 'Some Message',
            animationName: 'progress');
      default:
        return PaymentStatusModel(
            heading: 'Payment in Progress',
            subHeading: 'Please do not back or close app',
            message: 'Some Message',
            animationName: 'progress');
    }
  }
}

enum PaymentStatus {
  FAILED,
  SUCCESS,
  CANCEL,
  PROGRESS,
  MAKING_ORDER,
  MAKING_ORDER_FAILED,
  MAKING_ORDER_SUCCESS,
  VERIFY_PAYMENT,
  EVENT_ORDER_FAILED,
  EVENT_ORDER_SUCCESS,
}

class PaymentStatusModel {
  String animationName;
  String heading;
  String subHeading;
  String message;

  PaymentStatusModel(
      {@required this.heading,
      @required this.subHeading,
      @required this.message,
      @required this.animationName});
}
