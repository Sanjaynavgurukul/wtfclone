import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/api_helper.dart';
import 'package:wtf/helper/firebase_cloud_messaging_wapper.dart';
import 'package:wtf/helper/social_auth_services.dart';

import '../main.dart';
import 'bases.dart';

class AuthController extends ChangeNotifier {
  bool loading = false;
  String registerMethod;
  bool get isLoading => loading;

  Future<Response> sendOtp(String number, {String type = ''}) async {
    print("Send OTP 1");
    loading = true;
    notifyListeners();
    print("Send OTP 2");
    var body = json.encode({"mobile": "$number"});
    print("Send OTP 3");

    return APIHelper.sendOtp(body, type).then((res) {
      loading = false;
      notifyListeners();
      return res;
    });
  }

  Future<Response> userLogin(
      BuildContext context, String mobile, String otp) async {
    loading = true;
    notifyListeners();
    var body = json.encode({
      'mobile': mobile,
      'otp': otp,
      'n_token': locator<AppPrefs>().fcmToken.getValue()
    });

    return APIHelper.userLogin(body).then((res) {
      loading = false;
      notifyListeners();
      return res;
    });
  }

  Future<Response> userLoginEmail(
      BuildContext context, String email, String password) async {
    loading = true;
    notifyListeners();
    var body = json.encode({
      'username': email,
      'password': password,
      'n_token': locator<AppPrefs>().fcmToken.getValue()
    });

    return APIHelper.userLoginEmail(body).then((res) {
      loading = false;
      notifyListeners();
      return res;
    });
  }

  Future<ResponseData> socialSignup(Map body) {
    loading = true;
    notifyListeners();
    return APIHelper.socialSignup(body).then((value) {
      loading = false;
      notifyListeners();
      if (value.state == ApiState.Success) {
        if (value.status) {
          final res = value.data;
          print('RESP DATA:: ${value.data}');
          locator<AppPrefs>().memberId.setValue(res['uid']);
          locator<AppPrefs>().userName.setValue(res['name']);
          locator<AppPrefs>().phoneNumber.setValue(res['mobile']);
          locator<AppPrefs>().userEmail.setValue(res['email']);
          locator<AppPrefs>().token.setValue(
                res['token'],
              );
          locator<AppPrefs>().isLoggedIn.setValue(true);
          return ResponseData(
            isSuccessed: true,
            message: value.messsage,
          );
        } else {
          return ResponseData(
            isSuccessed: false,
            message: value.messsage,
          );
        }
      } else {
        return ResponseData(
          isSuccessed: false,
          message: value.messsage,
        );
      }
    });
  }

