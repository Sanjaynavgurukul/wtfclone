import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:wtf/controller/bases.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/api_helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/social_auth_services.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/model/ActiveSubscriptions.dart';
import 'package:wtf/model/AllSessions.dart';
import 'package:wtf/model/AttendanceDetails.dart';
import 'package:wtf/model/EventSubmissions.dart';
import 'package:wtf/model/GymOffers.dart';
import 'package:wtf/model/MemberSubscriptions.dart';
import 'package:wtf/model/Stats.dart';
import 'package:wtf/model/UpcomingEvents.dart';
import 'package:wtf/model/VerifyPayment.dart';
import 'package:wtf/model/WhyChooseWtf.dart';
import 'package:wtf/model/WorkoutComplete.dart';
import 'package:wtf/model/WorkoutDetailModel.dart';
import 'package:wtf/model/add_on_slot_details.dart';
import 'package:wtf/model/all_diets.dart';
import 'package:wtf/model/all_events.dart';
import 'package:wtf/model/all_notifications.dart';
import 'package:wtf/model/banner_model.dart';
import 'package:wtf/model/check_event_participation.dart';
import 'package:wtf/model/coin_balance.dart';
import 'package:wtf/model/coin_history.dart';
import 'package:wtf/model/common_model.dart';
import 'package:wtf/model/current_trainer.dart';
import 'package:wtf/model/diet_consumed.dart';
import 'package:wtf/model/diet_item.dart';
import 'package:wtf/model/diet_model.dart';
import 'package:wtf/model/diet_pref.dart';
import 'package:wtf/model/geo_address.dart';
import 'package:wtf/model/gym_add_on.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/model/gym_plan_model.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/model/new_trainers_model.dart';
import 'package:wtf/model/offers.dart';
import 'package:wtf/model/redeem_history.dart';
import 'package:wtf/model/shopping_categories.dart';
import 'package:wtf/screen/home/jitsi_meeting.dart';
import 'package:wtf/screen/stopwatch.dart';
import 'package:wtf/widget/OtpVerifySheet.dart';
import 'package:wtf/widget/Shimmer/values/type.dart';
import 'package:wtf/widget/processing_dialog.dart';

import '../main.dart';

class GymStore extends ChangeNotifier {
  int currentIndex = 0;

  bool loading = false;

  bool get isLoading => loading;

  GymPlanData selectedGymPlan;

  GymDetailsModel selectedGymDetail;

  WhyChooseWtf whyChooseWtf;

  GymAddOn allLiveClasses;

  GymAddOn allAddonClasses;

  GymAddOn selectedGymAddOns;

  AddOnData selectedAddOnSlot;

  bool isSelectedGymSubscribed = false;

  DateTime selectedStartingDate;

  SlotData selectedSlotData;
  List<CategoryDietModel> diet;
  List<DayWise> dayWiseDiet;

  AddOnSlotDetails selectedSlotDetails;

  AllEvents allEventsResult;

  List<EventsData> allChallenges;

  List<EventsData> allEvents;

  EventsData selectedEventData;

  GymTypes selectedGymTypes;

  MyWorkoutSchedule myWorkoutSchedule;

  MySchedule mySchedule;

  MySchedule addonMySchedules;

  CurrentTrainer currentTrainer;

  GymModel allGyms;

  WorkoutScheduleData selectedWorkoutSchedule;

  MyScheduleAddonData selectedSchedule;

  Exercise selectedExercise;

  WorkoutDetailModel workoutDetails;

  String workoutTime;

  Position currentPosition;

  Address currentAddress;

  GymOffers selectedGymOffer;

  OfferData chosenOffer;

  String attendanceType = "";

  String selectedNotificationType = 'new';

  ActiveSubscriptions activeSubscriptions;

  MemberSubscriptions memberSubscriptions;

  List<SubscriptionData> regularSubscriptions;
  List<SubscriptionData> addOnSubscriptions;
  List<SubscriptionData> addOnLiveSubscriptions;
  List<SubscriptionData> eventSubscriptions;

  NewTrainersModel newTrainers;

  NewTrainersModel selectedGymTrainers;

  TrainerData shiftTrainers;

  AllSessions selectedAddonSessions;

  bool isRenew = false;

  MyWorkoutSchedule todaySchedule;

  SessionData selectedSession;

  WorkoutComplete completedWorkout;

  String timeElapsed = '';

  Result currentAddressResult;

  Razorpay _razorpay;

  TrainerData selectedTrainer;

  Map<String, dynamic> subscriptionBody = {};

  StopwatchDependencies workoutGlobalTimer;

  AttendanceDetails attendanceDetails;

  UpcomingEvents upcomingEvents;

  bool isEventParticipated = false;

  bool isFreeSession = false;

  BuildContext paymentContext;

  AllNotifications allNotifications;

  Stats memberStats;

  AllNotifications newNotifications;

  CheckEventParticipation eventParticipation;

  AllDiets allDiets;

  CoinBalance coinBalance;
  ShoppingCategories shoppingCategories;
  Offers offers;
  String offerCategory;

  CoinHistory coinHistory;
  RedeemHistory redeemHistory;

  DietPref dprefType1;
  DietPref dprefType2;

  DietItem dietItem;
  DietConsumed dietConsumed;

  String discoverType = '';
  LocationResult selectedNewLocation;

  double sessionRating = 0.0;

  double trainerRating = 0.0;

  String workoutMappingId = '';

  bool showTrailOffer = true;

  EventSubmissions selectedEventSubmissions;

  GymPlanModel selectedGymPlans;

  String selectedGymId;

  List<Submission> selectedSubmissions = [];

  Future<void> setEventSubmission({List<Submission> data}) async {
    selectedSubmissions = data;
    notifyListeners();
  }

  Future<void> setSessionRating({double rating}) async {
    sessionRating = rating;
    notifyListeners();
  }

  Future<void> setTrainerRating({double rating}) async {
    trainerRating = rating;
    notifyListeners();
  }

  Future<void> setOffer({BuildContext context, OfferData data}) async {
    if (data != null) {
      var isValid = await RestDatasource().checkOffer(offerId: data.uid);
      if (isValid != null && isValid['status']) {
        log('selected offer -->> ${data.code}  --- >>> ${data.value}');
        chosenOffer = data;
      } else {
        FlashHelper.informationBar(
          context,
          message: isValid['message'] ?? 'This offer cannot be selected',
        );
      }
    } else {
      chosenOffer = null;
    }
    notifyListeners();
  }

  Future<void> submitRating({BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      'session_rating': sessionRating.toInt(),
      'trainer_rating': trainerRating.toInt(),
      'workout_mapping_id': workoutMappingId,
      'trainer_id': currentTrainer.data.userId,
      'type': 'workout_feedback',
      'user_id': locator<AppPrefs>().memberId.getValue(),
    };

    bool isSubmitted =
        await RestDatasource().giveGymFeedback(context: context, body: body);
    Navigator.pop(context);
    NavigationService.goBack;
    if (isSubmitted) {
      Fluttertoast.showToast(
        msg: 'Thanks for your valuable feedback',
        timeInSecForIosWeb: 4,
      );
    }
  }

