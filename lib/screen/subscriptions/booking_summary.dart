import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/explore_controller_presenter.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/common_function.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/global.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/preamble_helper.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/common_model.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/model/gym_plan_model.dart';
import 'package:wtf/model/gym_search_model.dart';
import 'package:wtf/model/gym_slot_model.dart';
import 'package:wtf/screen/gym/arguments/plan_page_argument.dart';
import 'package:wtf/screen/gym/gym_membership_plan_page.dart';
import 'package:wtf/screen/subscriptions/argument/payment_process_argument.dart';
import 'package:wtf/screen/subscriptions/buy_subscription_screen.dart';
import 'package:wtf/widget/progress_loader.dart';

class BookingSummaryScreen extends StatefulWidget {
  @override
  _BookingSummaryScreenState createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen>
    implements ExploreContract {
  ScrollController _controller = ScrollController();
  ExplorePresenter _presenter;

  // GymSearchModel _searchResultModel;
  bool isLoaded = true;
  bool _isChecked = false;
  GymStore gymStore;
  int discountAmount = 0;
  int totalAmount = 0;
  int tax = 0;
  int _radioValue = 0;
  TextEditingController couponCodeController;
  PlanColor _planColor;

  // Map subscriptionBody;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _presenter = new ExplorePresenter(this);
    // if (context.read<GymStore>().chosenOffer != null) {
    //   couponApplied = true;
    // }
    couponCodeController = TextEditingController();
    couponCodeController = TextEditingController(
        text: context.read<GymStore>().chosenOffer != null
            ? context.read<GymStore>().chosenOffer.code
            : '');
    // getGyms();

    calculateFinalPrice();
  }

  void calculateFinalPrice() {
    tax = 0;
    totalAmount = 0;
    discountAmount = 0;
    if (context.read<GymStore>().chosenOffer != null) {
      print('chosenOffer called not null');
      if (context.read<GymStore>().chosenOffer.type == 'flat') {
        discountAmount =
            int.tryParse(context.read<GymStore>().chosenOffer.value);
        //     print('sanjay check discount value -- $couponValue');
        //     int actualP = int.parse(context.read<GymStore>().selectedGymPlan.plan_price);
        //     print('sanjay check actualP -- $actualP');
        //       // (50/200)*100
        //     int dP = ((couponValue/actualP)*100).truncate();
        //     discountAmount = (actualP * dP / 100).truncate();
        //
        //     print('sanjay check discount dp -- $dP');
        // // discountAmount = couponValue >
        //     //         int.tryParse(context.read<GymStore>().selectedEventData.price??'0')
        //     //     ? int.tryParse(context.read<GymStore>().selectedEventData.price)
        //     //     : couponValue;
      } else {
        print('price: ${context.read<GymStore>().selectedGymPlan.plan_price}');
        print('offer val: ${context.read<GymStore>().chosenOffer.value}');
        discountAmount =
            (int.tryParse(context.read<GymStore>().selectedGymPlan.plan_price) *
                    int.tryParse(context.read<GymStore>().chosenOffer.value) /
                    100)
                .truncate();
      }
    } else {
      print('chosenOffer called null');
    }

    totalAmount =
        int.tryParse(context.read<GymStore>().selectedGymPlan.plan_price) -
            discountAmount;
    tax = (totalAmount *
            int.tryParse(
                context.read<GymStore>().selectedGymPlan.tax_percentage) /
            100)
        .truncate();
    totalAmount = tax +
        int.tryParse(context.read<GymStore>().selectedGymPlan.plan_price) -
        discountAmount;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
  }

