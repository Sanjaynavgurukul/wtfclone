import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/api_constants.dart';
import 'package:wtf/helper/api_helper.dart';
import 'package:wtf/helper/network_utils.dart';
import 'package:wtf/model/ActiveSubscriptions.dart';
import 'package:wtf/model/AllSessions.dart';
import 'package:wtf/model/AttendanceDetails.dart';
import 'package:wtf/model/EventSubmissions.dart';
import 'package:wtf/model/GymOffers.dart';
import 'package:wtf/model/MemberSubscriptions.dart';
import 'package:wtf/model/Stats.dart';
import 'package:wtf/model/UpcomingEvents.dart';
import 'package:wtf/model/User.dart';
import 'package:wtf/model/VerifyPayment.dart';
import 'package:wtf/model/WhyChooseWtf.dart';
import 'package:wtf/model/WorkoutComplete.dart';
import 'package:wtf/model/WorkoutDetailModel.dart';
import 'package:wtf/model/add_on_slot_details.dart';
import 'package:wtf/model/addons_cat_model.dart';
import 'package:wtf/model/all_diets.dart';
import 'package:wtf/model/all_events.dart';
import 'package:wtf/model/all_notifications.dart';
import 'package:wtf/model/check_event_participation.dart';
import 'package:wtf/model/coin_balance.dart';
import 'package:wtf/model/coin_history.dart';
import 'package:wtf/model/common_model.dart';
import 'package:wtf/model/current_trainer.dart';
import 'package:wtf/model/diet_consumed.dart';
import 'package:wtf/model/diet_item.dart';
import 'package:wtf/model/diet_model.dart';
import 'package:wtf/model/diet_pref.dart';
import 'package:wtf/model/force_update_model.dart';
import 'package:wtf/model/gym_add_on.dart';
import 'package:wtf/model/gym_cat_model.dart';
import 'package:wtf/model/gym_details_model.dart';
import 'package:wtf/model/gym_model.dart';
import 'package:wtf/model/gym_plan_model.dart';
import 'package:wtf/model/gym_search_model.dart';
import 'package:wtf/model/gym_slot_model.dart';
import 'package:wtf/model/member_detils.dart';
import 'package:wtf/model/my_schedule_model.dart';
import 'package:wtf/model/my_workout_schedule_model.dart';
import 'package:wtf/model/new_trainers_model.dart';
import 'package:wtf/model/offers.dart';
import 'package:wtf/model/partial_payment_model.dart';
import 'package:wtf/model/preamble_model.dart';
import 'package:wtf/model/redeem_history.dart';
import 'package:wtf/model/shopping_categories.dart';

