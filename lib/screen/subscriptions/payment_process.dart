import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wtf/screen/subscriptions/argument/payment_process_argument.dart';

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
  PaymentStatusModel _pStatus;

  @override
  void initState() {
    super.initState();
    _pStatus = getStatusModel(PaymentStatus.PROGRESS);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    this.isOpen = true;
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '7761826600', 'email': 'aminemshaw@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('razor error ---  Success Response: $response');
    _pStatus = getStatusModel(PaymentStatus.MAKING_ORDER);
    setState(() {
    });
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _pStatus = getStatusModel(PaymentStatus.FAILED);
    setState(() {
    });
    print('razor error --- Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('razor error --- External SDK Response: $response');
    _pStatus = getStatusModel(PaymentStatus.CANCEL);
    setState(() {
    });
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  @override
  Widget build(BuildContext context) {
    final PaymentProcessArgument args =
    ModalRoute.of(context).settings.arguments as PaymentProcessArgument;

    if(args == null || args.price == null || args.data == null){
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
            lottieImage(
                name: 'failed',
                width: 100,
                repeat: false),
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
    }else {
      if(!isOpen){
        Future.delayed(const Duration(seconds: 2), () {
          openCheckout();
        });
      }
      return Scaffold(
          body: Container(
            child: Column(
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
                    name: _pStatus.animationName,
                    width: 100,
                    repeat: _pStatus.animationName == 'failed' ? false : true),
                ListTile(
                  title: Text(
                    'Paymen in progress',
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Please do not close the window or app',
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(onPressed: openCheckout, child: Text('Open')),
              ],
            ),
          ));
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

  Widget oldUI() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razorpay Sample App'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            ElevatedButton(onPressed: openCheckout, child: Text('Open')),
            SpinKitRipple(
              color: Colors.white,
              size: 50.0,
            )
          ])),
    );
  }

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
      default:
        return PaymentStatusModel(
            heading: 'Payment in Progress',
            subHeading: 'Please do not back or close app',
            message: 'Some Message',
            animationName: 'progress');
    }
  }
}

enum PaymentStatus { FAILED, SUCCESS, CANCEL, PROGRESS, MAKING_ORDER }

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
