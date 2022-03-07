import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Helper.dart';

import '../main.dart';

class Api {
  //This helps to update the app
  static String currentVersion = '1';

  static String getGyms(String lat, String lng) =>
      'gym?status=active&lat=$lat&long=$lng';
  // static const String SEARCH_GYM = 'gym/search';
  static String SEARCH_GYM({String lat, String lng, String query}) => 'gym/nearestgym?lat=$lat&long=$lng&name=$query';
  static const String GYM_DETAILS = 'gym/getbyid?uid=';
  static const String EVENTS = 'event?type=new';
  static const String getWorkoutCalculations = 'workoutmapping/cal';
  static const String DIET_CONSUMPTION = "dietmapping/add";
  static const String COLLETC_DIET_REWARDS = "dietmapping/cal";
  static getEventById(String eventId) => 'event/getbyid?uid=$eventId';
  static getUserById(String id) => 'user/id/$id';
  static getMemberById(String id) => 'member/id/$id';
  static markDietConsumed(String id) => 'dietmapping/diet_consumed?uid=$id';
  static getGymTypes(String types, String lat, String lng) =>
      'gym?type=$types&lat=$lat&long=$lng';
  static verifyRazorPayPayment() => 'subscription/verifyPayment';
  static checkSlotAvailability(String slotId) =>
      'slot/checkslotbymember?user_id=${locator<AppPrefs>().memberId.getValue()}&slot_id=$slotId';
  static String slotDetails(String date, String trainerId, String gymId) =>
      'slot/check/new?date=$date&trainer_id=$trainerId&gym_id=$gymId';
  static String slotDetails2(String date, String gymId) =>
      'slot/check/new?date=$date&gym_id=$gymId';
  static String checkSubscription(String userId, String gymId) =>
      'subscription/getbyid?user_id=$userId&gym_id=$gymId';
  static gymAddOn(String gymId) => 'addon?gym_id=$gymId';
  static getUpcomingEvents() =>
      'subscription/suscribed/event?user_id=${locator<AppPrefs>().memberId.getValue()}&type=new';
  static const String GET_GYM_PLAN = 'gym/plan/';
  static const String GET_GYM_SLOT = 'slot/?gym_id=';
  static const String ADD_SUBSCRIPTION = 'subscription/add';
  static myWorkoutSchedule(
          String date, String addonId, String subscriptionId) =>
      addonId != null
          ? 'workoutmapping/member?user_id=${locator<AppPrefs>().memberId.getValue()}&date=$date&addon_id=$addonId&subscription_id=$subscriptionId'
          : 'workoutmapping/member?user_id=${locator<AppPrefs>().memberId.getValue()}&date=$date&subscription_id=$subscriptionId';
  static mySchedule(String user, String date) =>
      'subscription/myschedule?user_id=$user&date=$date';
  static dietSchedule(String user, String date) =>
      'dietmapping/member?member_id=${locator<AppPrefs>().memberId.getValue()}&date=$date';
  static workoutDetail(String id) => 'workout/getbyid?uid=$id';
  static const String updateTime = 'workoutmapping/update';
  static const String shiftTrainer = 'shift/add';
  static const String addEventParticipation = 'participation/add';
  static newTrainers(id) => 'trainer/gym/$id';
  static String markAttendance() => 'attandance/add';
  static String saveCalorieProgress() => 'calories_calculator/add';
  static String saveBmrProgress() => 'bmr/add';
  static String saveBodyFatProgress() => 'bodyfat/add';
  static String workoutVerification() => 'workoutmapping/woVerification';
  static String getWorkoutVerification(String date) =>
      'workoutmapping/pendingVerification?user_id=${locator<AppPrefs>().memberId.getValue()}&date=$date';
  static String workoutOtpVerification() => 'workoutmapping/woVerifyOTP';
  static String getTrailInfo() =>
      'user/checkfreetrail?user_id=${locator<AppPrefs>().memberId.getValue()}';
  static String addParticipation() => 'participation/add';
  static String eventCheckIn() => 'participation/checkin';
  static String generateRazorpayId() => 'transaction/get_order_id';
  static String notification(String type) =>
      'notificationsent?user_id=${locator<AppPrefs>().memberId.getValue()}&type=$type';
  static String getStats() =>
      'member/getstats?member_id=${locator<AppPrefs>().memberId.getValue()}';
  static String getCurrentTrainer() =>
      'trainerandmember/member/getpt?uid=${locator<AppPrefs>().memberId.getValue()}';
  static String checkParticipation(String eventId) =>
      'participation/check?event_id=$eventId&user_id=${locator<AppPrefs>().memberId.getValue()}';
  static String getCurrentAttendance(String memberId) =>
      "attandance/member_check_in?user_id=$memberId&date='${Helper.formatDate2(DateTime.now().toIso8601String())}'&role=member";

  static String getWTFCoinBalance() =>
      "coins/?user_id=${locator<AppPrefs>().memberId.getValue()}";
  static String getShoppingCategories() => "coins/getallcategories";
  static String getOffers(String keywords) =>
      "coins/getoffers?keyword=$keywords";
  static String saveRedeemCoin() => "coins/redeemcoin";
  static String getCoinHistory() =>
      "coins/getcoinstatment/?user_id=${locator<AppPrefs>().memberId.getValue()}";
  static String getRedeemHistory() =>
      "coins/redeemhistory?user_id=${locator<AppPrefs>().memberId.getValue()}";
  static String dietPref(String type) => "diettype/getall?page=1&type=$type";
  static String getDietCat(String day, String date) =>
      'dietcat/getbyId?uid=${locator<AppPrefs>().memberData.getValue().dietcategoryid}&day=$day&user_id=${locator<AppPrefs>().memberId.getValue()}&date=$date';
  static String getConsumedDiet(String date) =>
      "dietmapping?user_id=${locator<AppPrefs>().memberId.getValue()}&date=$date";
  static String eventSubmissionAdd() => "eventsubmission/add";
  static String eventSubmissionUpdate() => "eventsubmission/update";
  static String getEventSubmission(String eventId) =>
      "eventsubmission/mobile?event_id=$eventId";

  static String getAllDietDetails()=>'dietcat/getall?page=1';
  static String getDietPlan()=>'/dietpackage?page=1&limit=10&name=';
  static String getNearByGym(String lat,String lng,String type)=>'gym/nearestgym?lat=$lat&long=$lng&type=$type';
  static String sendOtpToGymOwner()=>'subscription/sendotp';
  static String verifyOtpToGymOwner(
          {String userId, String gymId, String otp})=>'subscription/verify?user_id=$userId&gym_id=$gymId&otp=$otp';
  static String getGymDetailsById({String gymId,String lat,String lng})=>'gym/getbyid?uid=$gymId&lat=$lat&long=$lng';
  static String getForceUpdate()=>'version/latest';
  static String fetchSessionDuration({String addOnId})=>'session/addon?addon=$addOnId';
}
