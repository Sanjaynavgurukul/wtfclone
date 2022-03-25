import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wtf/controller/bases.dart';
import 'package:wtf/helper/social_auth_services.dart';

import '../main.dart';
import 'AppPrefs.dart';
import 'api_constants.dart';

class APIHelper {
  static const String BASE_URL = 'https://devapi.wtfup.me/';
  // static const String BASE_URL = 'https://api.wtfup.me/';
  // static const String DEV_BASE_URL =c 'https://devapi.wtfup.me/';
  // static const String BASE_URL = 'http://13.232.102.139:9000/';

  static const String SEND_OTP = BASE_URL + 'user/mobile/otp';
  static String sendOtpLogin() => BASE_URL + 'user/mobile/otp?type=login';
  static const String LOGIN = BASE_URL + 'user/mobile/login';
  static const String LOGIN_EMAIL = BASE_URL + 'user/login';
  static const String CREATE_ACCOUNT = BASE_URL + 'user/mobile/signup';
  static const String ADD_MEMBER = BASE_URL + 'member/add';
  static const String updateMember = BASE_URL + 'member/update';
  static const String whyChooseWtf = BASE_URL + 'terms';
  static String getAllLiveClasses(bool isLive) =>
      BASE_URL + 'addon?is_live=$isLive';
  static const String FORGOT_PASSWORD = BASE_URL + 'user/forgot';
  static const String RESET_PASSWORD = BASE_URL + 'user/reset';
  static const String GET_GYM = BASE_URL + 'gym/';
  static const String SEARCH_GYM = BASE_URL + 'gym/search';
  static const String GYM_DETAILS = BASE_URL + 'gym/id/';
  static const String UPDATE_PROFILE = BASE_URL + 'user/update';
  static const String SOCIAL_LOGIN = BASE_URL + 'user/social/login';
  static const String SOCIAL_SIGNUP = BASE_URL + 'user/social/signup';
  static const String ATTENDANCE = BASE_URL + 'attandance/add';
  static const String BANNER = BASE_URL + 'banner';
  static const String giveFeedback = BASE_URL + 'feedback/add';
  static const String joinLiveSession = BASE_URL + 'liveparticipant/add';
  static const String completeLiveSession =
      BASE_URL + 'liveparticipant/complete';
  static String checkOffer(String offerId) =>
      BASE_URL +
      'offervalidation?user_id=${locator<AppPrefs>().memberId.getValue()}&offer_id=$offerId';
  static String allGymOffers(String gymId,String plan_uid) => BASE_URL + 'offer/?gym_id=$gymId&type_id=$plan_uid';
  static String allSessionForAddOn(String addOnId) =>
      BASE_URL + 'session/addon?addon=$addOnId';
  static String memberSubscriptions(String memberId) =>
      BASE_URL + 'subscription/member?member_id=$memberId';
  static String activeSubscriptions(String memberId) =>
      BASE_URL + 'subscription/member?member_id=$memberId&type=regular';

