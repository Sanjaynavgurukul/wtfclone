import 'package:flutter/cupertino.dart';
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
import 'package:wtf/screen/subscriptions/buy_subscription_screen.dart';

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
  TextEditingController couponCodeController;

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
      if (context.read<GymStore>().chosenOffer.type == 'flat') {
        int couponValue =
            int.tryParse(context.read<GymStore>().chosenOffer.value);
        discountAmount = couponValue >
                int.tryParse(context.read<GymStore>().selectedEventData.price)
            ? int.tryParse(context.read<GymStore>().selectedEventData.price)
            : couponValue;
      } else {
        print('price: ${context.read<GymStore>().selectedGymPlan.plan_price}');
        print('offer val: ${context.read<GymStore>().chosenOffer.value}');
        discountAmount =
            (int.tryParse(context.read<GymStore>().selectedGymPlan.plan_price) *
                    int.tryParse(context.read<GymStore>().chosenOffer.value) /
                    100)
                .truncate();
      }
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
          .getCoupon(couponCodeController.text)
          .then((value) {
        if (value != null) {
          setState(() {
            gymStore.setOffer(context: context, data: value);
            print('set');
            calculateFinalPrice();
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

  void removeCoupon() {
    setState(() {
      gymStore.chosenOffer = null;
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
                    fontSize: 16, fontWeight: FontWeight.w600,color: AppConstants.boxBorderColor)),
          )
        : text.isNotEmpty
            ? InkWell(
                onTap: () {
                  applyCoupon();
                },
                child: Text('Apply',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600))
              )
            : SizedBox(
                height: 0,
              );
  }

  @override
  Widget build(BuildContext context) {
    gymStore = context.watch<GymStore>();
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
        padding: EdgeInsets.only(left: 16,right: 16,top: 6,bottom: 6),
        constraints: BoxConstraints(
            minHeight: 54,maxHeight: 60
        ),
        child: InkWell(
          onTap:()async{
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
              child:Text('Proceed')
          ),
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
                    detailsSection(heading: 'Booked at', value: gymStore.selectedGymDetail.data.gymName??''),
                    detailsSection(heading: 'Workout', value: 'Gym Membership'),
                    detailsSection(heading: 'Plan', value: gymStore.selectedGymPlan.plan_name ?? ''),
                    detailsSection(
                        heading: 'Subscription Start date',
                        value: Helper.stringForDatetime2(
                            gymStore.selectedStartingDate.toIso8601String())),
                    detailsSection(
                        heading: 'Subscription End date', value: Helper.stringForDatetime2(gymStore.selectedStartingDate.add(
                      Duration(
                        days: int.tryParse(
                          gymStore.selectedGymPlan.duration,
                        ),
                      ),
                    ).toIso8601String())),
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
             if(gymStore.selectedGymPlan.is_recomended == 1) Column(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: 'null',
                                  onChanged: (index) {}),
                              Text('Full Payment',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w400))
                            ],
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: 'null',
                                  onChanged: (index) {}),
                              Text('Partial',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w400))
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppConstants.bgColor),
                    child: Column(
                      children: [
                        Text(
                            'Pay 2999 now and choose EMI date for your next payment',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 12, bottom: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Color(0xffAF4949)),
                          child: Row(
                            children: [
                              Text('Select EMI date',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400)),
                              Spacer(),
                              Icon(Icons.date_range)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff438373),
                        Color(0xff3E74B4),
                      ],
                    )),
                child: Column(
                  children: [
                    amountLabel(label: 'Plan Price',value: '2999'),
                    SizedBox(height:6),
                    amountLabel(label: 'GST(0%)',value: '0'),
                    Divider(thickness: 1,color: Colors.white,),
                    SizedBox(height:6),
                    amountLabel(label: 'Total Amount',value: '2999'),
                  ],
                ),
              ),SizedBox(
                height: 45,
              ),
            ],
          ),
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

  Widget oldUi() {
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
      // bottomNavigationBar: Container(
      //   child: SlideButton(
      //     text: "Proceed to buy",
      //     onTap: (){
      //       print('Button pressed in slide----');
      //       // print('method called------some');
      //       // processToBuy();
      //     },
      //   ),
      // ),
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
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booked at:",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Flexible(
                          child: Text(
                            gymStore.selectedGymDetail.data.gymName,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Divider(
                      thickness: 0.7,
                      color: Colors.white38,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Workout:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Gym Membership",
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
                      color: Colors.white38,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          width: 15,
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
                      color: Colors.white38,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subscription Start Date:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          Helper.stringForDatetime2(
                              gymStore.selectedStartingDate.toIso8601String()),
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
                      color: Colors.white38,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subscription End Date:",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
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
                      color: Colors.white38,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                UIHelper.verticalSpace(6.0),
                if (totalAmount > 0)
                  Container(
                      padding: EdgeInsets.only(left: 6, right: 6),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppConstants.primaryColor, width: 2)),
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
                                hintText: "ENTER YOUR COUPON CODE",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                //gymStore.chosenOffer
                              ),
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
                  height: 12,
                ),
                if (gymStore.selectedGymPlan.plan_price != '0')
                  OfferSection(
                    onApplied: () {
                      setState(() {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          calculateFinalPrice();
                        });
                      });
                    },
                  ),
                if (gymStore.selectedGymPlan.plan_price != '0')
                  Consumer<GymStore>(
                    builder: (context, store, child) =>
                        store.chosenOffer != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 18.0,
                                    ),
                                    UIHelper.horizontalSpace(8.0),
                                    Text(
                                      'Coupon Code Applied',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(10.0),
                              ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Payment Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Plan Price",
                      style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '₹ ${gymStore.selectedGymPlan.plan_price}',
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
                Divider(
                  // height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                if (gymStore.chosenOffer != null)
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
                        // FlashHelper.informationBar(context,
                        //     message:
                        //         );
                      },
                      child: Row(
                        children: [
                          Text(
                            "GST (${gymStore.selectedGymPlan.tax_percentage} %)",
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
                      // (int.parse(widget.selectedGymPlanModel.price) +
                      //         (int.parse(widget
                      //                 .selectedGymPlanModel.taxPercentage
                      //                 .split("%")
                      //                 .first
                      //                 .toString()) *
                      //             100))
                      // .toString(),
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
                Divider(
                  // height: 0.0,
                  color: Colors.white38,
                  thickness: 0.4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total amount",
                      style: TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '₹ ${totalAmount ?? ''}',
                      // (int.parse(widget.selectedGymPlanModel.price) +
                      //         (int.parse(widget
                      //                 .selectedGymPlanModel.taxPercentage
                      //                 .split("%")
                      //                 .first
                      //                 .toString()) *
                      //             100))
                      // .toString(),
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
                        'Don\'t send me updates, invoice via Whatsapp',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
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

  void processToBuy() async {
    print('method called------');
    Map<String, dynamic> body = {};
    // setState(() {
    //   subscriptionBody = body;
    // });

    // if (_isChecked) {
    //   body['isWhatsapp'] = true;
    // }

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

    if (gymStore.chosenOffer != null) {
      body['coupon'] = gymStore.chosenOffer.uid;
    }

    print('Starting Razor Pay Library ---- ');

    if (totalAmount != 0) {
      await gymStore.processPayment(
        context: context,
        body: body,
        price: (totalAmount * 100).toString(),
      );
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
        NavigationService.navigateTo(Routes.purchaseDone);
      } else {
        FlashHelper.errorBar(context, message: 'Please Try again!');
      }
    }
  }
}