import '../main.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();

  static const String BASE_URL = APIHelper.BASE_URL;

  // static const String BASE_URL = 'http://13.232.102.139:9000/';

  static Map<String, String> header = {
    "Authorization": "Bearer ${locator<AppPrefs>().token.getValue()}"
  };

  //get Gym Details
  ///@Gaurav
  // Future<GymModel> getGym({String lat, String lng}) async {
  //   String token = locator<AppPrefs>().token.getValue();
  //   Map<String, String> mapHeader = Map();
  //   print('Curent lat and long --- ' + lat + " " + lng);
  //   mapHeader["Authorization"] = "Bearer " + token;
  //   String url = BASE_URL + Api.getNearByGym(lat, lng, '');
  //   // String url = BASE_URL + Api.getGyms(lat, lng);
  //   log('URL: $url');
  //   return _netUtil
  //       .get(
  //     url,
  //     headers: mapHeader,
  //   )
  //       .then((dynamic res) {
  //     print("response getGym : " + res.toString());
  //     GymModel model = res != null
  //         ? GymModel.fromJson(res)
  //         : GymModel(
  //             data: [],
  //             status: false,
  //           );
  //     return model;
  //   });
  // }

  Future<NewTrainersModel> getNewTrainers({gymId}) async {
    print("shift trainer"); //
    String url = BASE_URL + Api.newTrainers(gymId);
    log(url);
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    // mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(
      url,
      headers: mapHeader,
    )
        .then((value) {
      print(value);
      return NewTrainersModel.fromJson(value);
    });
  }

  Future<AllSessions> getAllSessionsForAddOn(
      {BuildContext context, String addOnId}) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      String url = APIHelper.allSessionForAddOn(addOnId);
      log('url: $url');
      var res = await _netUtil.get(
        url,
        headers: mapHeader,
      );
      print("response getAllSessionsForAddOn : " + res.toString());
      AllSessions data;
      if (res != null) data = AllSessions.fromJson(res);
      return data;
    } catch (e) {
      print('add member error: $e');
      return AllSessions(data: []);
    }
  }

  Future<AttendanceDetails> getCurrentAttendance({BuildContext context}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL +
        Api.getCurrentAttendance(locator<AppPrefs>().memberId.getValue());
    log('url: $url');
    var response = await _netUtil.get(
      url,
      headers: mapHeader,
    );
    print('attendence response $response');
    AttendanceDetails res;
    if (response != null) res = AttendanceDetails.fromJson(response);
    return Future.value(res);
  }

  Future<dynamic> markAttendance(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.markAttendance();
    log('url: $url');
    var res = await _netUtil.post(
      url,
      body: body,
      headers: mapHeader,
    );
    return Future.value(res);
  }

  Future<bool> saveCalorieProgress({Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.saveCalorieProgress();
    log('url: $url');
    var res = await _netUtil.post(
      url,
      body: body,
      headers: mapHeader,
    );
    bool isAdded = false;
    if (res != null) {
      isAdded = res['status'];
    }
    return Future.value(isAdded);
  }

  Future<bool> saveBodyFatProgress({Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.saveBodyFatProgress();
    log('url: $url');
    var res = await _netUtil.post(
      url,
      body: body,
      headers: mapHeader,
    );
    bool isAdded = false;
    if (res != null) {
      isAdded = res['status'];
    }
    return Future.value(isAdded);
  }

  Future<String> workoutVerification({Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.workoutVerification();
    log('url: $url');
    print('check workoutVerification body $body');
    var res = await _netUtil.post(
      url,
      body: body,
      headers: mapHeader,
    );
    print('check workoutVerification res $res');
    String isAdded = '';
    if (res != null && res.containsKey('uid')) {
      print('check workoutVerification res is not null ${res['uid']}');
      isAdded = res['uid'];
    } else {
      print('check workoutVerification res is on null');
    }
    return Future.value(isAdded);
  }

  Future<String> getWorkoutVerification({String date}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.getWorkoutVerification(date);
    log('url: $url');
    var res = await _netUtil.get(
      url,
      headers: mapHeader,
    );
    log('resp: $url -> $res');
    String isAdded = '';
    if (res != null && res['date'] != []) {
      isAdded = res['date']['uid'];
    }
    return await Future.value(isAdded);
  }

  Future<bool> workoutOtpVerification({Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.workoutOtpVerification();
    log('url: $url');
    var res = await _netUtil.post(
      url,
      body: body,
      headers: mapHeader,
    );
    bool isAdded = false;
    if (res != null) {
      isAdded = res['status'];
    }
    return Future.value(isAdded);
  }

  Future<bool> getTrailInfo({BuildContext context}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.getTrailInfo();
    log('url: $url');
    var res = await _netUtil.get(
      url,
      headers: mapHeader,
    );
    bool isAdded = false;
    if (res != null) {
      isAdded = res['status'];
    }
    return Future.value(isAdded);
  }

  Future<UpcomingEvents> getUpcomingEvents({BuildContext context}) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      String url = BASE_URL + Api.getUpcomingEvents();
      log('url: $url');
      var res = await _netUtil.get(
        url,
        headers: mapHeader,
      );
      print("response of Get upcoming events : " + res.toString());
      UpcomingEvents data;
      if (res != null)
        data = UpcomingEvents.fromJson(res);
      else
        data = UpcomingEvents(data: []);
      return data;
    } catch (e) {
      print('add member error: $e');
      return UpcomingEvents(data: []);
    }
  }

  Future<User> getUserById({BuildContext context, String id}) async {
    Map<String, String> mapHeader = Map();
    String url = BASE_URL + Api.getUserById(id);
    String token = locator<AppPrefs>().token.getValue();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var response = await _netUtil.get(
      url,
      headers: mapHeader,
    );
    User res;
    if (response != null) {
      res = User.fromJson(response);
    }
    return Future.value(res);
  }

  // Future<MemberDetails> getMemberById({BuildContext context, String id}) async {
  //   Map<String, String> mapHeader = Map();
  //   String url = BASE_URL + Api.getMemberById(id);
  //   String token = locator<AppPrefs>().token.getValue();
  //   mapHeader["Authorization"] = "Bearer " + token;
  //   mapHeader["Content-Type"] = "application/json";
  //   var response = await _netUtil.get(
  //     url,
  //     headers: mapHeader,
  //   );
  //   MemberDetails res;
  //   if (response != null && response['status']) {
  //     res = MemberDetails.fromJson(response);
  //   } else {
  //     res = MemberDetails(status: false);
  //   }
  //   return Future.value(res);
  // }

  Future<bool> shiftTrainer(
      {String gymId, String memberId, String newTrainer, String reason}) async {
    String url = BASE_URL + Api.shiftTrainer;
    String token = locator<AppPrefs>().token.getValue();
    log(url);
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil.post(url, headers: mapHeader, body: {
      "gym_id": "bXRnTjVCpJEZG",
      "member_id": "NKrzEMSfoevr4",
      "requested_trainer": newTrainer,
      "reason": reason
    }).then((value) {
      print(value);
      return value["status"];
    });
  }

  Future<bool> markDietAsConsumed({String dietId}) async {
    String url = BASE_URL + Api.markDietConsumed(dietId);
    String token = locator<AppPrefs>().token.getValue();
    log(url);
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.get(
      url,
      headers: mapHeader,
    );
    return res != null ? Future.value(res["status"]) : false;
  }

  Future<bool> addEventParticipation(
      {BuildContext context, Map<String, dynamic> body}) async {
    print('End Point of partial payment --- $body');
    String url = BASE_URL + Api.addEventParticipation;
    String token = locator<AppPrefs>().token.getValue();
    log(url);
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .post(
      url,
      headers: mapHeader,
      body: body,
    )
        .then((value) {
      print(value);
      return value["status"];
    });
  }

  Future<WhyChooseWtf> whyChooseWtf() async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      var res = await _netUtil.get(
        APIHelper.whyChooseWtf,
        headers: mapHeader,
      );
      print("response whyChooseWtf : " + res.toString());
      WhyChooseWtf data;
      if (res != null) data = WhyChooseWtf.fromJson(res);
      return data;
    } catch (e) {
      print('add member error: $e');
      return WhyChooseWtf(data: []);
    }
  }

  Future<GymAddOn> getLiveClasses({bool isLive = true}) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      var res = await _netUtil.get(
        APIHelper.getAllLiveClasses(isLive),
        headers: mapHeader,
      );
      print("response getAllLiveClasses : " + res.toString());
      GymAddOn data;
      if (res != null) data = GymAddOn.fromJson(res);
      return data;
    } catch (e) {
      print('getAllLiveClasses error: $e');
      return GymAddOn(data: []);
    }
  }

  Future<MemberSubscriptions> memberSubscription(String memberId) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      print('All Subscription url: ${APIHelper.memberSubscriptions(memberId)}');
      var res = await _netUtil.get(
        APIHelper.memberSubscriptions(memberId),
        headers: mapHeader,
      );
      print("response of Get Member Subscription : " + res.toString());
      MemberSubscriptions model;
      if (res != null) model = MemberSubscriptions.fromJson(res);
      return model;
    } catch (e) {
      print('Member Subscription error: $e');
      return MemberSubscriptions(data: [], status: false);
    }
  }

  Future<Response> updateProfile(
      {BuildContext context, File file, Map<String, String> body}) async {
    var streamedResponse;
    var multipartFile;
    MultipartRequest request;
    if (file != null) {
      var stream = ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var uri = Uri.parse(APIHelper.UPDATE_PROFILE);
      request = MultipartRequest("PUT", uri);
      File result;
      try {
        result = await FlutterNativeImage.compressImage(
          file.absolute.path,
          quality: 90,
        );
      } catch (e) {
        print('IMAGE COMPRESS EXCEPTION: $e');
        result = file;
      }
      multipartFile =
          MultipartFile('profile', stream, length, filename: result.path);
    } else {
      var uri = Uri.parse(APIHelper.UPDATE_PROFILE);
      request = MultipartRequest("PUT", uri);
    }
    //contentType: new MediaType('image', 'png'));
    if (file != null) request.files.add(multipartFile);

    if (body != null) request.fields.addAll(body);

    request.headers['Authorization'] =
        'Bearer ${locator<AppPrefs>().token.getValue()}';
    request.headers['Content-Type'] = 'application/json';

    streamedResponse = await request
        .send()
        .catchError((error) => print('upload Media Api Error: $error'));
    if (streamedResponse == null) {
      return null;
    }
    print('MEDIA RESPONSEEEE: ${await streamedResponse}');
    return await Response.fromStream(streamedResponse);
  }

  Future<bool> giveGymFeedback(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.post(
      APIHelper.giveFeedback,
      headers: mapHeader,
      body: body,
    );
    print("response giveGymFeedback : " + res.toString());
    return res['status'];
  }

  Future<dynamic> checkOffer({String offerId}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.get(
      APIHelper.checkOffer(offerId),
      headers: mapHeader,
    );
    print("response checkOffer : " + res.toString());
    return res;
  }

  Future<Map<String, dynamic>> joinLiveSession(
      {Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print('check live class body -- $body');
    var res = await _netUtil.post(
      APIHelper.joinLiveSession,
      headers: mapHeader,
      body: body,
    );
    print("joinLiveSession : " + res.toString());
    return res;
  }

  Future<Map<String, dynamic>> completeLiveSession(
      {Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = APIHelper.completeLiveSession;
    log('url--> $url  ---- >>> body:: $body');
    var res = await _netUtil.put(
      APIHelper.completeLiveSession,
      headers: mapHeader,
      body: body,
    );
    print("response checkOffer : " + res.toString());
    return res;
  }

  Future<ActiveSubscriptions> activeSubscription(String memberId) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      var res = await _netUtil.get(
        APIHelper.activeSubscriptions(memberId),
        headers: mapHeader,
      );
      print("response of Get Active Subscription : " + res.toString());
      ActiveSubscriptions model;
      if (res != null) model = ActiveSubscriptions.fromJson(res);
      return model;
    } catch (e) {
      print('Active Subscription error: $e');
      return ActiveSubscriptions(data: null, status: false);
    }
  }

  Future<GymOffers> getAllGymOffers(
      {BuildContext context, String gymId, String plan_uid}) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      var res = await _netUtil.get(
        APIHelper.allGymOffers(gymId, plan_uid),
        headers: mapHeader,
      );
      print("response getAllGymOffers : " + res.toString());
      GymOffers offers;
      if (res != null) offers = GymOffers.fromJson(res);
      return Future.value(offers);
    } catch (e) {
      print('Update Profile error: $e');
      return GymOffers(
        status: false,
        data: [],
      );
    }
  }

  //get Gym Details
  ///@Gaurav
  Future<GymDetailsModel> getGymDetails(String gymID) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.get(BASE_URL + Api.GYM_DETAILS + gymID,
        headers: mapHeader);
    print("response of Get GYM DETAILS : " + res.toString());
    // print('ben---- ${res['gallery']}');
    GymDetailsModel model;
    if (res != null) model = GymDetailsModel.fromJson(res);
    return model;
  }

  //Get gym By Id
  Future<GymDetailsModel> getGymById(
      {String gymID, String lat, String lng}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.get(
        BASE_URL + Api.getGymDetailsById(gymId: gymID, lat: lat, lng: lng),
        headers: mapHeader);
    print("response of Get GYM DETAILS : " + res.toString());
    // print('ben---- ${res['gallery']}');
    GymDetailsModel model;
    if (res != null) model = GymDetailsModel.fromJson(res);
    return model;
  }

  ///Manmohan
  Future<AllEvents> getAllEvents() async {
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    String token = locator<AppPrefs>().token.getValue();
    print('this is token --- $token');
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil //https://devapi.wtfup.me/event?type=new
        .get(BASE_URL + Api.EVENTS, headers: mapHeader)
        .then((dynamic res) {
      log("response of Get ALL Events : " + res.toString());
      AllEvents model = res != null
          ? AllEvents.fromJson(res)
          : AllEvents(
              data: [],
            );
      return model;
    });
  }

  ///By bensal
  Future<MyWorkoutSchedule> getMyWorkoutSchedule(
      {String date, String addonId, String subscriptionId}) async {
    // print(locator<AppPrefs>().token.getValue());
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    mapHeader["Authorization"] = "Bearer " + token;
    String url =
        BASE_URL + Api.myWorkoutSchedule(date, addonId, subscriptionId);
    print('base url workout --- $url');
    var res = await _netUtil.get(url, headers: mapHeader);
    print('resp getMyWorkoutSchedule: $res');
    return MyWorkoutSchedule.fromJson(res);
  }

  Future<MySchedule> getMySchedule({date}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    mapHeader["Authorization"] = "Bearer " + token;
    String url = BASE_URL +
        Api.mySchedule(
          locator<AppPrefs>().memberId.getValue(),
          date,
        );
    print('cehck schedule base url -- $url');
    var res = await _netUtil.get(url, headers: mapHeader);

    print('resp my schedule: ${res.toString}');
    return res != null && res['status']
        ? MySchedule.fromJson(res)
        : MySchedule(
            data: ScheduleData(
              addon: [],
              addonPt: [],
              allData: {},
              event: [],
              regular: [],
              addonLive: [],
            ),
          );
  }

  Future<AllDiets> getMyDietSchedule({userId, date}) async {
    // print(locator<AppPrefs>().token.getValue());
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    mapHeader["Authorization"] = "Bearer " + token;
    String url = BASE_URL +
        Api.dietSchedule(
          userId,
          date,
        );
    var res = await _netUtil.get(url, headers: mapHeader);
    print('resp getMyDietSchedule: $res');
    return Future.value(
      res != null && res['status']
          ? AllDiets.fromJson(res)
          : AllDiets(
              data: [],
            ),
    );
  }

  Future<WorkoutDetailModel> getWorkoutDetail({id}) async {
    String url = BASE_URL + Api.workoutDetail(id);
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    mapHeader["Authorization"] = "Bearer " + token;
    return _netUtil.get(url, headers: mapHeader).then((value) {
      print(value);
      return WorkoutDetailModel.fromJson(value);
    });
  }

  Future<bool> updateTime({id, time}) async {
    String url = BASE_URL + Api.updateTime;
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    mapHeader["Authorization"] = "Bearer " + token;
    Map<dynamic, dynamic> body = {
      "uid": id,
      "status": "done",
      "e_duration": time
    };
    print('body exercise --: $body');
    return _netUtil
        .put(
      url,
      headers: mapHeader,
      body: body,
    )
        .then((value) {
      print(value);
      return value["status"];
    });
  }

  Future<EventsData> getEventById(String eventId) async {
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.getEventById(eventId), headers: mapHeader)
        .then((dynamic res) {
      print("response of Get Events by id : " + res.toString());
      EventsData model = res.containsKey('data')
          ? EventsData.fromJson(res['data'])
          : EventsData.fromJson(res['message']);
      return model;
    });
  }

  Future<WorkoutComplete> getWorkoutCalculation(
      {BuildContext context, Map<String, dynamic> body}) async {
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.post(
      BASE_URL + Api.getWorkoutCalculations,
      headers: mapHeader,
      body: body,
    );
    print("response getWorkoutCalculation : " + res.toString());
    WorkoutComplete complete = WorkoutComplete.fromJson(res);
    return complete;
  }

  Future<GymTypes> getDiscoverNow({String type, String lat, String lng}) async {
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print('checking type of gym : $type');
    String finalUrl = Api.getNearByGym(lat, lng, type);
    print('complete url --- $finalUrl');
    return _netUtil
        .get(BASE_URL + finalUrl, headers: mapHeader)
        .then((dynamic res) {
      print("response get nearBy Gym : " + res.toString());
      GymTypes model = res != null && res['status']
          ? GymTypes.fromJson(res)
          : GymTypes(
              data: [],
            );
      return model;
    });
  }

  Future<AddOnSlotDetails> getSlotDetails({
    BuildContext context,
    String addOnId,
    String date,
    String trainerId,
    String gymId,
  }) async {
    String token = locator<AppPrefs>().token.getValue();
    print("get Gym Slot details 3");
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print("get Gym Slot details 4");
    String url = trainerId != null && trainerId.isNotEmpty
        ? BASE_URL + Api.slotDetails(date, trainerId, gymId)
        : BASE_URL + Api.slotDetails2(date, gymId);
    print('url: $url');
    var res =
        await _netUtil.post(url, headers: mapHeader, body: {'uid': addOnId});
    print("get Gym Slot details 5");
    print("response of Get Gym Slot details : " + res.toString());
    print("get Gym Slot details 6");
    AddOnSlotDetails model;
    if (res != null) model = AddOnSlotDetails.fromJson(res);
    return Future.value(model);
  }

  ///Manmohan
  Future<int> checkGymSubscription(
      {BuildContext context, String userId, String gymId}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.checkSubscription(userId, gymId);
    print('url: $url');
    return _netUtil
        .get(
      url,
      headers: mapHeader,
    )
        .then((dynamic res) {
      log(res.toString());
      print('check subscription available --- ${res.toString()}');
      return Future.value(res['status'] == true ? 1 : 0);
    });
  }

  Future<CheckEventParticipation> checkEventSubscription(
      {BuildContext context, String eventId}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.checkParticipation(eventId);
    print('url: $url');
    var res = await _netUtil.get(
      url,
      headers: mapHeader,
    );
    CheckEventParticipation val;
    if (res != null && res.containsKey('data')) {
      val = CheckEventParticipation.fromJson(res);
    } else {
      val = CheckEventParticipation(status: false);
    }
    return Future.value(val);
  }

  //TODO check slot availablity :D
  Future<dynamic> checkSlotAvailability(
      {BuildContext context, String slotId}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.checkSlotAvailability(slotId);
    print('url: $url');
    return _netUtil
        .get(
      url,
      headers: mapHeader,
    )
        .then((dynamic res) {
      log('checkSlotAvailability resp:   ' + res.toString());
      return Future.value(res);
    });
  }

  Future<bool> eventCheckIn(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.eventCheckIn();
    print('url: $url');
    print('body: $body');
    var res = await _netUtil.post(
      url,
      body: body,
      headers: mapHeader,
    );
    log(res.toString());

    return Future.value(res['status'] ?? false);
  }

  Future<String> generateRazorPayId(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print("get generateRazorPayId 4");
    print('check razor pay body datat --- $body');
    String url = BASE_URL + Api.generateRazorpayId();
    print('url: $url');
    print('body: $body');
    return _netUtil
        .post(
      url,
      body: body,
      headers: mapHeader,
    )
        .then((dynamic res) {
      log(res.toString());
      print("response of generateRazorPayId : " + res.toString());
      return Future.value(res['data']['order_id'] ?? '');
    });
  }

  Future<VerifyPayment> verifyRazorPayPayment(
      {Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.verifyRazorPayPayment();
    print('url: $url');
    print('body: $body');
    return _netUtil
        .post(
      url,
      body: body,
      headers: mapHeader,
    )
        .then((dynamic res) {
      log(res.toString());
      print("response of verifyRazorPayPayment : " + res.toString());
      VerifyPayment model = VerifyPayment.fromJson(res);
      return Future.value(
        model ??
            VerifyPayment(
              data: null,
              status: false,
            ),
      );
    });
  }

  Future<AllNotifications> getNotifications(
      {BuildContext context, String type}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.notification(type);
    print('url: $url');
    return _netUtil
        .get(
      url,
      headers: mapHeader,
    )
        .then((dynamic res) {
      log(res.toString());
      print("response of Get ALL Notifications : " + res.toString());
      AllNotifications model = AllNotifications.fromJson(res);
      return model;
    });
  }

  Future<Stats> getStats({BuildContext context}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print("get getBodyStats 4");
    String url = BASE_URL + Api.getStats();
    print('url: $url');
    return _netUtil
        .get(
      url,
      headers: mapHeader,
    )
        .then((dynamic res) {
      log(res.toString());
      print("response of getBodyStats : " + res.toString());
      Stats model = Stats.fromJson(res);

      return model;
    });
  }

  ///Manmohan
  Future<GymAddOn> getAddOnForGym(String gymId) async {
    String token = locator<AppPrefs>().token.getValue();
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    print("get Gym AdsOns 3 $gymId");
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.gymAddOn(gymId), headers: mapHeader)
        .then((dynamic res) {
      print("response getAddOnForGym : " + res.toString());
      GymAddOn model = res != null && res['status']
          ? GymAddOn.fromJson(res)
          : GymAddOn(
              data: [],
            );

      return model;
    });
  }

  Future<CurrentTrainer> getCurrentTrainer() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.getCurrentTrainer(), headers: mapHeader)
        .then((dynamic res) {
      print("response of Get CURRENT TRAINER : " + res.toString());
      CurrentTrainer model = CurrentTrainer.fromJson(res);

      return model;
    });
  }

  // Search Gym
  Future<GymSearchModel> searchGym(
      {String name, String lat, String lng}) async {
    String token = locator<AppPrefs>().token.getValue();

    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.SEARCH_GYM(lat: lat, lng: lng, query: name),
            headers: mapHeader)
        .then((dynamic res) {
      print(res.toString());
      return GymSearchModel.fromJson(res);
    });
  }

  Future<GymPlanModel> getGymPlans({BuildContext context, String gymId}) async {
    String token = locator<AppPrefs>().token.getValue();
    String url = BASE_URL + Api.GET_GYM_PLAN;
    print('Apli String --- ${url + gymId}');
    var headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = jsonEncode({"gym_id": "$gymId"});
    return _netUtil
        .postJsonBody(url, headers: headers, body: body)
        .then((dynamic res) {
      print("response of Get gym Plan : " + res.toString());
      GymPlanModel model = GymPlanModel.fromJson(res);
      return model;
    });
  }

  Future<GymSlotModel> getGymSlot(String gymId) async {
    print("get Gym Slot 2");
    String token = locator<AppPrefs>().token.getValue();
    print("get Gym Slot 3");
    String url = BASE_URL + Api.GET_GYM_SLOT + "1ycRrOm5RCI3p";
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    return _netUtil.get(url, headers: mapHeader).then((dynamic res) {
      print("response of Get gym Slot : " + res.toString());
      GymSlotModel model = GymSlotModel.fromJson(res);
      return model;
    });
  }

  // Search Gym
  Future<CommonModel> addSubscritpion(Map<String, dynamic> body) async {
    print('add sub map -- $body');
    String token = locator<AppPrefs>().token.getValue();
    var headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    print(BASE_URL + Api.ADD_SUBSCRIPTION);

    var res = await _netUtil.postJsonBody(
      BASE_URL + Api.ADD_SUBSCRIPTION,
      headers: headers,
      body: json.encode(body),
    );
    print('Add subscription response --- $res');
    CommonModel model = CommonModel.fromJson(res);
    return model;
  }

  //get wtf coin balance

  Future<CoinBalance> getWTFCoinBalance() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.getWTFCoinBalance(), headers: mapHeader)
        .then((dynamic res) {
      print("response of Get CURRENT WTF Balance : " + res.toString());
      CoinBalance model = CoinBalance.fromJson(res);

      return model;
    });
  }

  //get wtf shopping Categories
  Future<ShoppingCategories> getShoppingCategories() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.getShoppingCategories(), headers: mapHeader)
        .then((dynamic res) {
      print("response of Shopping Categories : " + res.toString());
      ShoppingCategories model = ShoppingCategories.fromJson(res);
      return model;
    });
  }

  //get wtf shopping Categories
  Future<Offers> getOffers(String keywords) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.getOffers(keywords), headers: mapHeader)
        .then((dynamic res) {
      print("response of Shopping Offers : " + res.toString());
      Offers model = Offers.fromJson(res);
      return model;
    });
  }

  //redeem coin
  Future<dynamic> redeemCoin(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.post(
      BASE_URL + Api.saveRedeemCoin(),
      headers: mapHeader,
      body: body,
    );
    log(body.toString());

    print("response getWorkoutCalculation : " + res.toString());
    dynamic complete = res;
    return complete;
  }

  //get coin History
  Future<CoinHistory> getCoinHistory() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.getCoinHistory(), headers: mapHeader)
        .then((dynamic res) {
      print("response of Coin History : " + res.toString());
      CoinHistory model = CoinHistory.fromJson(res);
      return model;
    });
  }

  //get redeem History
  Future<RedeemHistory> getRedeemHistory() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print('URL::_> ${Api.getRedeemHistory()}');
    var res = await _netUtil.get(BASE_URL + Api.getRedeemHistory(),
        headers: mapHeader);
    print("response of Redeem History : " + res.toString());
    RedeemHistory model = RedeemHistory.fromJson(res);
    return model;
  }

  //get diet pref
  Future<DietPref> getDietPref(String type) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    return _netUtil
        .get(BASE_URL + Api.dietPref(type), headers: mapHeader)
        .then((dynamic res) {
      print("response of pref : " + res.toString());
      DietPref model = DietPref.fromJson(res);
      return model;
    });
  }

  //get diet pref
  Future<DietItem> getDietCat(
      String day, String date, String diet_cat_id) async {
    print('check diet cat id --  web -- $diet_cat_id');

    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print('check diet cat date : day $day date $date cat id $diet_cat_id');
    print(
        'check diet url : ${BASE_URL + Api.getDietCat(day, date, diet_cat_id)}');
    return _netUtil
        .get(BASE_URL + Api.getDietCat(day, date, diet_cat_id),
            headers: mapHeader)
        .then((dynamic res) {
      print("response of getDietCat : " + res.toString());
      DietItem model;
      if (res['status']) {
        model = DietItem.fromJson(res);
      } else {
        model = DietItem();
      }
      return model;
    });
  }

  //diet consumption
  Future<dynamic> dietConsumtion(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.post(
      BASE_URL + Api.DIET_CONSUMPTION,
      headers: mapHeader,
      body: body,
    );
    //  log(body.toString());

    print("response get Consumption : " + res.toString());
    dynamic complete = res;
    return complete;
  }

  Future<dynamic> eventSubmissionAdd(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.post(
      BASE_URL + Api.eventSubmissionAdd(),
      headers: mapHeader,
      body: body,
    );
    //  log(body.toString());

    print("response get Consumption : " + res.toString());
    dynamic complete = res;
    return complete;
  }

  Future<dynamic> eventSubmissionUpdate(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.put(
      BASE_URL + Api.eventSubmissionUpdate(),
      headers: mapHeader,
      body: body,
    );
    //  log(body.toString());

    print("response get Consumption : " + res.toString());
    dynamic complete = res;
    return complete;
  }

  //diet consumed
  Future<EventSubmissions> getEventSubmissions({
    BuildContext context,
    String eventId,
  }) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.get(
      BASE_URL + Api.getEventSubmission(eventId),
      headers: mapHeader,
    );
    EventSubmissions complete;
    print("response getEventSubmissions : " + res.toString());
    if (res != null) {
      complete = EventSubmissions.fromJson(res);
    } else {
      complete = null;
    }
    return complete;
  }

  Future<DietConsumed> dietConsumed({BuildContext context, String date}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.get(
      BASE_URL + Api.getConsumedDiet(date),
      headers: mapHeader,
    );
    DietConsumed complete;
    print("response get diet consumed : " + res.toString());
    if (res != null) {
      complete = DietConsumed.fromJson(res);
    } else {
      complete = null;
    }

    return complete;
  }

  //diet consumption
  Future<dynamic> dietRewards(
      {BuildContext context, Map<String, dynamic> body}) async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.post(
      BASE_URL + Api.COLLETC_DIET_REWARDS,
      headers: mapHeader,
      body: body,
    );
    log(body.toString());

    print("response get Consumption : " + res.toString());
    dynamic complete = res;
    return complete;
  }

  //Get All Diet category
  Future<List<DietModel>> getAllDietsCategory() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    List<DietModel> model;
    var res = await _netUtil
        .get(BASE_URL + Api.getAllDietDetails(), headers: mapHeader)
        .then((dynamic res) {
      if (res['status']) {
        model = (res['data'] as List)
            .map((p) => DietModel.fromJson(data: p))
            .toList();
      } else {
        model = [];
      }
    });
    return model;
  }

  Future<void> getDietPlans() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil
        .get(BASE_URL + Api.getDietPlan(), headers: mapHeader)
        .then((dynamic res) {
      if (res['status']) {
        // model = (res['data'] as List)
        //     .map((p) => DietModel.fromJson(data: p))
        //     .toList();
        print('Diet plans --- ${res}');
      } else {
        // model = [];
      }
    });
  }

  Future<ForceUpdateModel> getForceUpdate() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";

    ForceUpdateModel model;
    var res =
        await _netUtil.get(BASE_URL + Api.getForceUpdate(), headers: mapHeader);
    if (res['status']) {
      print('Force Update Response --- $res');
      // model = (res['data'] as List)
      //     .map((p) => DietModel.fromJson(data: p))
      //     .toList();
      model = ForceUpdateModel.fromJson(res['data'][0]);
      return model;
    } else {
      return null;
    }
  }

  Future<bool> sendGymOwnerOtp({@required String gymId}) async {
    //GLKdIYAWDS2Q8
    try {
      String token = locator<AppPrefs>().token.getValue();
      // String userId = locator<AppPrefs>().userData.key;
      String userId = locator<AppPrefs>().memberId.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";

      print('User Id -- $userId gym id - $gymId');

      var res = await _netUtil.post(
        BASE_URL + Api.sendOtpToGymOwner(),
        body: {"user_id": "$userId", "gym_id": "$gymId"},
        headers: mapHeader,
      );
      print("response send otp : " + res.toString());
      if (res != null)
        return true;
      else
        return false;
    } catch (e) {
      print('add member error: $e');
      return false;
    }
  }

  Future<bool> verifyGymOwnerOtp(
      {@required String gymId, @required String otp}) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      String userId = locator<AppPrefs>().memberId.getValue();
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";
      var res = await _netUtil.get(
          BASE_URL +
              Api.verifyOtpToGymOwner(gymId: gymId, otp: otp, userId: userId),
          headers: mapHeader);
      if (res['status']) {
        print('Verify otp response --- ${res}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('add member error: $e');
      return false;
    }
  }

  // Future<Map<String, dynamic>> addMember(Map<String, dynamic> body) async {
  //   print('adding member : $body');
  //   try {
  //     String token = locator<AppPrefs>().token.getValue();
  //     Map<String, String> mapHeader = Map();
  //     mapHeader["Authorization"] = "Bearer " + token;
  //     mapHeader["Content-Type"] = "application/json";
  //     var res = await _netUtil.post(
  //       APIHelper.ADD_MEMBER,
  //       body: body,
  //       headers: mapHeader,
  //     );
  //     print("response addMember : " + res.toString());
  //     return res;
  //   } catch (e) {
  //     print('add member error: $e');
  //     return {};
  //   }
  // }
  Future<bool> addMember(Map<String, dynamic> data) async {
    data['user_id'] = locator<AppPrefs>().memberId.getValue();
    print('response from add member data : $data');
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = APIHelper.ADD_MEMBER;
    log('url: $url');
    var res = await _netUtil.post(
      url,
      body: data,
      headers: mapHeader,
    );
    print('response from add member : $res');
    if (res != null) {
      print('response called not null ${res['status']}');
      return res['status'];
    } else {
      print('response called null');
      return false;
    }
  }

  Future<bool> updateMember(Map<String, dynamic> body) async {
    print('response from update member data : $body');
    String url = APIHelper.updateMember;
    print('adding member : $url');
    try {
      String token = locator<AppPrefs>().token.getValue();

      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + token;
      mapHeader["Content-Type"] = "application/json";

      var res = await _netUtil.put(
        url,
        body: body,
        headers: mapHeader,
      );

      print('response from update member : $res');
      return res['status'];
    } catch (e) {
      print('update member error: $e');
      return false;
    }

  }

  Future<PreambleModel> getMemberById() async {
    String memberId = locator<AppPrefs>().memberId.getValue();
    print('checking member id : --- $memberId');
    Map<String, String> mapHeader = Map();
    String url = BASE_URL + Api.getMemberById(memberId);
    String token = locator<AppPrefs>().token.getValue();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var response = await _netUtil.get(
      url,
      headers: mapHeader,
    );
    print('get member by id response - : $response');
    PreambleModel res;
    if (response != null && response['status']) {
      print('response not nul called');
      res = PreambleModel.fromJson(response['data']);
      res.hasData = response['status'];
      print('check model data --- ${PreambleModel().toJsonMember(res)}');
    } else {
      print('response nul called');
      res = new PreambleModel();
      res.hasData = false;
    }
    return Future.value(res);
  }

  Future<bool> saveBmrProgress({Map<String, dynamic> body}) async {
    print('save bmr body --- $body');
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.saveBmrProgress();
    log('url: $url');
    var res = await _netUtil.post(
      url,
      body: body,
      headers: mapHeader,
    );
    bool isAdded = false;
    if (res != null) {
      isAdded = res['status'];
    }
    return Future.value(isAdded);
  }

  Future<bool> updatePreamble(Map<String, dynamic> data) async {
    data['user_id'] = locator<AppPrefs>().memberId.getValue();
    String token = locator<AppPrefs>().token.getValue();
    print('checking data : - $data');
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String url = BASE_URL + Api.saveBmrProgress();
    log('url: $url');
    var res = await _netUtil.post(
      url,
      body: data,
      headers: mapHeader,
    );
    print('response called not nulls $res');
    if (res != null) {
      print('response called not null ${res['status']}');
      return res['status'];
    } else {
      print('response called null');
      return false;
    }
  }

  Future<void> getLastSeen() async {
    String userId = locator<AppPrefs>().memberId.getValue();
    print('checking member id : --- $userId');

    String url = BASE_URL + Api.getLastSeen();
    print('cehck get last seen url - $url');

    String token = locator<AppPrefs>().token.getValue();

    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    var res = await _netUtil.post(
      url,
      body: {"user_id": "$userId"},
      headers: mapHeader,
    );
    // print('get member  by id  response - : $response');
    // PreambleModel res;
    // if (response != null && response['status']) {
    //   print('response not nul called');
    //   res = PreambleModel.fromJson(response['data']);
    //   res.hasData = response['status'];
    //   print('check model data --- ${PreambleModel().toJsonMember(res)}');
    // } else {
    //   print('response nul called');
    //   res = new PreambleModel();
    //   res.hasData = false;
    // }
    print('last seen response -- $res');
    return true;
  }

  Future<List<AddonsCatModel>> getAddonsCat() async {
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";

    var res =
        await _netUtil.get(BASE_URL + Api.getAddonsCat(), headers: mapHeader);
    print('get addons cat response --- $res');
    if (res['status']) {
      print('get addons cat response --- true --- $res');
      var model = List<AddonsCatModel>.from(
          res["data"].map((x) => AddonsCatModel.fromJsonToModel(x)));
      print(
          'get addons cat response --- list length --- ${model.length ?? 'no List Found'}');
      return model;
    } else {
      return null;
    }
  }

  Future<GymTypes> getNearestCatGym({@required String cat_id}) async {
    String token = locator<AppPrefs>().token.getValue();
    String lat = locator<AppPrefs>().lat.getValue();
    String lng = locator<AppPrefs>().lng.getValue();

    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String finalUrl = Api.getNearestCatGym(lat: lat, lng: lng, cat_id: cat_id);
    return _netUtil
        .get(BASE_URL + finalUrl, headers: mapHeader)
        .then((dynamic res) {
      print("response get nearBy Gym : " + res.toString());
      GymTypes model = res != null && res['status']
          ? GymTypes.fromJson(res)
          : GymTypes(
              data: [],
            );
      return model;
    });
  }

  Future<List<GymCatModel>> getGymCat() async {
    String token = locator<AppPrefs>().token.getValue();
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String finalUrl = Api.getGymCat();
    var res = await _netUtil.get(BASE_URL + finalUrl, headers: mapHeader);
    print('get gym cat response --- $res');

    if (res['status']) {
      print('get gym cat response --- true --- $res');
      var model = List<GymCatModel>.from(
          res["data"].map((x) => GymCatModel.fromJsonToModel(x)));
      print(
          'get gym cat response --- list length --- ${model.length ?? 'no List Found'}');
      return model;
    } else {
      return null;
    }
  }

  Future<AddOnSlotDetails> getAddOnsCatGymSlots(
      {@required String date, @required String addon_uid}) async {
    String token = locator<AppPrefs>().token.getValue();
    print("get Gym Slot details 3");
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    print("get Gym Slot details 4");
    String url = BASE_URL + Api.getAddOnsGymsSlots(date: date);
    print('url: $url');
    var res =
        await _netUtil.post(url, headers: mapHeader, body: {'uid': addon_uid});
    print("get Gym Slot details 5");
    print("response of Get Gym Slot details : " + res.toString());
    print("get Gym Slot details 6");
    AddOnSlotDetails model;
    if (res != null) model = AddOnSlotDetails.fromJson(res);
    return Future.value(model);
  }

  Future<GymTypes> getCatNearByGymsList(
      {String lat, String lng, String cat_id}) async {
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    String token = locator<AppPrefs>().token.getValue();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";
    String finalUrl = Api.getCatNearByGym(lat, lng, cat_id);
    return _netUtil
        .get(BASE_URL + finalUrl, headers: mapHeader)
        .then((dynamic res) {
      print("response get cat nearBy Gym list : " + res.toString());
      GymTypes model = res != null && res['status']
          ? GymTypes.fromJson(res)
          : GymTypes(
              data: [],
            );
      return model;
    });
  }

  Future<PartialPaymentModel> getPartialPaymentStatus(
      {@required String subscription_id}) async {
    // String userId = SharedPref.pref.getString(Preferences.USER_ID);
    String token = locator<AppPrefs>().token.getValue();
    String memberId = locator<AppPrefs>().memberId.getValue();

    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";

    String finalUrl = Api.getPartialPaymentStatus(subscription_id: subscription_id,userId:memberId);
    return _netUtil
        .get(BASE_URL + finalUrl, headers: mapHeader)
        .then((dynamic res) {
      print("response get partial payment list : " + res.toString());
      PartialPaymentModel model = res != null && res['status']
          ? PartialPaymentModel.fromJson(res)
          : PartialPaymentModel(
        status: false,
        data: [],
      );
      return model;
    });
  }

  Future<bool> updatePartialPayment({@required Map<String,dynamic> body})async{
    String token = locator<AppPrefs>().token.getValue();
    print('check partial update payment body --- $body');

    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + token;
    mapHeader["Content-Type"] = "application/json";

    String url = BASE_URL + Api.getUpdatePartialPayment();
    print('check partial payment update base url : $url');
    var res =
        await _netUtil.put(url, headers: mapHeader, body: body);

    print('check partial payment update response --- $res');
   return true;
  }


}
