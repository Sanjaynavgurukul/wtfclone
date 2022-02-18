import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/explore_controller_presenter.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/common_function.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/common_model.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/model/gym_plan_model.dart';
import 'package:wtf/model/gym_search_model.dart';
import 'package:wtf/model/gym_slot_model.dart';
import 'package:wtf/screen/buy_subscription_screen.dart';
import 'package:wtf/widget/slide_button.dart';

class BookingSummaryEvents extends StatefulWidget {
  @override
  _BookingSummaryEventsState createState() => _BookingSummaryEventsState();
}

class _BookingSummaryEventsState extends State<BookingSummaryEvents>
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
  TextEditingController couponCodeController = TextEditingController();
  // Map subscriptionBody;
  bool _isProgress;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _presenter = new ExplorePresenter(this);
    // getGyms();
    calculateFinalPrice();
  }

  void calculateFinalPrice() {
    tax = 0;
    totalAmount = 0;
    discountAmount = 0;
    if (context.read<GymStore>().chosenOffer != null) {
      if (context.read<GymStore>().chosenOffer.type == 'flat') {
        int couponValue =
            int.tryParse(context.read<GymStore>().chosenOffer.value);
        discountAmount = couponValue >
                int.tryParse(context.read<GymStore>().selectedEventData.price)
            ? int.tryParse(context.read<GymStore>().selectedEventData.price)
            : couponValue;
      } else {
        discountAmount =
            (int.tryParse(context.read<GymStore>().selectedEventData.price) *
                    int.tryParse(context.read<GymStore>().chosenOffer.value) /
                    100)
                .truncate();
      }
      couponCodeController.text = context.read<GymStore>().chosenOffer.code;
    } else {
      couponCodeController.clear();
    }
    totalAmount =
        int.tryParse(context.read<GymStore>().selectedEventData.price) -
            discountAmount;
    tax = (totalAmount * 18 / 100).truncate();
    totalAmount = tax +
        int.tryParse(context.read<GymStore>().selectedEventData.price) -
        discountAmount;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
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
        height: 120.0,
        child: Column(
          children: [
            SubscriptionConditions(),
            SlideButton(
              "Pay Now",
              () async {
                var body = {
                  "gym_id": gymStore.selectedEventData.gymId,
                  "user_id": locator<AppPrefs>().memberId.getValue(),
                  "price": totalAmount,
                  "type": 'event',
                  "tax_percentage": "18",
                  "tax_amount": tax,
                  "slot_id": '',
                  "addon": '',
                  'event_id': gymStore.selectedEventData.uid,
                  'remark': gymStore.selectedEventData.uid,
                  "start_date":
                      Helper.stringForDatetime3(gymStore.selectedEventData.date)
                          .trim(),
                  "expire_date":
                      Helper.stringForDatetime3(gymStore.selectedEventData.date)
                          .trim(),
                  'isWhatsapp': !_isChecked,
                };
                // setState(() {
                //   subscriptionBody = body;
                // });
                // if (_isChecked) {
                //   body['isWhatsapp'] = true;
                // }
                if (gymStore.chosenOffer != null) {
                  body['coupon'] = gymStore.chosenOffer.uid;
                }

                if (totalAmount != 0) {
                  await gymStore.processPayment(
                    context: context,
                    body: body,
                    price: (totalAmount * 100).toString(),
                  );
                } else {
                  body['trx_id'] = 'discount_applied';
                  body['trx_status'] = 'done';
                  body['order_status'] = 'done';
                  bool isDone = await gymStore.addSubscription(
                    body: body,
                    context: context,
                    showLoader: true,
                  );
                  if (isDone) {
                    await gymStore.addEventParticipation(context: context);
                    gymStore.init(context: context);
                    NavigationService.navigateTo(Routes.eventPurchaseDone);
                  } else {
                    FlashHelper.errorBar(context, message: 'Please Try again!');
                  }
                }
                // await addSubscription(
                //   gymStore.selectedEventData.price,
                //   body,
                // );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event Name:",
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          " ${gymStore.selectedEventData.name}",
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
                      color: Colors.white38,
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event Duration:",
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          ' ${gymStore.selectedEventData.timeFrom} to ${gymStore.selectedEventData.timeTo}',
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
                      color: Colors.white38,
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event Date:",
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                      color: Colors.white38,
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
                UIHelper.verticalSpace(20.0),
                if (gymStore.chosenOffer != null || totalAmount > 0)
                  OfferSection(
                    onApplied: () {
                      calculateFinalPrice();
                    },
                  ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Payment Details",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Event Price.",
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '₹ ${gymStore.selectedEventData.price}' ?? '',
                      // "RS. 499",
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                if (gymStore.chosenOffer != null)
                  SizedBox(
                    height: 6,
                  ),
                Divider(
                  // height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                SizedBox(
                  height: 6,
                ),
                if (gymStore.chosenOffer != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        '- ₹ ${discountAmount ?? ''}',
                        // "RS. 499",
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 6,
                ),
                if (gymStore.chosenOffer != null)
                  Divider(
                    // height: 0.0,
                    color: Colors.white38,
                    thickness: 0.4,
                  ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      child: Row(
                        children: [
                          Text(
                            "GST (18 %)",
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          UIHelper.horizontalSpace(6.0),
                          Icon(
                            Icons.info_outline,
                            size: 16.0,
                          )
                        ],
                      ),
                    ),
                    Text(
                      '₹ $tax',
                      style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Divider(
                  // height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total amount.",
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '₹ $totalAmount' ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Divider(
                  // height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    // Checkbox(value: true, onChanged: (val) {}),
                    Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.white,
                            accentColor: Colors.white,
                            backgroundColor: Colors.transparent),
                        child: Checkbox(
                            value: _isChecked,
                            tristate: false,
                            checkColor: Colors.black,
                            // side: BorderSide(color: Colors.white),
                            onChanged: (bool value) {
                              setState(() {
                                _isChecked = value;
                              });
                            })),
                    Expanded(
                      child: Text(
                        "Don\'t send me updates, invoice via Whatsapp",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
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
      print("subscription 0");

      // print("subscription 1 $res");
      // _scaffoldKey.currentState
      //     .showSnackBar(new SnackBar(content: new Text(model.message)));
      setState(() {
        // _searchResultModel = model;
        isLoaded = true;
      });

      // CommonFunction.showToast(model.message);
      // NavigationService.navigateTo(Routes.eventPurchaseDone);
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
      '',
    );
  }
}

class SubscriptionConditions extends StatelessWidget {
  const SubscriptionConditions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Note: You\'re agreeing to ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.0,
        ),
        children: [
          TextSpan(
            text: 'Terms & Conditions',
            style: TextStyle(
              color: Colors.red,
              decoration: TextDecoration.underline,
              fontSize: 12.0,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  enableDrag: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  builder: (context) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: AppConstants.eventCondition,
                        ),
                      ),
                    ),
                  ),
                );
              },
          ),
          TextSpan(
            text: ' by subscribing to this Package',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