  //send otp
  static Future<Response> sendOtp(dynamic body, String type) async {
    try {
      print("Send OTP 4");
      var response = await http.post(
          type.isNotEmpty ? Uri.parse(sendOtpLogin()) : Uri.parse(SEND_OTP),
          body: body,
          headers: {"Content-Type": "application/json"});
      print("Send OTP 5");
      print(
          "sendOtp : ${type.isNotEmpty ? Uri.parse(sendOtpLogin()) : Uri.parse(SEND_OTP)}");
      print("body : " + body);
      print("response : ${response.body}");
      return response;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  static Future<ResponseData> getCoupon(String coupon,String plan_type) async {
    try {
      return fetchData(
        addToken: true,
        queryParams: 'code=$coupon',
        url: BASE_URL + Api.checkCoupon(coupon: coupon,plan_type: plan_type),
      ).then((value) {
        if (value['status'] is bool) {
          return ResponseData(
              data: value['data'],
              message: value['message'],
              isSuccessed: value['status']);
        } else {
          return ResponseData(isSuccessed: false);
        }
      });
    } catch (e) {
      //print(e.message);
      print('safksfksfksafbafkb');
      return ResponseData(isSuccessed: false);
    }
  }

  //login
  static Future<http.Response> userLogin(dynamic body) async {
    try {
      var response = await http.post(Uri.parse(LOGIN),
          body: body, headers: {"Content-Type": "application/json"});
      print("login : $LOGIN");
      print("body : " + body);
      print("response : ${response.body}");
      return response;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  static Future<http.Response> userLoginEmail(dynamic body) async {
    try {
      var response = await http.post(Uri.parse(LOGIN_EMAIL),
          body: body, headers: {"Content-Type": "application/json"});
      print("login : $LOGIN_EMAIL");
      print("body : " + body);
      print("response : ${response.body}");
      return response;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  //register
  static Future<http.Response> createAccount(dynamic body) async {
    try {
      var response = await http.post(Uri.parse(CREATE_ACCOUNT),
          body: body, headers: {"Content-Type": "application/json"});
      print("createAccount : $CREATE_ACCOUNT");
      print("body : " + body);
      print("response : ${response.body}");
      return response;
    } catch (e) {
      return null;
    }
  }

  //add member

  //forgot password
  /// author Gaurav
  static Future<dynamic> forgotPassword(dynamic body) async {
    try {
      var response = await http.post(Uri.parse(FORGOT_PASSWORD),
          body: body, headers: {"Content-Type": "application/json"});
      print("forgotPassword : $FORGOT_PASSWORD");
      print("body : " + body);
      print("response : ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      print(e.message);
      return e.message;
    }
  }

  /// reset password
  /// author Gaurav
  static Future<dynamic> resetPassword(dynamic body) async {
    try {
      var response = await http.put(Uri.parse(RESET_PASSWORD),
          body: body, headers: {"Content-Type": "application/json"});

      print("resetPassword : $RESET_PASSWORD");
      print("body : " + body);
      print("response : ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      print("resetPassword error message" + e.message);
      return e.message;
    }
  }

  /// get Gyms
  /// author Gaurav
  static Future<dynamic> getGyms() async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      print("token : " + token);
      var response = await http.get(Uri.parse(GET_GYM), headers: {
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });

      print("GET GYM : $RESET_PASSWORD");
      print("token : " + token);
      print("response : ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      print("Get Gym error message" + e.message);
      return e.message;
    }
  }

  /// Search Gyms
  /// author Gaurav
  static Future<dynamic> searchGyms(dynamic body) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      print("token : " + token);
      var response = await http.post(Uri.parse(SEARCH_GYM),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: body);

      print("GET GYM : $SEARCH_GYM");
      print("body : " + body);
      print("response : ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      print("Get Gym error message" + e.message);
      return e.message;
    }
  }

  /// get Gym Details by ID
  /// author Gaurav
  static Future<dynamic> getGymDetailsById(String gymId) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      print("token : " + token);
      var response = await http.get(
        Uri.parse(GYM_DETAILS + gymId),
        headers: {
          // "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      print("GET GYM Details : ${GYM_DETAILS + gymId}");
      print("token : " + token);
      print("response : ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      print("Get Gym error message" + e.message);
      return e.message;
    }
  }

  static Future<dynamic> getGymDetails(String gymId) async {
    try {
      String token = locator<AppPrefs>().token.getValue();
      print("token : " + token);
      var response = await http.get(
        Uri.parse(BASE_URL + "gym/getbyid?uid=$gymId"),
        headers: {
          // "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      print("GET GYM Details : ${GYM_DETAILS + gymId}");
      print("token : " + token);
      log("response : ${response.body}");
      return json.decode(response.body);
    } catch (e) {
      print("Get Gym error message" + e.message);
      return e.message;
    }
  }

  static Future<ApiResponse> socialSignin(Map body) {
    return ApiResponse.call(
        request: postData(
      addToken: false,
      url: SOCIAL_LOGIN,
      body: body,
    ));
  }

  static Future<ApiResponse> socialSignup(Map body) {
    return ApiResponse.call(
        request: postData(
      addToken: false,
      url: SOCIAL_SIGNUP,
      body: body,
    ));
  }

  static Future<ApiResponse> postAttendance(Map body) {
    return ApiResponse.call(
        request: postData(
      addToken: false,
      url: ATTENDANCE,
      body: body,
    ));
  }

  static Future<ApiResponse> banner() {
    return ApiResponse.call(
        request: fetchData(
      addToken: true,
      url: BANNER,
    ));
  }
}
//8650066595