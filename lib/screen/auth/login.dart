import 'dart:convert';
import 'dart:io';

// import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/auth_controller.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/global.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/app_button.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/text_field.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final mobileNumber = TextEditingController();
  // final otp = TextEditingController();

  bool isMobileNumber = false;
  bool isOtp = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isSend = false;
  OTPTextEditController controller;
  OTPInteractor _otpInteractor;

  @override
  void initState() {
    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      // AppleSignIn.onCredentialRevoked.listen((_) {
      //   print("Credentials revoked");
      // });
    }
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        //ignore: avoid_print
        .then((value) => print('signature - $value'));

    controller = OTPTextEditController(
      codeLength: 7,
      //ignore: avoid_print
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{7})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        // strategies: [
        //   SampleStrategy(),
        // ],
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<AuthController>(builder: (context, auth, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).viewInsets.bottom > 10
                      ? MediaQuery.of(context).size.height + 160.0
                      : MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: auth.isLoading
                      ? Loading()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UIHelper.verticalSpace(10.0),
                            Center(
                              child: Image.asset(
                                'assets/images/wtf_3.png',
                                height: 80.0,
                              ),
                            ),
                            UIHelper.verticalSpace(50.0),
                            Text(
                              'Welcome Back',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            UIHelper.verticalSpace(20.0),
                            SizedBox(
                              height: 25,
                            ),
                            // Text(
                            //   'Login to your account and continue your fitness journey with WTF.',
                            //   style: GoogleFonts.poppins(color: AppColors.TEXT_DARK),
                            // ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                            OutlineTextField(
                              inputFormatters: [
                                // Global.amountValidator,
                                // LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              ),
                              fontFamily: Fonts.ROBOTO,
                              hintText: 'Enter Mobile Number',
                              controller: mobileNumber,
                              maxLength: 10,
                              maxLines: 1,
                              suffix: Icon(
                                Icons.check,
                                color: isMobileNumber
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter mobile number';
                                } else if (value.length != 10) {
                                  return 'Please enter valid number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isEmpty || value == null) {
                                  isMobileNumber = false;
                                  isSend = false;
                                } else if (value.length < 9) {
                                  isMobileNumber = false;
                                  isSend = false;
                                } else {
                                  isMobileNumber = true;
                                }
                                setState(() {

                                });
                              },
                            ),
                            SizedBox(height: 20),
                            isSend
                                ? OutlineTextField(
                                    inputFormatters: [Global.amountValidator],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: false,
                                    ),
                                    fontFamily: Fonts.ROBOTO,
                                    hintText: 'OTP',
                                    controller: controller,
                                    maxLines: 1,
                                    suffix: Icon(
                                      Icons.check,
                                      color: isOtp
                                          ? Colors.red
                                          : Colors.transparent,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter otp';
                                      } else if (value.length != 7) {
                                        return 'Please enter valid otp';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (value.isEmpty || value == null) {
                                        isOtp = false;
                                      } else if (value.length != 7) {
                                        isOtp = false;
                                      } else {
                                        isOtp = true;
                                      }
                                      setState(() {});
                                    },
                                  )
                                : Container(),
                            SizedBox(height: 10),
                            isSend
                                ? GestureDetector(
                                    onTap: () async {
                                      Response response = await auth.sendOtp(
                                          mobileNumber.text,
                                          type: 'login');
                                      var res = json.decode(response.body);
                                      if (res['status']) {
                                        String _otp = res['data']['otp'];
                                        print("Otp is $_otp");
                                        setState(() {
                                          isSend = true;
                                        });
                                        // Future.delayed(Duration(seconds: 1), () {
                                        //   setState(() {
                                        //     otp.text = _otp;
                                        //   });
                                        // });
                                        _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                            content: new Text(
                                              res['message'],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Resend OTP?',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, color: Colors.red),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Spacer(),
                            AppOutlineButton(
                              width: MediaQuery.of(context).size.width,
                              height: 48.0,
                              fontSize: 14,
                              textColor: AppConstants.black,
                              label: isSend ? 'Login' : 'Send OTP',
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  if (isSend) {
                                    Response response = await auth.userLogin(
                                        context,
                                        mobileNumber.text,
                                        controller.text);
                                    var res = json.decode(response.body);
                                    print('BODY:: ${res}');
                                    if (res['status']) {
                                      print('RESP DATA:: ${res['data']}');
                                      if (res['data']['account_type'] ==
                                              'member' ||
                                          res['data']['account_type'].isEmpty) {
                                        locator<AppPrefs>()
                                            .memberId
                                            .setValue(res['data']['uid']);
                                        locator<AppPrefs>()
                                            .userName
                                            .setValue(res['data']['name']);
                                        locator<AppPrefs>()
                                            .phoneNumber
                                            .setValue(res['data']['mobile']);
                                        locator<AppPrefs>().dateAdded.setValue(
                                            res['data']['date_added']);
                                        locator<AppPrefs>()
                                            .userEmail
                                            .setValue(res['data']['email']);
                                        locator<AppPrefs>()
                                            .token
                                            .setValue(res['data']['token']);
                                        locator<AppPrefs>()
                                            .isLoggedIn
                                            .setValue(true);
                                        if (res['data']['profile'] != null)
                                          locator<AppPrefs>()
                                              .avatar
                                              .setValue(res['data']['profile']);
                                        context
                                            .read<GymStore>()
                                            .init(context: context);
                                        print(
                                            'member details available:: ${res['data']['memDetail']}');
                                        if (res['data']['memDetail']) {
                                          locator<AppPrefs>().memberAdded.setValue(true);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(Routes.homePage, (Route<dynamic> route) => false);
                                          // NavigationService
                                          //     .navigateToReplacement(
                                          //         Routes.homePage);
                                        } else {
                                          locator<AppPrefs>().memberAdded.setValue(false);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(Routes.userDetail, (Route<dynamic> route) => false);
                                          // NavigationService
                                          //     .navigateToReplacement(
                                          //         Routes.userDetail);
                                        }
                                      } else {
                                        _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                            content: new Text(
                                              '${res['data']['account_type']} cannot login on Member App',
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          content: new Text(
                                            res['message'],
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    Response response = await auth.sendOtp(
                                        mobileNumber.text,
                                        type: 'login');
                                    var res = json.decode(response.body);
                                    print('otp resp: $res');
                                    if (res['status'] && res['userExist']) {
                                      String _otp = res['data']['otp'];
                                      print("Otp is $_otp");
                                      setState(() {
                                        isSend = true;
                                      });
                                      // Future.delayed(Duration(seconds: 1), () {
                                      //   setState(() {
                                      //     otp.text = _otp;
                                      //   });
                                      // });
                                      _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          content: new Text(
                                            res['message'],
                                          ),
                                        ),
                                      );
                                    } else {
                                      if (res['userExist'] == false) {
                                        FlashHelper.informationBar(context,
                                            message:
                                                'User does not exist, please create a account');
                                      } else {
                                        _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                            content: new Text(
                                              res['message'],
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            AppOutlineButton(
                              width: MediaQuery.of(context).size.width,
                              height: 48.0,
                              fontSize: 14.0,
                              textColor: Colors.white,
                              label: 'Login with Email',
                              color: AppConstants.primaryColor,
                              onPressed: () async {
                                NavigationService.navigateToReplacement(
                                    Routes.loginEmail);
                              },
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topCenter,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Don\'t have an account? ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Sign up",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          NavigationService
                                              .navigateToReplacement(
                                              Routes.register);
                                        },
                                    )
                                  ],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppConstants.buttonRed2,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 80),
                            // if (Platform.isAndroid)
                            //   IntrinsicHeight(
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       mainAxisSize: MainAxisSize.max,
                            //       children: [
                            //         Text(
                            //           'Login with : ',
                            //           style: GoogleFonts.poppins()(
                            //               fontSize: 16, color: AppColors.TEXT_DARK),
                            //         ),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //         GestureDetector(
                            //           onTap: () {
                            //             auth.socialLogin().then(
                            //               (value) {
                            //                 if (value != null) {
                            //                   if (value.isSuccessed) {
                            //                     final res = value.data;
                            //                     print('RESP DATA:: ${value.data}');
                            //                     locator<AppPrefs>()
                            //                         .memberId
                            //                         .setValue(res['uid']);
                            //                     locator<AppPrefs>()
                            //                         .userName
                            //                         .setValue(res['name']);
                            //                     locator<AppPrefs>()
                            //                         .phoneNumber
                            //                         .setValue(res['mobile']);
                            //                     locator<AppPrefs>()
                            //                         .dateAdded
                            //                         .setValue(res['date_added']);
                            //                     locator<AppPrefs>()
                            //                         .userEmail
                            //                         .setValue(res['email']);
                            //                     locator<AppPrefs>()
                            //                         .token
                            //                         .setValue(res['token']);
                            //                     locator<AppPrefs>()
                            //                         .isLoggedIn
                            //                         .setValue(true);
                            //                     if (res.containsKey('profile')) {
                            //                       locator<AppPrefs>()
                            //                           .avatar
                            //                           .setValue(res['profile']);
                            //                     }
                            //                     context
                            //                         .read<GymStore>()
                            //                         .init(context: context);
                            //
                            //                     if (res['memDetail']) {
                            //                       NavigationService
                            //                           .navigateToReplacement(
                            //                               Routes.homePage);
                            //                     } else {
                            //                       NavigationService
                            //                           .navigateToReplacement(
                            //                               Routes.userDetail);
                            //                     }
                            //                   } else {
                            //                     NavigationService
                            //                         .navigateToReplacement(
                            //                       Routes.register,
                            //                     );
                            //                     // ScaffoldMessenger.of(context)
                            //                     //     .showSnackBar(
                            //                     //   SnackBar(
                            //                     //     content: Text(value.message),
                            //                     //   ),
                            //                     // );
                            //                   }
                            //                 }
                            //               },
                            //             );
                            //           },
                            //           child: Image.asset(
                            //             Images.GOOGLE,
                            //             width: 40,
                            //             height: 40,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           width: 20,
                            //         ),
                            //         // if (Platform.isIOS)
                            //         // GestureDetector(
                            //         //   onTap: () {
                            //         //     auth.socialLogin(provider: 'Apple').then(
                            //         //       (value) {
                            //         //         if (value != null) {
                            //         //           if (value.isSuccessed) {
                            //         //             final res = value.data;
                            //         //             print('RESP DATA:: ${value.data}');
                            //         //             locator<AppPrefs>()
                            //         //                 .memberId
                            //         //                 .setValue(res['uid']);
                            //         //             locator<AppPrefs>()
                            //         //                 .userName
                            //         //                 .setValue(res['name']);
                            //         //             locator<AppPrefs>()
                            //         //                 .phoneNumber
                            //         //                 .setValue(res['mobile']);
                            //         //             locator<AppPrefs>()
                            //         //                 .dateAdded
                            //         //                 .setValue(res['date_added']);
                            //         //             locator<AppPrefs>()
                            //         //                 .userEmail
                            //         //                 .setValue(res['email']);
                            //         //             locator<AppPrefs>()
                            //         //                 .token
                            //         //                 .setValue(res['token']);
                            //         //             locator<AppPrefs>()
                            //         //                 .isLoggedIn
                            //         //                 .setValue(true);
                            //         //             if (res.containsKey('profile')) {
                            //         //               locator<AppPrefs>()
                            //         //                   .avatar
                            //         //                   .setValue(res['profile']);
                            //         //             }
                            //         //             context
                            //         //                 .read<GymStore>()
                            //         //                 .init(context: context);
                            //         //
                            //         //             if (res['memDetail']) {
                            //         //               NavigationService
                            //         //                   .navigateToReplacement(
                            //         //                       Routes.homePage);
                            //         //             } else {
                            //         //               NavigationService
                            //         //                   .navigateToReplacement(
                            //         //                       Routes.userDetail);
                            //         //             }
                            //         //           } else {
                            //         //             NavigationService
                            //         //                 .navigateToReplacement(
                            //         //               Routes.register,
                            //         //             );
                            //         //             // ScaffoldMessenger.of(context)
                            //         //             //     .showSnackBar(
                            //         //             //   SnackBar(
                            //         //             //     content: Text(value.message),
                            //         //             //   ),
                            //         //             // );
                            //         //           }
                            //         //         }
                            //         //       },
                            //         //     );
                            //         //   },
                            //         //   child: Image.asset(
                            //         //     Images.APPLE,
                            //         //     width: 40,
                            //         //     height: 40,
                            //         //   ),
                            //         // ),
                            //         // Flexible(
                            //         //   child: AppleSignInButton(
                            //         //     type: ButtonType.signIn,
                            //         //     style: b.ButtonStyle.black,
                            //         //     onPressed: () {
                            //         //       //code to be executed
                            //         //     },
                            //         //   ),
                            //         // ),
                            //         // SizedBox(
                            //         //   width: 10,
                            //         // ),
                            //         // GestureDetector(
                            //         //   onTap: () {
                            //         //     auth
                            //         //         .socialLogin(provider: 'facebook')
                            //         //         .then((value) {
                            //         //       if (value != null) {
                            //         //         if (value.isSuccessed) {
                            //         //           final res = value.data;
                            //         //           print('RESP DATA:: ${value.data}');
                            //         //           locator<AppPrefs>()
                            //         //               .memberId
                            //         //               .setValue(res['uid']);
                            //         //           locator<AppPrefs>()
                            //         //               .userName
                            //         //               .setValue(res['name']);
                            //         //           // locator<AppPrefs>().phoneNumber.setValue(mobile);
                            //         //           locator<AppPrefs>()
                            //         //               .userEmail
                            //         //               .setValue(res['email']);
                            //         //           locator<AppPrefs>().token.setValue(
                            //         //                 res['token'],
                            //         //               );
                            //         //           locator<AppPrefs>()
                            //         //               .isLoggedIn
                            //         //               .setValue(true);
                            //         //           context
                            //         //               .read<GymStore>()
                            //         //               .getAllGyms(context: context);
                            //         //           context
                            //         //               .read<GymStore>()
                            //         //               .getActiveSubscriptions(
                            //         //                   context: context);
                            //         //           context
                            //         //               .read<GymStore>()
                            //         //               .getMemberSubscriptions(
                            //         //                   context: context);
                            //         //           context
                            //         //               .read<GymStore>()
                            //         //               .getBanner(context: context);
                            //         //           context
                            //         //               .read<UserStore>()
                            //         //               .getUserById(context: context);
                            //         //           context.read<GymStore>().getTerms();
                            //         //
                            //         //           NavigationService.navigateToReplacement(
                            //         //               Routes.homePage);
                            //         //         } else {
                            //         //           NavigationService.navigateToReplacement(
                            //         //               Routes.register);
                            //         //           ScaffoldMessenger.of(context).showSnackBar(
                            //         //               SnackBar(content: Text(value.message)));
                            //         //         }
                            //         //       }
                            //         //     });
                            //         //   },
                            //         //   child: Image.asset(
                            //         //     Images.FACEBOOK,
                            //         //     width: 35,
                            //         //     height: 35,
                            //         //   ),
                            //         // ),
                            //       ],
                            //     ),
                            //   ),
                            // Align(
                            //     alignment: Alignment.bottomCenter,
                            //     child: RichText(
                            //       text: TextSpan(
                            //         children: [
                            //           TextSpan(
                            //             text: "Dont have an account? ",
                            //             style: GoogleFonts.poppins(
                            //               fontSize: 14.0,
                            //               fontWeight: FontWeight.w400,
                            //               color: Colors.white.withOpacity(0.8),
                            //             ),
                            //           ),
                            //           TextSpan(
                            //             text: " Sign up",
                            //             recognizer: TapGestureRecognizer()
                            //               ..onTap = () {
                            //                 NavigationService
                            //                     .navigateToReplacement(
                            //                         Routes.register);
                            //               },
                            //           )
                            //         ],
                            //         style: GoogleFonts.poppins(
                            //           fontSize: 16.0,
                            //           fontWeight: FontWeight.w500,
                            //           color: AppConstants.buttonRed2,
                            //         ),
                            //       ),
                            //       textAlign: TextAlign.center,
                            //     )),
                          ],
                        ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