  void applyCoupon() {
    if (couponCodeController.text != '') {
      context
          .read<GymStore>()
          .getCoupon(
              couponCodeController.text, gymStore.selectedGymPlan.plan_uid)
          .then((value) {
        if (value != null) {
          print('check the apply ${value.value}');
          gymStore.applyCoupon(context: context, data: value).then((value) {
            setState(() {
              print('set');
              calculateFinalPrice();
            });
          });
        } else {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Offer does not exists!'),
            ));
            couponCodeController.text = '';
          });
        }
      });
    }
  }

  String validateEmiPayment() {
    var data = gymStore.selectedGymDetail.data;
    if (data.first_payment == null || data.first_payment_amount == null)
      return 'First EMI Data Invalid';
    else if (data.second_payment == null || data.second_payment_amount == null)
      return 'Second EMI Data Invalid';
    else if (data.third_payment == null || data.third_payment_amount == null)
      return 'Third EMI Data Invalid';
    else
      return null;
  }

  void removeCoupon() {
    gymStore.removeOffer();
    setState(() {
      couponCodeController.text = '';
      calculateFinalPrice();
    });
  }

  Widget suffix(String text) {
    print('------- called ${text}');
    return gymStore.chosenOffer != null
        ? InkWell(
            onTap: () {
              removeCoupon();
            },
            child: Text('Remove',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.boxBorderColor)),
          )
        : text.isNotEmpty
            ? InkWell(
                onTap: () {
                  applyCoupon();
                },
                child: Text('Apply',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))
            : SizedBox(
                height: 0,
              );
  }

  num getPendingAmount(int amount) {
    return 0;
  }

  void processToBuy({bool isCash = false}) async {
    print('method called------');
    Map<String, dynamic> body = {};
    // Default Key Values
    body["gym_id"] = gymStore.selectedGymDetail.data.userId;
    body["user_id"] = locator<AppPrefs>().memberId.getValue();
    body["price"] = totalAmount.toString();
    body["tax_percentage"] = gymStore.selectedGymPlan.tax_percentage;
    body["tax_amount"] = tax.toString();
    body["type"] = 'regular';
    body["slot_id"] = '';
    body["addon"] = "";
    body["start_date"] = Helper.stringForDatetime3(
        gymStore.selectedStartingDate.toIso8601String().trim());
    print(
        'Checking date : ----  ${Helper.stringForDatetime3(gymStore.selectedStartingDate.toIso8601String().trim())}');
    body["expire_date"] =
        Helper.stringForDatetime3(gymStore.selectedStartingDate
                .add(
                  Duration(
                    days: int.tryParse(gymStore.selectedGymPlan.duration),
                  ),
                )
                .toIso8601String())
            .trim();

    body["plan_id"] = gymStore.selectedGymPlan.plan_uid;
    body["isWhatsapp"] = !_isChecked;

    //Partial Payment Details :D
    body["is_partial"] = isPartialPayment() ? 1 : 0;
    if (isPartialPayment())
      body['payment'] = [
        {
          "amount": gymStore.selectedGymDetail.data.first_payment_amount,
          "date": gymStore.selectedGymDetail.data.first_payment,
          "status": "completed"
        },
        {
          "amount": gymStore.selectedGymDetail.data.second_payment_amount,
          "date": gymStore.selectedGymDetail.data.second_payment,
          "status": "pending"
        },
        {
          "amount": gymStore.selectedGymDetail.data.third_payment_amount,
          "date": gymStore.selectedGymDetail.data.third_payment,
          "status": "pending"
        },
      ];

    if (gymStore.chosenOffer != null) {
      body['coupon'] = gymStore.chosenOffer.uid;
    }

    print('Starting Razor Pay Library ---- ');

    if (totalAmount != 0) {
      if (isCash) {
        //100% discount applied :D
        body['trx_id'] = 'cash';
        body['trx_status'] = 'done';
        body['order_status'] = 'done';
        bool isDone = await gymStore.addSubscription(
          body: body,
          context: context,
          showLoader: true,
        );
        if (isDone) {
          gymStore.init(context: context);
          //nullData();
          NavigationService.navigateTo(Routes.purchaseDone);
        } else {
          FlashHelper.errorBar(context, message: 'Please Try again!');
        }
      } else {
        await gymStore
            .generateRazorPayId(
                amount: (isPartialPayment()
                        ? (totalAmount / 2) * 100
                        : totalAmount * 100)
                    .toString(),
                context: context,
                subBody: body)
            .then((value) {
          if (value != null || value.isNotEmpty) {
            print('order is not null --- $value');
            NavigationService.pushName(Routes.paymentProcess,
                argument: PaymentProcessArgument(
                    orderId: value,
                    data: body,
                    price: (isPartialPayment()
                            ? (totalAmount / 2) * 100
                            : totalAmount * 100)
                        .toString()));
          } else {
            FlashHelper.errorBar(context,
                message: 'Something went wrong with your order!');
          }
        });
      }
    } else {
      //100% discount applied :D
      body['trx_id'] = 'discount_applied';
      body['trx_status'] = 'done';
      body['order_status'] = 'done';
      bool isDone = await gymStore.addSubscription(
        body: body,
        context: context,
        showLoader: true,
      );
      if (isDone) {
        gymStore.init(context: context);
        //nullData();
        NavigationService.navigateTo(Routes.purchaseDone);
      } else {
        FlashHelper.errorBar(context, message: 'Please Try again!');
      }
    }
  }

  void nullData() {
    //gymStore.selectedGymDetail = null;
    gymStore.selectedGymPlan = null;
  }

  Future<String> _selectEmiDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: gymStore.selectedStartingDate.add(
          Duration(
            days: (int.tryParse(
                      gymStore.selectedGymPlan.duration,
                    ) /
                    2)
                .round(),
          ),
        ),
        builder: (BuildContext context, Widget child) {
          return getDialogTheme(child);
        });

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      return formattedDate;
    } else
      return null;
  }

  DateTime convertDate(String date) {
    DateTime parseDate = new DateFormat("dd-MM-yyyy'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    // var outputFormat = DateFormat('dd-MM-yyyy');
    // var outputDate = outputFormat.format(inputDate);
    // print(outputDate);
    return inputDate;
  }

  Future<String> _selectThirdEmiDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:
            convertDate(gymStore.selectedGymDetail.data.second_payment),
        firstDate: convertDate(gymStore.selectedGymDetail.data.second_payment),
        lastDate: gymStore.selectedStartingDate.add(
          Duration(
            days: (int.tryParse(
                      gymStore.selectedGymPlan.duration,
                    ) /
                    2)
                .round(),
          ),
        ),
        builder: (BuildContext context, Widget child) {
          return getDialogTheme(child);
        });

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      return formattedDate;
    } else
      return null;
  }

  Future<bool> showBottomDialog() {
    final _formKey = GlobalKey<FormState>();
    final _otpController = TextEditingController();
    bool otpResent = false;
    bool wrongOtp = false;
    String otpMessage = 'Wrong OTP';
    bool loading = false;
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => WillPopScope(
          onWillPop: () async => true,
          child: StatefulBuilder(
            builder: (BuildContext ctx, StateSetter setModelState) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      right: 12,
                      left: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        title: Text(
                          'Verification Required\n',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'We have sent an OTP to ${gymStore.selectedGymDetail.data.gymName} , ${gymStore.selectedGymDetail.data.name} to authenticate this transaction\, Please ask the OTP from ${gymStore.selectedGymDetail.data.name} to proceed',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          inputFormatters: [Global.amountValidator],
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter OTP",
                            labelText: "Enter OTP",
                            hintStyle: TextStyle(color: Colors.black),
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                          maxLength: 7,
                          autofocus: true,
                          controller: _otpController,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null)
                              return "Please enter OTP";
                            else if (value.length < 6) {
                              return 'Please enter 6 character otp';
                            } else
                              return null;
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      otpResent ? SizedBox(): Container(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap:() {
                                  gymStore
                                      .sendOtpToGymOwner(
                                          gymId: gymStore
                                              .selectedGymDetail.data.userId)
                                      .then((value) {
                                    FlashHelper.informationBar(context,
                                        message: 'OTP Re-sent');
                                    otpResent = true;
                                    setModelState(() {});
                                  });
                                },
                          child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Text('Resend OTP',
                                  style: TextStyle(color: Colors.black))),
                        ),
                      ),
                      if (wrongOtp) SizedBox(height: 8),
                      if (wrongOtp)
                        Align(
                            alignment: Alignment.center,
                            child: Text('$otpMessage',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppConstants.boxBorderColor))),
                      SizedBox(height: 12),
                      InkWell(
                        onTap: !loading
                            ? () {
                                final formState = _formKey.currentState;
                                if (formState.validate()) {
                                  formState.save();
                                  // then do something
                                  setModelState(() {
                                    loading = true;
                                  });
                                  gymStore
                                      .verifyOtpToGymOwner(
                                          gymId: gymStore
                                              .selectedGymDetail.data.userId,
                                          otp: _otpController.text.trim())
                                      .then((value) {
                                    if (value) {
                                      Navigator.pop(context);
                                      FlashHelper.successBar(context,
                                          message: 'OTP verified');
                                      processToBuy(isCash: _radioValue == 2);
                                    } else {
                                      setModelState(() {
                                        wrongOtp = true;
                                        _otpController.text = null;
                                      });
                                    }
                                  });
                                }
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: AppConstants.bgColor),
                          child: loading
                              ? Loading()
                              : Text('Verify OTP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  bool isEnableThirdEmi() {
    return gymStore.selectedGymDetail.data.second_payment != null &&
        gymStore.selectedGymDetail.data.second_payment_amount != null;
  }

  String getHalfPaymentAmount(String amount) {
    print('First Payment amount---- $amount');
    double finalAmount = num.parse(amount) / 2;
    return finalAmount.toString();
  }

  String getTodayDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate; // 2016-01-25
  }

  String getEmiLabel(int emiType) {
    switch (emiType) {
      case 1:
        String amount = gymStore.selectedGymDetail.data.second_payment_amount;
        String paymentDate =
            'Second Payment at ${gymStore.selectedGymDetail.data.second_payment}';
        return paymentDate + " " + '\u{20B9}$amount';
        break;
      case 2:
        String amount = gymStore.selectedGymDetail.data.third_payment_amount;
        String paymentDate =
            'Third Payment at ${gymStore.selectedGymDetail.data.third_payment}';
        return paymentDate + " " + '\u{20B9}$amount';
        break;
      default:
        String amount = gymStore.selectedGymDetail.data.first_payment_amount;
        String paymentDate = 'First Payment today ';
        return paymentDate + " " + '\u{20B9}$amount';
        break;
    }
  }

  bool isFullPayment() {
    return _radioValue != 1;
  }

  bool isPartialPayment() {
    return _radioValue == 1;
  }

  Widget amountLabel({String label, String value}) {
    return Row(
      children: [
        Text(label ?? '',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        Spacer(),
        Text('\u{20B9}${value ?? ''}')
      ],
    );
  }

  Widget detailsSection({String heading, String value}) {
    return ListTile(
        dense: true,
        title: Text(
          heading ?? '',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal),
        ),
        trailing: Text(value ?? '',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal)));
  }

  @override
  void onGetGymDetailsSuccess(GymDetailsModel model) {
    // TODO: implement onGetGymDetailsSuccess
  }

  @override
  void onGetGymError(Object errorTxt) {
    setState(() {
      // _searchResultModel = model;
      isLoaded = true;
    });
    if (errorTxt is String) {
      CommonFunction.showToast(errorTxt);
    } else if (errorTxt is GymModel) {
      CommonFunction.showToast(errorTxt.message);
    }
    CommonFunction.showToast(errorTxt);
  }

  @override
  void onGetGymSuccess(GymModel model) {
    // TODO: implement onGetGymSuccess
  }

  @override
  void onGymPlansSuccess(GymPlanModel model) {
    // TODO: implement onGymPlansSuccess
  }

  @override
  void onGymSlotSuccess(GymSlotModel model) {
    // TODO: implement onGymSlotSuccess
  }

  @override
  void onsearchGymSuccess(GymSearchModel model) {
    // TODO: implement onsearchGymSuccess
  }

  @override
  void onAddSubscriptionSuccess(CommonModel model) {
    if (model != null) {
      setState(() {
        isLoaded = true;
      });

      context.read<GymStore>().getActiveSubscriptions(context: context);
      gymStore.setRenew(false);
      NavigationService.navigateTo(Routes.purchaseDone);
    } else {
      // CommonFunction.showToast(model);
    }
  }

  Future<void> addSubscription(String price, Map<String, dynamic> body) async {
    // CommonFunction.showProgressDialog(context);
    print("search Gym 0");
    setState(() {
      isLoaded = false;
    });

    await _presenter.addSubscription(
      price,
      body,
      gymStore.selectedGymPlan.plan_uid,
    );
  }

  Theme getDialogTheme(Widget child) {
    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: AppConstants.primaryColor, //yellow
          onPrimary: Colors.white,
          surface: Colors.grey.shade200, //white
          onSurface: AppConstants.primaryColor, //black
        ),
        dialogBackgroundColor: Colors.white, //white
      ),
      child: child,
    );
  }

  void pay(){
    if (!isFullPayment()) {
      if (validateEmiPayment() == null) {
        gymStore
            .sendOtpToGymOwner(
            gymId: gymStore.selectedGymDetail.data.userId)
            .then((value) {
          if (value) {
            showBottomDialog();
          } else {
            FlashHelper.errorBar(context,
                message: 'Something went wrong while sending otp');
          }
        });
      } else {
        FlashHelper.errorBar(context, message: validateEmiPayment());
      }
    } else {
      if (_radioValue == 2) {
        gymStore
            .sendOtpToGymOwner(
            gymId: gymStore.selectedGymDetail.data.userId)
            .then((value) {
          if (value) {
            showBottomDialog();
          } else {
            FlashHelper.errorBar(context,
                message: 'Something went wrong while sending otp');
          }
        });
      } else {
        processToBuy();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
    final PlanPageArgument args =
        ModalRoute.of(context).settings.arguments as PlanPageArgument;
    if (args.planColor != null)
      _planColor = args.planColor;
    else
      _planColor = PlanColor.getColorList()[0];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.bgColor,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Booking summary",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
        constraints: BoxConstraints(minHeight: 54, maxHeight: 60),
        child: InkWell(
          onTap: () async {
           if(PreambleHelper.hasPreamble()){
             pay();
           }else{
             PreambleHelper.showPreambleWarningDialog(context: context,fromPayment: true).then((value){
               if(value){
                 gymStore.preambleFromPayment = true;
                 context.read<GymStore>().preambleFromLogin = false;
                 NavigationService.pushName(Routes.userDetail).then((value){
                   if(value){
                     gymStore.preambleFromPayment = false;
                     pay();
                   }else{
                     FlashHelper.errorBar(context,
                         message: 'Something went wrong with user details');
                   }
                 });
               }else{
                 FlashHelper.errorBar(context,
                     message: 'Please Fill user details to processed');
               }
             });
           }
          },
          child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff490000),
                      Color(0xffBA1406),
                    ],
                  )),
              alignment: Alignment.center,
              child: Text('Proceed')),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0xff292929)),
                child: Column(
                  children: [
                    detailsSection(
                        heading: 'Booked at',
                        value: gymStore.selectedGymDetail.data.gymName ?? ''),
                    detailsSection(heading: 'Workout', value: 'Gym Membership'),
                    detailsSection(
                        heading: 'Plan',
                        value: gymStore.selectedGymPlan.plan_name ?? ''),
                    detailsSection(
                        heading: 'Subscription Start date',
                        value: Helper.stringForDatetime2(
                            gymStore.selectedStartingDate.toIso8601String())),
                    detailsSection(
                        heading: 'Subscription End date',
                        value: Helper.stringForDatetime2(
                            gymStore.selectedStartingDate
                                .add(
                                  Duration(
                                    days: int.tryParse(
                                      gymStore.selectedGymPlan.duration,
                                    ),
                                  ),
                                )
                                .toIso8601String())),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
              ),
              if (totalAmount > 0)
                Container(
                    padding:
                        EdgeInsets.only(right: 19, left: 18, bottom: 8, top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xff292929),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: Colors.white,
                            controller: couponCodeController,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            onFieldSubmitted: (val) {
                              applyCoupon();
                            },
                            onChanged: (String val) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter Coupon Code',
                                hintStyle: TextStyle(
                                    color: Color(0xffC4C4C4),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(0)),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        // we need add button at last friends row
                        suffix(couponCodeController.text)
                      ],
                    )),
              SizedBox(
                height: 45,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Mode",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: 0,
                            contentPadding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 0, top: 0),
                            groupValue: _radioValue,
                            onChanged: (newValue) {
                              setState(() {
                                _radioValue = newValue;
                                gymStore.selectedGymDetail.data.first_payment =
                                    null;
                                gymStore.selectedGymDetail.data
                                    .first_payment_amount = null;

                                gymStore.selectedGymDetail.data.second_payment =
                                    null;
                                gymStore.selectedGymDetail.data
                                    .second_payment_amount = null;

                                gymStore.selectedGymDetail.data.third_payment =
                                    null;
                                gymStore.selectedGymDetail.data
                                    .third_payment_amount = null;
                              });
                            },
                            title: Text('Full Payment'),
                          ),
                          flex: 1,
                        ),
                        if (gymStore.selectedGymDetail.data.is_partial == 1 &&
                            totalAmount != 0)
                          Expanded(
                            child: RadioListTile(
                              value: 1,
                              contentPadding: EdgeInsets.only(
                                  left: 0, right: 0, bottom: 0, top: 0),
                              groupValue: _radioValue,
                              onChanged: (newValue) {
                                setState(() {
                                  _radioValue = newValue;
                                  gymStore.selectedGymDetail.data
                                      .first_payment = getTodayDate();
                                  gymStore.selectedGymDetail.data
                                          .first_payment_amount =
                                      getHalfPaymentAmount(
                                          totalAmount.toString());
                                });
                              },
                              title: Text('Partial'),
                            ),
                            flex: 1,
                          ),
                        if (gymStore.selectedGymDetail.data.is_cash == 1 &&
                            totalAmount != 0)
                          Expanded(
                            child: RadioListTile(
                              value: 2,
                              contentPadding: EdgeInsets.only(
                                  left: 0, right: 0, bottom: 0, top: 0),
                              groupValue: _radioValue,
                              onChanged: (newValue) {
                                setState(() {
                                  _radioValue = newValue;
                                  // gymStore.selectedGymDetail.data
                                  //     .first_payment = getTodayDate();
                                  // gymStore.selectedGymDetail.data
                                  //     .first_payment_amount =
                                  //     getHalfPaymentAmount(
                                  //         totalAmount.toString());
                                });
                              },
                              title: Text('Cash'),
                            ),
                            flex: 1,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  if (!isFullPayment())
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 35),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppConstants.bgColor),
                      child: Column(
                        children: [
                          Text(
                              'Pay \u{20B9}${getHalfPaymentAmount(totalAmount.toString())} now and choose EMI date for your next payment',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color(0xffAF4949).withOpacity(0.5)),
                            child: ListTile(
                              enabled: false,
                              title: Text('Select First EMI',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              subtitle: gymStore.selectedGymDetail.data
                                              .first_payment !=
                                          null &&
                                      gymStore.selectedGymDetail.data
                                              .first_payment_amount !=
                                          null
                                  ? Text(getEmiLabel(0))
                                  : null,
                              trailing: Icon(Icons.date_range),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color(0xffAF4949)),
                            child: ListTile(
                              onTap: () {
                                _selectEmiDate().then((value) {
                                  if (value != null) {
                                    gymStore.selectedGymDetail.data
                                        .second_payment = value;
                                    gymStore.selectedGymDetail.data
                                            .second_payment_amount =
                                        getHalfPaymentAmount(gymStore
                                            .selectedGymDetail
                                            .data
                                            .first_payment_amount);
                                    setState(() {});
                                  }
                                });
                              },
                              title: Text('Select Second EMI date',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              subtitle: gymStore.selectedGymDetail.data
                                              .second_payment !=
                                          null &&
                                      gymStore.selectedGymDetail.data
                                              .second_payment_amount !=
                                          null
                                  ? Text(getEmiLabel(1))
                                  : null,
                              trailing: Icon(Icons.date_range),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: isEnableThirdEmi()
                                    ? Color(0xffAF4949)
                                    : Color(0xffAF4949).withOpacity(0.5)),
                            child: ListTile(
                              enabled: isEnableThirdEmi(),
                              onTap: () {
                                _selectThirdEmiDate().then((value) {
                                  if (value != null) {
                                    gymStore.selectedGymDetail.data
                                        .third_payment = value;
                                    gymStore.selectedGymDetail.data
                                            .third_payment_amount =
                                        getHalfPaymentAmount(gymStore
                                            .selectedGymDetail
                                            .data
                                            .first_payment_amount);
                                    setState(() {});
                                  }
                                });
                              },
                              title: Text('Select Third EMI date',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              subtitle: gymStore.selectedGymDetail.data
                                              .third_payment !=
                                          null &&
                                      gymStore.selectedGymDetail.data
                                              .third_payment_amount !=
                                          null
                                  ? Text(getEmiLabel(2))
                                  : null,
                              trailing: Icon(Icons.date_range),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (!isFullPayment())
                    SizedBox(
                      height: 45,
                    ),
                ],
              ),
              Text(
                "Payment Details",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        colors: [_planColor.leftColor, _planColor.rightColor])),
                child: Column(
                  children: [
                    amountLabel(
                        label: 'Plan Price',
                        value: gymStore.selectedGymPlan.plan_price ?? ''),
                    SizedBox(height: 6),
                    if (gymStore.chosenOffer != null)
                      amountLabel(
                          label: "Discount",
                          value: discountAmount != null
                              ? discountAmount.toString()
                              : ''),
                    if (gymStore.chosenOffer != null) SizedBox(height: 6),
                    InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CGST 9%'),
                                  Text('SGST 9%'),
                                  Text(
                                      'Tax acknowledgement will be emailed to you after subscription.'),
                                ],
                              ),
                            ),
                          );
                        },
                        child: amountLabel(
                            label: 'GST(0%)',
                            value: tax != null ? tax.toString() : '')),
                    Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6),
                    amountLabel(
                        label: 'Total Amount',
                        value:
                            totalAmount != null ? totalAmount.toString() : ''),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