  Future<void> setNewLocation(
      {BuildContext context, LocationResult result}) async {
    selectedNewLocation = result;
    notifyListeners();
    init(context: context);
  }

  Future<void> setFreeSession({BuildContext context, bool val}) async {
    isFreeSession = val;
    notifyListeners();
  }

  Future<void> setSelectedSchedule(
      {BuildContext context, MyScheduleAddonData val}) async {
    selectedSchedule = val;
    workoutGlobalTimer = null;
    notifyListeners();
  }

  Future<void> init({BuildContext context}) async {
    getActiveSubscriptions(context: context);
    getUpcomingEvents(context: context);
    getMemberSubscriptions(context: context);
    getBanner(context: context);
    getCurrentAttendance(context: context);
    getCurrentTrainer(context: context);
    getMySchedules(
      date: Helper.formatDate2(DateTime.now().toIso8601String()),
    );
    // getTodaysWorkout(context: context);
    getMyDietSchedules(
      date: Helper.formatDate2(
        DateTime.now().toIso8601String(),
      ),
    );
    getStats(context: context);
    getAllEvents(context: context);
    getTerms();
    getAllGyms(context: context);
    getAllDiet(context: context);

    getWTFCoinBalance(context: context);
    getShoppingCategories(context: context);
    getCoinHistory(context: context);
    getRedeemHistory(context: context);
    getdietPref(context: context, type: DietPrefType.type1);
    getdietPref(context: context, type: DietPrefType.type2);
    getAllLiveClasses(context: context);
    getAllAddonClasses(context: context);
    context.read<UserStore>().getUserById(context: context);
    context.read<UserStore>().getMemberById(context: context);
  }