  Future<ResponseData> socialLogin({
    String provider = 'Google',
  }) async {
    loading = true;
    notifyListeners();
    if (provider == 'Google') {
      return SocialAuthService().googleSignin().then(
        (res) {
          print(res.message);
          if (res.isSuccessed) {
            print("Google Login Success");
            return APIHelper.socialSignin({
              "email": res.data.email,
              "login_by": "google",
              'n_token': locator<AppPrefs>().fcmToken.getValue(),
            }).then(
              (response) {
                loading = false;
                notifyListeners();
                if (response.state == ApiState.Success) {
                  if (response.status) {
                    return ResponseData(
                      data: response.data,
                      isSuccessed: true,
                    );
                  } else {
                    registerMethod = "google";
                    notifyListeners();
                    return ResponseData<List<String>>(
                        isSuccessed: false,
                        message: response.messsage,
                        data: [res.data.email, res.data.name]);
                  }
                } else {
                  loading = false;
                  notifyListeners();
                  return null;
                }
              },
            );
          }
          loading = false;
          notifyListeners();
          return null;
        },
      );
    } else if (provider == 'Apple') {
      // if (await AppleSignIn.isAvailable()) {
      //   final _firebaseAuth = FirebaseAuth.instance;
      //   final AuthorizationResult result = await AppleSignIn.performRequests([
      //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      //   ]);
      //   switch (result.status) {
      //     case AuthorizationStatus.authorized:
      //       log('APPLE: ${result.credential.user}');
      //       final appleIdCredential = result.credential;
      //       print("Google Login Success");
      //       await APIHelper.socialSignin({
      //         "email": appleIdCredential.email,
      //         "login_by": "apple",
      //         "name": appleIdCredential.user,
      //         'n_token': locator<AppPrefs>().fcmToken.getValue(),
      //       }).then(
      //             (response) {
      //           loading = false;
      //           notifyListeners();
      //           if (response.state == ApiState.Success) {
      //             if (response.status) {
      //               return ResponseData(
      //                 data: response.data,
      //                 isSuccessed: true,
      //               );
      //             } else {
      //               registerMethod = "apple";
      //               notifyListeners();
      //               return ResponseData<List<String>>(
      //                   isSuccessed: false,
      //                   message: response.messsage,
      //                   data: [appleIdCredential.email, appleIdCredential.user]);
      //             }
      //           } else {
      //             loading = false;
      //             notifyListeners();
      //             return null;
      //           }
      //         },
      //       );
      //       break;
      //     case AuthorizationStatus.error:
      //       print("Sign in failed");
      //       break;
      //     case AuthorizationStatus.cancelled:
      //       print('User cancelled the operation');
      //       break;
      //   }
      // }
    } else {
      // return SocialAuthService()
      //     .facebookSignin()
      //     .then(
      //       (res) {
      //         print(res.message);
      //         if (res.isSuccessed) {
      //           print("Facebook Login Success");
      //           print(res.data);
      //           return APIHelper.socialSignin({
      //             "email": res.data,
      //             "login_by": "facebook",
      //             'type': 'member',
      //             'n_token': locator<AppPrefs>().fcmToken.getValue(),
      //           }).then(
      //             (response) {
      //               loading = false;
      //               notifyListeners();
      //               if (response.state == ApiState.Success) {
      //                 if (response.status) {
      //                   return ResponseData(
      //                     data: response.data,
      //                     isSuccessed: true,
      //                   );
      //                 } else {
      //                   registerMethod = "facebook";
      //                   notifyListeners();
      //                   print(response.messsage);
      //                   return ResponseData<List<String>>(
      //                       isSuccessed: false,
      //                       message: response.messsage,
      //                       data: res.data);
      //                 }
      //               } else {
      //                 loading = false;
      //                 notifyListeners();
      //                 return null;
      //               }
      //             },
      //           );
      //         }
      //         loading = false;
      //         notifyListeners();
      //         return null;
      //       },
      //     )
      //     .timeout(
      //       Duration(milliseconds: 6000),
      //     )
      //     .catchError((e) {
      //       print('fb login error: $e');
      //     });
    }
  }

  Future<dynamic> createAccount(String name, String email, String mobile,
      String otp, String password, String referralCode) async {
    loading = true;
    notifyListeners();
    FirebaseCloudMessagagingWapper().init();
    var body = json.encode({
      'name': name,
      'email': email,
      'mobile': mobile,
      'otp': otp,
      "account_type": "member",
      'password': password,
      'referral_code': referralCode,
      'n_token': locator<AppPrefs>().fcmToken.getValue(),
    });
    // if(referralCode != null && referralCode.isNotEmpty) {
    //   body['referral_code'] = ;
    // }

    return APIHelper.createAccount(body).then((res1) {
      loading = false;
      print('create account resp: $res1');
      var res;
      res = json.decode(res1.body);
      print('create account resps: $res');
      if (res1 != null && res['status']) {
        res = json.decode(res1.body);
        locator<AppPrefs>().memberId.setValue(res['data']['user_id']);
        locator<AppPrefs>().userName.setValue(name);
        locator<AppPrefs>().phoneNumber.setValue(mobile);
        locator<AppPrefs>().userEmail.setValue(email);
        locator<AppPrefs>().token.setValue(res['data']['token']);
        // locator<AppPrefs>().avatar.setValue(res['data']['profile'] ??'');
        locator<AppPrefs>().isLoggedIn.setValue(true);
        locator<AppPrefs>().dateAdded.setValue(
              res['data']['date_added'],
            );
      }
      notifyListeners();
      return res;
    });
  }

  Future<dynamic> forgotPassword(String username, String type) async {
    loading = true;
    notifyListeners();
    var body = json.encode({'type': type, 'username': username});
    return APIHelper.forgotPassword(body).then((res) {
      loading = false;
      notifyListeners();
      return res;
    });
  }

  Future<dynamic> resetPassword(
      String otp, String password, String userId) async {
    loading = true;
    notifyListeners();

    var body = json
        .encode({'reset_otp': otp, 'password': password, "user_id": userId});

    return APIHelper.resetPassword(body).then((res) {
      loading = false;
      notifyListeners();
      return res;
    });
  }
}