  Future<void> joinLiveSession({
    BuildContext context,
    String liveClassId,
    String roomId,
    String addonId,
    String addonName,
  }) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    var body = {
      "trainer_id": currentTrainer.data.userId,
      "addon_id": addonId,
      "liveclass_id": liveClassId,
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "date": Helper.formatDate2(DateTime.now().toIso8601String()),
    };
    Map<String, dynamic> res =
        await RestDatasource().joinLiveSession(body: body);
    Navigator.pop(context);
    if (res != null && res['status']) {
      locator<AppPrefs>()
          .liveClassParticipantId
          .setValue(res['liveclass_participant_id']);
      locator<AppPrefs>()
          .livePtVerificationId
          .setValue(res['pt_verification_id']);
      locator<AppPrefs>().liveExerciseId.setValue(res['exercise_id']);
      log('savedd--->>> ${locator<AppPrefs>().livePtVerificationId.getValue()}   ------ ${locator<AppPrefs>().liveClassParticipantId.getValue()}');
      await showDialog(
        context: context,
        builder: (context) => JitsiMeeting(
          meetingRoomId: roomId,
          meetingSubject: addonName,
        ),
      );
      // Navigator.of(context).push(
      //   CupertinoPageRoute(
      //     builder: (context) => JitsiMeeting(
      //       meetingRoomId: roomId,
      //       meetingSubject: addonName,
      //     ),
      //   ),
      // );
    } else {
      FlashHelper.errorBar(context, message: res['message']);
    }
  }

  Future<void> completeLiveSession(
      {BuildContext context, String eDuration}) async {
    // showDialog(
    //   context: context,
    //   builder: (context) => ProcessingDialog(
    //     message: 'Please wait, compliting your session...',
    //   ),
    // );
    var body = {
      "liveclassparticipant_id":
          locator<AppPrefs>().liveClassParticipantId.getValue(),
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "uid": locator<AppPrefs>().livePtVerificationId.getValue(),
      "e_duration": eDuration,
    };
    Map<String, dynamic> res =
        await RestDatasource().completeLiveSession(body: body);
    // Navigator.pop(context);
    log('mesg-->> ${res}');
    if (res != null && res['status']) {
      // changeNavigationTab(index: 2);
      getLiveWorkoutCalculation(context: context);
    }
  }

  Future<void> getUpcomingEvents({BuildContext context}) async {
    upcomingEvents = null;
    UpcomingEvents res =
        await RestDatasource().getUpcomingEvents(context: context);
    if (res != null) {
      upcomingEvents = res;
      notifyListeners();
    }
  }

  Future<void> getCurrentAttendance({BuildContext context}) async {
    AttendanceDetails res =
        await RestDatasource().getCurrentAttendance(context: context);
    if (res != null) {
      log('attendance updated: ${res.toJson()}');
      attendanceDetails = res;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
      log('attendance updated2: ${attendanceDetails.toJson()}');
    }
  }

  Future<bool> markAttendance(
      {BuildContext context, String mode, String qrCode}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      'user_id': locator<AppPrefs>().memberId.getValue(),
      'mode': mode,
      'date': '${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
      'time': '${DateFormat('h:mm a').format(DateTime.now())}',
      'lat': currentPosition.latitude,
      'long': currentPosition.longitude,
      "role": 'member',
      "qr_code": qrCode,
    };
    var jsonResp =
        await RestDatasource().markAttendance(body: body, context: context);
    Navigator.pop(context);
    if (jsonResp != null && jsonResp['status']) {
      getCurrentAttendance(context: context);
      NavigationService.goBack;
      NavigationService.navigateTo(Routes.mySchedule);
    } else {
      FlashHelper.errorBar(
        context,
        message: jsonResp['message'] ?? '--',
      );
      return false;
    }
  }

  Future<void> manageGlobalTimer({
    BuildContext context,
    String mode,
    bool showCal = false,
  }) async {
    switch (mode) {
      case 'start':
        workoutGlobalTimer = StopwatchDependencies();
        notifyListeners();
        AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
          if (!isAllowed) {
            // Insert here your friendly dialog box before call the request method
            // This is very important to not harm the user experience
            AwesomeNotifications().requestPermissionToSendNotifications();
          } else {
            // if(selectedSchedule)
            await startWorkout(context: context);
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: '123456',
                title: 'Workout Started',
                body:
                    '${locator<AppPrefs>().selectedMySchedule.getValue()} workouts have been started.',
                // createdLifeCycle: NotificationLifeCycle.Background,
                // createdSource: NotificationSource.Local,
                notificationLayout: NotificationLayout.BigPicture,
                // displayedLifeCycle: NotificationLifeCycle.Background,
                customSound: 'resource://raw/res_morph_power_rangers',
                locked: true,
                // autoDismissible: false,
                autoCancel: true,
                // wakeUpScreen: true,
                // autoCancel: false,
                displayOnBackground: true,
                backgroundColor: AppConstants.primaryColor,
                bigPicture: Images.workoutNotification,
                icon: 'resource://drawable/ic_notification',
                displayOnForeground: true,
              ),
            );
            workoutGlobalTimer.stopwatch.start();
          }
        });
        break;
      case 'stop':
        if (workoutGlobalTimer.stopwatch.isRunning) {
          print("${workoutGlobalTimer.stopwatch.elapsedMilliseconds}");
          List<Exercise> temp =
              locator<AppPrefs>().activeScheduleData.getValue().exercises;
          // int duration = 0;
          if (myWorkoutSchedule.data
              .map((e) =>
                  e.exercises.map((e) => e.eDuration.isNotEmpty).toList()[0])
              .toList()[0]) {
            print(
                'TOTAL WORKOUT DURATION: milliseconds: ${workoutGlobalTimer.stopwatch.elapsedMilliseconds}  ---- time: ${Helper.formattedTime(workoutGlobalTimer.stopwatch.elapsedMilliseconds)}');
            // context
            //     .read<GymStore>()
            //     .updateTime(time: Helper.formattedTime(duration));
            print(
                'date: ${locator<AppPrefs>().selectedWorkoutDate.getValue()}');
            await getMyWorkoutSchedules(
              date: locator<AppPrefs>().selectedWorkoutDate.getValue(),
              addonId: selectedSchedule.addonId,
              subscriptionId: selectedSchedule.uid,
            );
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              workoutGlobalTimer.stopwatch.stop();
              AwesomeNotifications().cancel(10);
              workoutGlobalTimer = null;
              notifyListeners();
            });
            if (showCal) {
              getWorkoutCalculation(context: context);
            }
          } else {
            FlashHelper.informationBar(context,
                message: 'Please complete all exercise first.');
          }
        }
        break;
    }
  }

  //TODO Check later
  GymStore() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<bool> processPayment({
    BuildContext context,
    String price,
    Map<String, dynamic> body,
  }) async {
    try {
      subscriptionBody.clear();
      subscriptionBody = body;
      paymentContext = context;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
      String orderId =
          await generateRazorPayId(context: context, amount: price);
      if (orderId.isNotEmpty) {
        var options = {
          "key": Helper.razorPayKey,
          "amount": price.toString(),
          'currency': 'INR',
          'description':
              'Pay to buy ${subscriptionBody['type'] == 'regular' ? 'Gym' : subscriptionBody['type'] == 'event' ? 'Event' : subscriptionBody['type'] == 'addon' ? 'Addon' : 'PT'} Subscription',
          'order_id': orderId,
          "name": 'WTF',
          'prefill': {
            "contact": locator<AppPrefs>().phoneNumber.getValue(),
            "email": locator<AppPrefs>().userEmail.getValue(),
          },
        };
        log('razor pay body:: $options');
        _razorpay.open(options);
      }
    } catch (e) {
      log(e);
    }
  }

  Future<String> generateRazorPayId(
      {BuildContext context, String amount}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Creating your order,  Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      "amount": amount,
      "user_id": locator<AppPrefs>().memberId.getValue(),
    };
    String orderId =
        await RestDatasource().generateRazorPayId(context: context, body: body);
    Navigator.pop(context);

    if (orderId != null && orderId.isNotEmpty) {
      return Future.value(orderId);
    } else {
      return '';
    }
  }

  Future<VerifyPayment> verifyRazorPayPayment(String razorPayPaymentId) async {
    showDialog(
      context: paymentContext,
      builder: (context) => ProcessingDialog(
        message: 'Creating your order,  Please wait...',
      ),
    );
    Map<String, dynamic> body = {'razorpay_payment_id': razorPayPaymentId};
    VerifyPayment verifyPayment =
        await RestDatasource().verifyRazorPayPayment(body: body);
    Navigator.pop(paymentContext);
    return verifyPayment;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(
        'PAYMENT SUCCESS:: id: ${response.orderId} \n signature: ${response.signature} \n payId: ${response.paymentId}');

    VerifyPayment verifyPayment =
        await verifyRazorPayPayment(response.paymentId);

    if (verifyPayment != null &&
        verifyPayment.data != null &&
        verifyPayment.data.status == 'captured') {
      subscriptionBody['trx_id'] = response.paymentId;
      subscriptionBody['trx_status'] = 'done';
      subscriptionBody['order_status'] = 'done';
      bool isDone = await addSubscription(
        body: subscriptionBody,
      );
      print(
          'subscription added   --- event type is: ${subscriptionBody['type']}');
      if (isDone) {
        if (subscriptionBody['type'] == 'event') {
          await addEventParticipation(context: paymentContext);

          NavigationService.navigateTo(Routes.eventPurchaseDone);
        } else {
          NavigationService.navigateTo(Routes.purchaseDone);
        }
        init(context: paymentContext);
        subscriptionBody.clear();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          notifyListeners();
        });
      } else {
        FlashHelper.errorBar(paymentContext,
            message:
                'Failed to subscribe, Please contact support for resolution');
      }
    } else {
      subscriptionBody['trx_id'] = response.paymentId;
      subscriptionBody['trx_status'] = 'failed';
      subscriptionBody['order_status'] = 'done';
      bool isDone = await addSubscription(
        body: subscriptionBody,
      );
      print(
          'subscription added   --- event type is: ${subscriptionBody['type']}');
      if (isDone) {
        if (subscriptionBody['type'] == 'event') {
          await addEventParticipation(context: paymentContext);

          NavigationService.navigateTo(Routes.eventPurchaseDone);
        } else {
          NavigationService.navigateTo(Routes.purchaseDone);
        }
        init(context: paymentContext);
        subscriptionBody.clear();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          notifyListeners();
        });
      } else {
        FlashHelper.errorBar(paymentContext,
            message:
                'Failed to subscribe, Please contact support for resolution');
      }
    }
  }

  Future<bool> addSubscription({
    BuildContext context,
    Map<String, dynamic> body,
    bool showLoader = false,
  }) async {
    print("get Gym Details 1");
    if (showLoader) {
      showDialog(
        context: context,
        builder: (context) => ProcessingDialog(
          message: 'Creating your order,  Please wait...',
        ),
      );
    }
    CommonModel model = await RestDatasource().addSubscritpion(body);
    if (showLoader) {
      Navigator.pop(context);
    }
    if (model.status) {
      return true;
    } else {
      return false;
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    Fluttertoast.showToast(
      msg: "ERROR: " + "Unable to complete the payment. Try Again!",
      timeInSecForIosWeb: 4,
    );
    subscriptionBody['trx_id'] = '';
    subscriptionBody['trx_status'] = 'failed';
    subscriptionBody['order_status'] = 'failed';
    await addSubscription(
      body: subscriptionBody,
    );
    subscriptionBody.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    init(
      context: NavigationService.context,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
      timeInSecForIosWeb: 4,
    );
  }

  Future<void> changeNavigationTab({int index}) async {
    currentIndex = index;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> markDietAsConsumed({
    BuildContext context,
    DateTime selectedDate,
    String dietId,
  }) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    bool res = await RestDatasource().markDietAsConsumed(dietId: dietId);
    Navigator.pop(context);
    if (res != null && res) {
      getMyDietSchedules(
        date: Helper.formatDate2(
          selectedDate.toIso8601String(),
        ),
      );
    }
  }

  Future<void> setRenew(bool val) async {
    isRenew = val;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> setNotificationType(BuildContext context, String type) async {
    selectedNotificationType = type;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    getNotifications(
      context: context,
      type: type,
    );
  }

  Future<void> setSession(SessionData data) async {
    if (selectedSession == data) {
      selectedSession = null;
    } else {
      selectedSession = data;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> setExercise(Exercise data) async {
    print('data: ${data.woName}');
    selectedExercise = data;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    await getWorkoutDetail(
      id: selectedExercise.workoutId,
    );
  }

  Future<void> shiftTrainer({gymId, memberId, newTrainer, reason}) async {
    loading = true;
    return RestDatasource()
        .shiftTrainer(newTrainer: newTrainer, reason: reason)
        .then((value) {
      print('Shift trainer $value');
      loading = false;
    });
  }

  Future<void> getAllGyms({
    BuildContext context,
  }) async {
    await determinePosition();
    GymModel res = selectedNewLocation != null
        ? await RestDatasource().getGym(
            lat: selectedNewLocation.latLng.latitude.toString(),
            lng: selectedNewLocation.latLng.longitude.toString(),
          )
        : await RestDatasource().getGym(
            lat: currentPosition.latitude.toString(),
            lng: currentPosition.longitude.toString(),
          );
    if (res != null) {
      print('gym data is present');
      allGyms = res;
      print('all gym length: ${allGyms.data.length}');
      notifyListeners();
    }
  }

  Future<OfferData> getCoupon(String couponCode) async {
    return APIHelper.getCoupon(couponCode).then((value) {
      if (value.isSuccessed) {
        return OfferData.fromJson(value.data[0]);
      } else {
        return null;
      }
    });
  }

  Future<void> checkEventSubscription({BuildContext context}) async {
    CheckEventParticipation res = await RestDatasource().checkEventSubscription(
      context: context,
      eventId: selectedEventData.uid,
    );
    if (res.status) {
      isEventParticipated = true;
      eventParticipation = res;
      notifyListeners();
    } else {
      isEventParticipated = false;
      eventParticipation = res;
      notifyListeners();
    }
  }

  Future<void> eventCheckIn({BuildContext context, String eventId}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "event_id": eventId,
      "date_checkedin": DateTime.now().toIso8601String(),
    };
    bool res = await RestDatasource().eventCheckIn(
      context: context,
      body: body,
    );
    Navigator.pop(context);
    if (res != null && res) {
      checkEventSubscription(context: context);
    }
  }

  Future<void> checkSlotAvailability(
      {BuildContext context, String slotId}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    dynamic res = await RestDatasource()
        .checkSlotAvailability(context: context, slotId: slotId);
    Navigator.pop(context);
    if (res['status'] == true) {
      getAllSessionsForAddOn(context: context);
    } else {
      FlashHelper.errorBar(
        context,
        message: res['message'],
      );
    }
  }

  Future<void> getNewTrainers() async {
    loading = true;
    notifyListeners();
    return RestDatasource()
        .getNewTrainers(gymId: activeSubscriptions.data.userId)
        .then((value) {
      print('new trainers $value');
      newTrainers = value;
      print(newTrainers.data);
      loading = false;
      notifyListeners();
    });
  }

  Future<void> getGymTrainers({BuildContext context, String gymId}) async {
    loading = true;
    notifyListeners();
    NewTrainersModel res = await RestDatasource().getNewTrainers(
      gymId: gymId,
    );
    if (res != null) {
      selectedGymTrainers = res;
      loading = false;
      notifyListeners();
    }
  }

  Future<void> giveGymFeedback(
      {BuildContext context, double stars, String comment}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      "description": comment,
      'user_id': locator<AppPrefs>().memberId.getValue(),
      'gym_id': selectedGymDetail.data.userId,
      'related_to': stars.toString(),
    };
    bool isSubmitted =
        await RestDatasource().giveGymFeedback(context: context, body: body);
    Navigator.pop(context);
    if (isSubmitted) {
      Fluttertoast.showToast(
        msg: 'Thanks for your valuable feedback',
        timeInSecForIosWeb: 4,
      );
    }
  }

  Future<void> addEventParticipation({
    BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      "member_id": locator<AppPrefs>().memberId.getValue(),
      "event_uid": selectedEventData.uid,
    };
    bool isAdded = await RestDatasource()
        .addEventParticipation(context: context, body: body);
    if (isAdded) {
      NavigationService.navigateToReplacement(Routes.eventPurchaseDone);
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      log('1');
      currentPosition = await Geolocator.getCurrentPosition();
      getUserLocation();
      notifyListeners();
      log(currentPosition.toJson().toString());
      log(currentPosition.latitude.toString());
      log(currentPosition.longitude.toString());
      // final addresses = await Geocoder.google(Helper.googleMapKey)
      // Coordinates coordinates =
      //     Coordinates(currentPosition.latitude, currentPosition.longitude);
      // // final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // final addresses = await Geocoder.google(Helper.googleMapKey)
      //     .findAddressesFromCoordinates(coordinates);
      // currentAddress = addresses.first;
      await _getGooglecoo(currentPosition.latitude, currentPosition.longitude);
      // print('address:: ${currentAddress.toMap()}');
      // log(currentAddress.toMap().toString());
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Address> getUserLocation() async {
    //call this async method from whereever you need
    final coordinates =
        new Coordinates(currentPosition.latitude, currentPosition.longitude);
    var addresses = await Geocoder.google(Helper.googleMapKey)
        .findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    currentAddress = first;
    return first;
  }

  Future<GeoAddress> _getGooglecoo(var lat, var long) async {
    const _host = 'https://maps.google.com/maps/api/geocode/json';
    const apiKey = Helper.googleMapKey;

    final uri = Uri.parse('$_host?key=$apiKey&latlng=$lat,$long');
    print(uri);
    Response response = await http.get(uri);
    final responseJson = json.decode(response.body);
    print(responseJson);
    GeoAddress add = GeoAddress.fromJson(responseJson);
    currentAddressResult = add.results.first;
    notifyListeners();
    return Future.value(add);
  }

  Future<void> getMySchedules({String date}) async {
    loading = true;
    mySchedule = null;
    notifyListeners();
    MySchedule res = await RestDatasource().getMySchedule(date: date);
    if (res != null) {
      mySchedule = res;
      loading = false;
      notifyListeners();
      return;
    }
  }

  Future<void> getAddonMySchedules({String date}) async {
    loading = true;
    addonMySchedules = null;
    notifyListeners();
    MySchedule res = await RestDatasource().getMySchedule(date: date);
    if (res != null) {
      addonMySchedules = res;
      loading = false;
      notifyListeners();
      return;
    }
  }

  Future<void> getMyWorkoutSchedules(
      {String date, String addonId, String subscriptionId}) async {
    loading = true;
    myWorkoutSchedule = null;
    notifyListeners();
    MyWorkoutSchedule res = await RestDatasource().getMyWorkoutSchedule(
      date: date,
      addonId: addonId,
      subscriptionId: subscriptionId,
    );
    if (res != null) {
      myWorkoutSchedule = res;
      loading = false;
      notifyListeners();
      return;
    }
  }

  Future<void> getMyDietSchedules({String date}) async {
    loading = true;
    allDiets = null;
    notifyListeners();
    AllDiets res = await RestDatasource().getMyDietSchedule(date: date);
    if (res != null) {
      allDiets = res;
      loading = false;
      notifyListeners();
      return;
    }
  }

  // Future<void> getTodaysWorkout({BuildContext context}) async {
  //   loading = true;
  //   notifyListeners();
  //   MyWorkoutSchedule res = await RestDatasource().getMyWorkoutSchedule(
  //     date: Helper.formatDate2(
  //       DateTime.now().toIso8601String(),
  //     ),
  //   );
  //   if (res != null) {
  //     todaySchedule = res;
  //     loading = false;
  //     notifyListeners();
  //     return;
  //   }
  // }

  Future<void> getCurrentTrainer({BuildContext context}) async {
    loading = true;
    notifyListeners();
    CurrentTrainer res = await RestDatasource().getCurrentTrainer();
    if (res != null) {
      currentTrainer = res;
      log('trainer initialize::: ${currentTrainer.data?.toJson()}');
      loading = false;
      notifyListeners();
      return;
    }
  }

  Future<void> getWorkoutDetail({id}) async {
    loading = true;
    notifyListeners();
    return RestDatasource().getWorkoutDetail(id: id).then((value) {
      if (value != null) {
        workoutDetails = value;
        loading = false;
        notifyListeners();
        // print('api images: ${workoutDetails.}');
        return;
      }
    });
  }

  setSchedule({schedule}) {
    selectedWorkoutSchedule = schedule;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> updateTime({time}) async {
    workoutTime = time;
    notifyListeners();
    bool isUpdated = await RestDatasource()
        .updateTime(id: selectedExercise.workoutMappingUid, time: time);
    if (isUpdated) {
      print('Updated time $time');
      getMyWorkoutSchedules(
        date: locator<AppPrefs>().selectedWorkoutDate.getValue(),
        addonId: selectedSchedule.addonId,
        subscriptionId: selectedSchedule.uid,
      );
    }
  }

  setEventsData({EventsData data}) {
    selectedEventData = data;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  setGymTypes({GymTypes data}) {
    selectedGymTypes = data;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  setGymDetails({GymDetailsModel data}) {
    selectedGymDetail = data;
    isSelectedGymSubscribed = false;
    if (data == null) {
      selectedGymOffer = null;
      selectedGymAddOns = null;
      selectedGymPlan = null;
      selectedSlotData = null;
      selectedAddOnSlot = null;
      chosenOffer = null;
      selectedSession = null;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> getActiveSubscriptions({BuildContext context}) async {
    loading = true;
    notifyListeners();
    ActiveSubscriptions res = await RestDatasource()
        .activeSubscription(locator<AppPrefs>().memberId.getValue());
    if (res != null) {
      print('active subs resp: ${res.data}');
      activeSubscriptions = res;
      notifyListeners();
      // print('gymName: ${activeSubscriptions.data.gymName}');
    }
  }

  Future<String> workoutVerification(
      {BuildContext context, Map<String, dynamic> body}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    if (selectedSchedule.type == 'regular') {
      body['type'] = selectedSchedule.type;
    }
    String isSaved = await RestDatasource().workoutVerification(body: body);
    Navigator.pop(context);
    if (isSaved.isNotEmpty) {
      // FlashHelper.successBar(context, message: 'Body Fat result Saved');
      return isSaved;
    } else {
      // FlashHelper.errorBar(context, message: 'Please try again!');
      return '';
    }
  }

  Future<bool> workoutOtpVerification(
      {BuildContext context, Map<String, dynamic> body}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    if (selectedSchedule.type == 'regular') {
      body['type'] = selectedSchedule.type;
    }
    bool isSaved = await RestDatasource().workoutOtpVerification(body: body);
    Navigator.pop(context);
    if (isSaved) {
      // FlashHelper.successBar(context, message: 'Body Fat result Saved');
      return isSaved;
    } else {
      FlashHelper.errorBar(context, message: 'Please try again!');
      return false;
    }
  }

  Future<void> startWorkout({BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    List<String> exercises = [];
    //TODO:  WORKOUT CAL LOGIC
    for (int i = 0; i < myWorkoutSchedule.data.length; i++) {
      exercises.addAll(
          myWorkoutSchedule.data[i].exercises.map((e) => e.uid).toList());
    }
    print('exercise list: ${exercises.map((e) => e).toList()}');
    Map<String, dynamic> body = {
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "trainer_id": currentTrainer.data.userId,
      "date": locator<AppPrefs>().selectedWorkoutDate.getValue(),
      "workout_mapping_id": exercises,
      'addon_id': selectedSchedule.addonId,
      'subscription_id': selectedSchedule.uid,
    };
    print('verification body: $body');
    String uid = await workoutVerification(context: context, body: body);
    Navigator.pop(context);
    return uid;
  }

  Future<void> getWorkoutCalculation({BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    List<String> exercises = [];
    //TODO:  WORKOUT CAL LOGIC
    for (int i = 0; i < myWorkoutSchedule.data.length; i++) {
      exercises.addAll(
          myWorkoutSchedule.data[i].exercises.map((e) => e.uid).toList());
    }
    print('exercise list: ${exercises.map((e) => e).toList()}');
    // Map<String, dynamic> body = {
    //   "user_id": locator<AppPrefs>().memberId.getValue(),
    //   "trainer_id": currentTrainer.data.userId,
    //   "date": Helper.formatDate2(
    //       locator<AppPrefs>().currentWorkoutDaySelected.getValue()),
    //   "workout_mapping_id": exercises,
    //   'addon_id': mySchedule.data.addonPt.first.addonId,
    // };
    // print('verification body: $body');
    workoutMappingId = await RestDatasource().getWorkoutVerification(
      date: locator<AppPrefs>().selectedWorkoutDate.getValue(),
    );
    NavigationService.goBack;
    notifyListeners();
    if (workoutMappingId.isNotEmpty && selectedSchedule.type != 'regular') {
      bool isVerified = await showModalBottomSheet<bool>(
        context: context,
        builder: (context) {
          return OtpVerifySheet(
            onVerified: (val) {},
            uid: workoutMappingId,
          );
        },
        enableDrag: true,
        isDismissible: false,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      );
      if (isVerified) {
        showDialog(
          context: context,
          builder: (context) => ProcessingDialog(
            message: 'Please wait...',
          ),
        );
        getMySchedules(
            date: locator<AppPrefs>().selectedWorkoutDate.getValue());
        WorkoutComplete res = await RestDatasource().getWorkoutCalculation(
          context: context,
          body: {'exercises': exercises},
        );
        Navigator.pop(context);
        // manageGlobalTimer(context: context, mode: 'stop');
        if (res != null) {
          await getMyWorkoutSchedules(
            date: locator<AppPrefs>().selectedWorkoutDate.getValue(),
            addonId: selectedSchedule.addonId,
            subscriptionId: selectedSchedule.uid,
          );
          completedWorkout = res;
          notifyListeners();
          NavigationService.goBack;
          NavigationService.navigateTo(Routes.exerciseDone);
        }
      } else {}
    } else {
      showDialog(
        context: context,
        builder: (context) => ProcessingDialog(
          message: 'Please wait...',
        ),
      );
      Map<String, dynamic> body = {
        'uid': workoutMappingId,
        'otp': '',
      };
      bool isVerified = await workoutOtpVerification(
        context: context,
        body: body,
      );
      getMySchedules(date: locator<AppPrefs>().selectedWorkoutDate.getValue());
      WorkoutComplete res = await RestDatasource().getWorkoutCalculation(
        context: context,
        body: {'exercises': exercises},
      );
      Navigator.pop(context);
      // manageGlobalTimer(context: context, mode: 'stop');
      if (res != null) {
        await getMyWorkoutSchedules(
          date: locator<AppPrefs>().selectedWorkoutDate.getValue(),
          addonId: selectedSchedule.addonId,
          subscriptionId: selectedSchedule.uid,
        );
        completedWorkout = res;
        notifyListeners();
        NavigationService.goBack;
        NavigationService.navigateTo(Routes.exerciseDone);
      }
    }
  }

  Future<void> getLiveWorkoutCalculation({BuildContext context}) async {
    showDialog(
      context: NavigationService.navigatorKey.currentContext,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    WorkoutComplete res = await RestDatasource().getWorkoutCalculation(
      context: context,
      body: {
        'exercises': [locator<AppPrefs>().liveExerciseId.getValue()]
      },
    );
    Navigator.pop(NavigationService.navigatorKey.currentContext);
    // manageGlobalTimer(context: context, mode: 'stop');
    if (res != null) {
      completedWorkout = res;
      notifyListeners();
      init(context: NavigationService.navigatorKey.currentContext);
      NavigationService.navigateTo(Routes.exerciseDone);
    }
  }

  Future<void> getNotifications({BuildContext context, String type}) async {
    AllNotifications res = await RestDatasource().getNotifications(
      type: type,
      context: context,
    );
    if (res != null) {
      if (type == 'all') {
        allNotifications = res;
      } else {
        newNotifications = res;
      }
      notifyListeners();
    }
  }

  Future<void> getStats({BuildContext context}) async {
    Stats res = await RestDatasource().getStats(
      context: context,
    );
    if (res != null) {
      memberStats = res;
      notifyListeners();
    }
  }

  Future<void> getMemberSubscriptions({BuildContext context}) async {
    try {
      loading = true;
      regularSubscriptions = [];
      addOnSubscriptions = [];
      addOnLiveSubscriptions = [];
      eventSubscriptions = [];
      notifyListeners();
      //TODO: uncomment these when api is fixed
      MemberSubscriptions res = await RestDatasource()
          .memberSubscription(locator<AppPrefs>().memberId.getValue());

      if (res != null) {
        memberSubscriptions = res;
        loading = false;
        notifyListeners();
        memberSubscriptions.data.forEach((element) {
          log(element.type);
          if (element.trxStatus.toLowerCase() != 'failed') {
            if (element.type == 'regular') {
              regularSubscriptions.add(element);
            }
            if (element.type == 'addon' || element.type == 'addon_pt') {
              addOnSubscriptions.add(element);
            }
            if (element.type == 'addon_live') {
              addOnLiveSubscriptions.add(element);
            }
            if (element.type == 'event') {
              eventSubscriptions.add(element);
            }
          }
        });
        log('Total:: ${memberSubscriptions.data.length} ,  regular: ${regularSubscriptions.length} , live:: ${addOnLiveSubscriptions.length}');
        notifyListeners();
      }
    } catch (e) {
      print('store ->member subs error: $e');
    }
  }

  Future<void> getAllEvents({BuildContext context}) async {
    AllEvents res = await RestDatasource().getAllEvents();
    if (res != null) {
      allEventsResult = res;
      if (allEventsResult.data != null && allEventsResult.data.isNotEmpty) {
        allChallenges = [];
        allEvents = [];
        allEventsResult.data.forEach((element) {
          if (element.isPublic == 'yes') {
            if (element.mode == 'challenge') {
              allChallenges.add(element);
            } else {
              allEvents.add(element);
            }
            print(
                'all challenge len: ${allChallenges.length}   ------   all events len:: ${allEvents.length}');
          }
        });
      } else {
        allChallenges = [];
        allEvents = [];
      }
      notifyListeners();
    }
  }

  Future<void> getEventById({BuildContext context, String eventId}) async {
    loading = true;
    notifyListeners();
    EventsData res = await RestDatasource().getEventById(eventId);
    if (res != null) {
      selectedEventData = res;
      checkEventSubscription(context: context);
      notifyListeners();
    }
  }

  Future<void> getAllGymOffers({BuildContext context, String gymId}) async {
    loading = true;
    notifyListeners();
    GymOffers res = await RestDatasource().getAllGymOffers(
      gymId: gymId,
    );
    if (res != null) {
      selectedGymOffer = res;
      notifyListeners();
    }
  }

  Future<void> getDiscoverNow({BuildContext context, String type}) async {
    loading = true;
    discoverType = type;
    notifyListeners();
    GymTypes res = selectedNewLocation != null
        ? await RestDatasource().getDiscoverNow(
            type: type,
            lat: selectedNewLocation.latLng.latitude.toString(),
            lng: selectedNewLocation.latLng.longitude.toString())
        : await RestDatasource().getDiscoverNow(
            type: type,
            lat: currentPosition.latitude.toString(),
            lng: currentPosition.longitude.toString());
    if (res != null) {
      selectedGymTypes = res;
      notifyListeners();
    }
  }

  setSlotData(SlotData data) {
    selectedSlotData = data;
    notifyListeners();
  }

  setAddOnSlot({
    BuildContext context,
    AddOnData data,
    bool getTrainers = true,
    bool isFree = false,
    String gymId,
  }) {
    selectedSlotDetails = null;
    selectedAddOnSlot = null;
    selectedSlotData = null;
    selectedTrainer = null;
    isFreeSession = isFree;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    selectedAddOnSlot = data;
    if (gymId != null) {
      selectedGymId = gymId;
    }
    notifyListeners();
    // getSlotDetails(
    //   context: context,
    //   addOnId: data.uid,
    //   date: Helper.formatDate(DateTime.now().toIso8601String()),
    // );
    if (getTrainers)
      getGymTrainers(
          context: context,
          gymId: gymId != null ? gymId : selectedGymDetail.data.userId);
  }

  setStartDate({BuildContext context, DateTime dateTime}) {
    selectedStartingDate = dateTime;
    notifyListeners();
  }

  Future<void> setGymId(String id) {
    selectedGymId = id;
    notifyListeners();
  }

  Future<void> getSlotDetails({
    BuildContext context,
    String addOnId,
    String date,
    String trainerId,
  }) async {
    loading = true;
    selectedSlotDetails = null;
    notifyListeners();
    AddOnSlotDetails res = await RestDatasource().getSlotDetails(
      context: context,
      date: date,
      addOnId: addOnId,
      trainerId: trainerId,
      gymId:
          selectedGymId != null ? selectedGymId : selectedGymDetail.data.userId,
    );
    if (res != null) {
      if (res.status) {
        selectedSlotDetails = res;
        loading = false;
        print('details saved: ${selectedSlotDetails?.data?.length}');
        notifyListeners();
      } else {
        selectedSlotDetails = res;
        loading = false;
        notifyListeners();
        FlashHelper.errorBar(context, message: res.message);
      }
    } else {}
  }

  Future<void> getGymPlans({BuildContext context, String gymId}) async {
    print("get Gym Details 1");
    GymPlanModel model = await RestDatasource().getGymPlans(gymId: gymId);

    if (model != null) {
      selectedGymPlans = model;
    } else {
      selectedGymPlans = GymPlanModel(
        data: [],
      );
    }
    notifyListeners();
  }

  Future<void> getGymDetails({BuildContext context, String gymId}) async {
    loading = true;
    notifyListeners();
    GymDetailsModel res = await RestDatasource().getGymDetails(gymId);
    if (res != null) {
      selectedGymDetail = res;
      getAllGymOffers(gymId: gymId, context: context);
      notifyListeners();
    } else {
      selectedGymDetail = GymDetailsModel(
        status: false,
      );
      notifyListeners();
    }
    getTrailInfo(context: context);
    getAddOnForGym(gymId: gymId, context: context);
    checkGymSubscription(context: context, gymId: gymId);
    getTerms(context: context);
  }

  Future<void> getAllSessionsForAddOn({BuildContext context}) async {
    AllSessions res = await RestDatasource().getAllSessionsForAddOn(
      context: context,
      addOnId: selectedAddOnSlot.uid,
    );
    if (res != null) {
      selectedAddonSessions = res;
      notifyListeners();
      if (selectedAddonSessions != null &&
          selectedAddonSessions.data.length > 0) {
        NavigationService.navigateTo(Routes.bookSession);
      } else {
        FlashHelper.informationBar(context,
            message:
                'No session Present, Please contact Gym Owner to Unlock Sessions');
        // NavigationService.navigateTo(Routes.bookingSummaryAddOn);
      }
    }
  }

  Future<void> getTrailInfo({BuildContext context}) async {
    bool res = await RestDatasource().getTrailInfo(
      context: context,
    );
    if (res != null) {
      showTrailOffer = true;
    } else {
      showTrailOffer = false;
    }
    notifyListeners();
  }

  Future<void> getTerms({BuildContext context}) async {
    loading = true;
    notifyListeners();
    WhyChooseWtf res = await RestDatasource().whyChooseWtf();
    if (res != null) {
      loading = false;
      whyChooseWtf = res;
      print('why choose us len =========== ${whyChooseWtf.data.length}');
      notifyListeners();
    }
  }

  Future<void> getAllLiveClasses({BuildContext context}) async {
    loading = true;
    allLiveClasses = null;
    notifyListeners();
    GymAddOn res = await RestDatasource().getLiveClasses();
    if (res != null) {
      loading = false;
      allLiveClasses = res;
      print('getAllLiveClasses len =========== ${allLiveClasses.data.length}');
      notifyListeners();
    }
  }

  Future<void> getAllAddonClasses({BuildContext context}) async {
    loading = true;
    allAddonClasses = null;
    notifyListeners();
    GymAddOn res = await RestDatasource().getLiveClasses(isLive: false);
    if (res != null) {
      loading = false;
      allAddonClasses = res;
      notifyListeners();
    }
  }

  Future<void> getAddOnForGym({BuildContext context, String gymId}) async {
    GymAddOn res = await RestDatasource().getAddOnForGym(gymId);
    if (res != null) {
      selectedGymAddOns = res;
      notifyListeners();
    }
    checkGymSubscription(context: context, gymId: gymId);
  }

  Future<void> checkGymSubscription(
      {BuildContext context, String gymId}) async {
    int res = await RestDatasource().checkGymSubscription(
      context: context,
      gymId: gymId,
      userId: locator<AppPrefs>().memberId.getValue(),
    );
    loading = false;
    notifyListeners();
    if (res != null && res > 0) {
      isSelectedGymSubscribed = true;
      notifyListeners();
    }
  }

  Future<ResponseData> postAttendanceCode(Map body) {
    return APIHelper.postAttendance(body).then((value) {
      return ResponseData(
        isSuccessed: value.status,
        message: value.messsage,
      );
    });
  }

  // Future<ResponseData<GymData>> getGymDetailbyId(String id) async {
  //   return APIHelper.getGymDetails(id).then((value) {
  //     if (value['status'] == true) {
  //       print(';data is here');
  //       print(value['data'].toString());
  //       return ResponseData(
  //         data: GymData.fromJson(value['data']),
  //         isSuccessed: true,
  //       );
  //     }
  //     return ResponseData(
  //       isSuccessed: false,
  //       message: 'Something went wrong',
  //     );
  //   });
  // }

  List<BannerItem> bannerList = [];

  Future<void> getBanner({BuildContext context}) async {
    print("  calling");
    ApiResponse<dynamic> res = await APIHelper.banner();
    print(res.state.toString());
    if (res.state == ApiState.Success) {
      if (res.status) {
        print(res.data.toString());
        final data = List<BannerItem>.from(
          res.data.map(
            (x) => BannerItem.fromJson(x),
          ),
        );
        bannerList = data;
        notifyListeners();
      }
    }
  }

  Future<void> getWTFCoinBalance({BuildContext context}) async {
    CoinBalance res = await RestDatasource().getWTFCoinBalance();
    if (res != null) {
      coinBalance = res;
      notifyListeners();
    }
  }

  Future<void> getShoppingCategories({BuildContext context}) async {
    ShoppingCategories res = await RestDatasource().getShoppingCategories();
    if (res != null) {
      shoppingCategories = res;
      notifyListeners();
    }
  }

  Future<void> getOffers({BuildContext context, String keywords}) async {
    Offers res = await RestDatasource().getOffers(keywords);
    if (res != null) {
      offers = res;
      offerCategory = keywords;
      notifyListeners();
    }
  }

  Future<void> getCoinHistory({BuildContext context}) async {
    CoinHistory res = await RestDatasource().getCoinHistory();
    if (res != null) {
      coinHistory = res;
      notifyListeners();
    }
  }

  Future<void> getRedeemHistory({BuildContext context}) async {
    RedeemHistory res = await RestDatasource().getRedeemHistory();
    if (res != null) {
      redeemHistory = res;
      notifyListeners();
    }
  }

  Future<bool> saveRedeem(
      {BuildContext context,
      String offername,
      String description,
      String offercode}) async {
    Map<String, dynamic> body = {
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "coins": "200",
      "remarks": "Coins Redeem",
      "offer_name": offername,
      "offer_details": description,
      "offer_code": offercode,
    };
    Map res = await RestDatasource().redeemCoin(context: context, body: body);
    if (res['status'] == true) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

//dietpref
  Future<void> getdietPref({BuildContext context, DietPrefType type}) async {
    if (type == DietPrefType.type1) {
      DietPref res = await RestDatasource().getDietPref("type1");
      if (res != null) {
        dprefType1 = res;
        notifyListeners();
      }
    } else {
      DietPref res = await RestDatasource().getDietPref("type2");
      if (res != null) {
        dprefType2 = res;
        notifyListeners();
      }
    }
  }

//dietcat
  Future<void> getdietcat(
      {BuildContext context, String day, String date}) async {
    dietItem = null;
    notifyListeners();
    DietItem res = await RestDatasource().getDietCat(day, date);
    if (res != null) {
      dietItem = res;
      notifyListeners();
    }
  }

  //dietcon
  Future<void> dietConsume(
      {BuildContext context,
      String mealId,
      String date,
      String image,
      String day}) async {
    showDialog(
      context: NavigationService.navigatorKey.currentContext,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      "meal_id": mealId,
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "dietcategory_id":
          locator<AppPrefs>().memberData.getValue().dietcategoryid,
      "status": "active",
      "date": date,
      "image": image,
    };
    dynamic res =
        await RestDatasource().dietConsumtion(context: context, body: body);
    Navigator.pop(context);
    if (res != null) {
      //dietItem = res;
      log("diet consumed" + res.toString());
      getdietcat(
        context: context,
        day: day,
        date: date,
      );
      FlashHelper.informationBar(
        context,
        message: res['message'],
      );
    }
  }

  Future<bool> eventSubmissionAdd({
    BuildContext context,
    String platform,
    String link,
    String date,
  }) async {
    showDialog(
      context: NavigationService.navigatorKey.currentContext,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "event_id": selectedEventData.uid,
      "platform": platform,
      "link": link,
      "date": date,
    };
    dynamic res =
        await RestDatasource().eventSubmissionAdd(context: context, body: body);
    Navigator.pop(context);
    if (res != null) {
      //dietItem = res;
      log("event submitted" + res.toString());
      NavigationService.goBack;
      getEventSubmission(context: context, eventId: selectedEventData.uid);
      FlashHelper.informationBar(
        context,
        message: res['message'],
      );
      return true;
    }
    return false;
  }

  Future<bool> eventSubmissionUpdate({
    BuildContext context,
    String submissionUid,
    String platform,
    String link,
    String date,
  }) async {
    showDialog(
      context: NavigationService.navigatorKey.currentContext,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    Map<String, dynamic> body = {
      if (submissionUid != null) "uid": submissionUid,
      "user_id": locator<AppPrefs>().memberId.getValue(),
      "event_id": selectedEventData.uid,
      "platform": platform,
      "link": link,
      "date": date,
    };
    dynamic res = await RestDatasource()
        .eventSubmissionUpdate(context: context, body: body);
    Navigator.pop(context);
    if (res != null) {
      //dietItem = res;
      log("event submitted" + res.toString());
      selectedSubmissions = [];
      notifyListeners();
      NavigationService.goBack;
      getEventSubmission(context: context, eventId: selectedEventData.uid);

      FlashHelper.informationBar(
        context,
        message: res['message'],
      );
      return true;
    }
    return false;
  }

  Future<void> getEventSubmission({
    BuildContext context,
    String eventId,
  }) async {
    EventSubmissions res = await RestDatasource()
        .getEventSubmissions(context: context, eventId: eventId);
    if (res != null && res.data != null) {
      //dietItem = res;
      log("event submissions:: ${res.toJson()}");
      selectedEventSubmissions = res;
      notifyListeners();
    } else {
      FlashHelper.informationBar(
        context,
        message: res.errorMessage,
      );
    }
  }

  //diet consumed
  Future<void> getdietConsumed({BuildContext context, String date}) async {
    dietConsumed = null;
    notifyListeners();
    DietConsumed res =
        await RestDatasource().dietConsumed(context: context, date: date);
    log(res.toString());
    dietConsumed = res;
    notifyListeners();
  }

  Future<void> collectDietRewards({BuildContext context, String date}) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    List<String> consumedItem = [];
    DietConsumed res =
        await RestDatasource().dietConsumed(context: context, date: date);
    if (res != null) {
      res.data.map((e) {
        consumedItem.add(e.uid);
      }).toList();
      Map<String, dynamic> body = {
        "dietmapping_ids": consumedItem,
      };

      if (consumedItem != null) {
        dynamic re2 =
            await RestDatasource().dietRewards(context: context, body: body);
        if (re2 != null) {
          if (re2['coins'] != null) {
            Navigator.pop(context);
            NavigationService.goBack;
            NavigationService.navigateToWithArgs(
              Routes.congratsScreen,
              {'coin': re2['coins'].toString()},
            );
          } else {
            FlashHelper.informationBar(
              context,
              message: "You have already collected todays reward",
            );
          }

          notifyListeners();
        }
      } else {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  //diet consumed
  Future<void> getAllDiet({BuildContext context, String dietType}) async {
    List<String> productId = ['Lean', 'Gain', 'Maintain'];
    print('selected index of in GymStore :: --- $dietType');
    List<DietModel> list = await RestDatasource().getAllDietsCategory();
    List<CategoryDietModel> data = productId
        .map((category) => CategoryDietModel(
            categoryLabel: category,
            products: list
                .where((product) =>
                    product.type1_name == category &&
                    product.type2_name == dietType)
                .toList()))
        .toList();
    diet = data;
    notifyListeners();
  }

  // List<DayWise> getss(List<DietModel> data)async=>data.forEach((element)=>element.day.list);
  List<DayWise> gettsss(List<DietModel> data) {
    List<DayWise> d = [];
    for (var v in data) {
      d.addAll(v.day.list);
    }
    // print('status length final --- ${d.length}');
    return d;
  }

  Future<void> getDietPlan() async {
    await RestDatasource().getDietPlans();
  }

  Future<bool> sendOtpToGymOwner({String gymId})async{
    // sendGymOwnerOtp
    bool response = await RestDatasource().sendGymOwnerOtp(gymId: gymId);
    return response;
  }
  Future<bool> verifyOtpToGymOwner({@required String gymId,@required String otp})async{
    // sendGymOwnerOtp
    bool response = await RestDatasource().verifyGymOwnerOtp(gymId: gymId,otp: otp);
    return response;
  }
}
