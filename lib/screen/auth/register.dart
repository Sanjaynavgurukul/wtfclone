import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
import 'package:wtf/main.dart';
import 'package:wtf/widget/app_button.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final emailAddress = TextEditingController();
  final name = TextEditingController();
  final mobileNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final referralCodeController = TextEditingController();
  bool isEmailValid = false;
  bool isNameValid = false;
  bool isNumberValid = false;
  bool isPassword = false;
  bool isConfirmPassword = false;
  bool isOtp = false;

  bool isCheck = false;
  bool isSend = false;
  bool obscureText = true;

  OTPTextEditController controller;
  OTPInteractor _otpInteractor;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GymStore gymstore;

  @override
  void initState() {
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
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Form(
        key: formKey,
        child: Consumer<AuthController>(builder: (context, auth, snapshot) {
          return SafeArea(
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Image.asset(
                          'assets/images/wtf_3.png',
                          height: 80.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Sign up',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Create account and explore WTF managed world class Fitness Facilities, Events & Challenges near you.',
                                style: GoogleFonts.poppins(
                                  color: AppColors.TEXT_DARK,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              OutlineTextField(
                                hintText: 'Your Name',
                                controller: name,
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                                suffix: Icon(
                                  Icons.check,
                                  color: isNameValid
                                      ? Colors.red
                                      : Colors.transparent,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  } else if (value.length < 3) {
                                    return 'Please enter valid name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isEmpty || value == null) {
                                    isNameValid = false;
                                  } else if (value.length < 3) {
                                    isNameValid = false;
                                  } else {
                                    isNameValid = true;
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: 20),
                              OutlineTextField(
                                hintText: 'Your Email Address',
                                controller: emailAddress,
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                suffix: Icon(
                                  Icons.check,
                                  color: isEmailValid
                                      ? Colors.red
                                      : Colors.transparent,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter e-mail address';
                                  } else if (!Global.validateEmail(value)) {
                                    return 'Please enter valid email address';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isEmpty || value == null) {
                                    isEmailValid = false;
                                  } else if (!Global.validateEmail(value)) {
                                    isEmailValid = false;
                                  } else {
                                    isEmailValid = true;
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: 20),
                              OutlineTextField(
                                // inputFormatters: [
                                //   Global.number,
                                // ],
                                keyboardType: TextInputType.number,
                                hintText: 'Mobile Number',
                                controller: mobileNumber,
                                maxLines: 1,
                                maxLength: 10,
                                suffix: Icon(
                                  Icons.check,
                                  color: isNumberValid
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
                                    isNumberValid = false;
                                  } else if (value.length != 10) {
                                    isNumberValid = false;
                                  } else {
                                    isNumberValid = true;
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(height: 20),
                              if (auth.registerMethod == null)
                                Column(
                                  children: [
                                    OutlineTextField(
                                      hintText: 'Enter Password',
                                      controller: password,
                                      maxLines: 1,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter [password]';
                                        } else if (value.length < 6) {
                                          return 'Password should be of at least 6 characters';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        if (value.isEmpty || value == null) {
                                          isPassword = false;
                                        } else {
                                          isPassword = true;
                                        }
                                        setState(() {});
                                      },
                                      obscureText: obscureText,
                                      suffix: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          UIHelper.horizontalSpace(16.0),
                                          Icon(
                                            Icons.check,
                                            color: isPassword
                                                ? Colors.red
                                                : Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    OutlineTextField(
                                      hintText: 'Confirm Password',
                                      controller: confirmPassword,
                                      maxLines: 1,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter [password]';
                                        } else if (value.length < 6) {
                                          return 'Password should be of at least 6 characters';
                                        }
                                        else if(password.text != value) return 'Password not match';
                                        return null;
                                      },
                                      onChanged: (value) {
                                        if (value.isEmpty || value == null) {
                                          isConfirmPassword = false;
                                        } else {
                                          isConfirmPassword = true;
                                        }
                                        setState(() {});
                                      },
                                      obscureText: obscureText,
                                      suffix: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          UIHelper.horizontalSpace(16.0),
                                          Icon(
                                            Icons.check,
                                            color: isPassword
                                                ? Colors.red
                                                : Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              OutlineTextField(
                                // inputFormatters: [
                                //   Global.number,
                                // ],
                                keyboardType: TextInputType.text,
                                hintText: 'Referral Code (optional)',
                                controller: referralCodeController,
                                maxLines: 1,
                              ),
                              SizedBox(height: 20),

                              isSend
                                  ? OutlineTextField(
                                      fontFamily: Fonts.ROBOTO,
                                      enable: true,
                                      inputFormatters: [Global.amountValidator],
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                        decimal: false,
                                        signed: false,
                                      ),
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
                              SizedBox(height: isSend ? 20 : 0),
                              Row(
                                children: [
                                  // Theme(
                                  //   data: Theme.of(context).copyWith(
                                  //     unselectedWidgetColor: Colors.red,
                                  //   ),
                                  //   child: Checkbox(
                                  //     checkColor: Colors.white,
                                  //     activeColor: Colors.red,
                                  //     value: isCheck,
                                  //     onChanged: (bool value) {
                                  //       setState(() {
                                  //         isCheck = value;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        text:
                                            'By completing the sign-up process, you agree to our ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.0,
                                            color: AppColors.TEXT_DARK),
                                        children: [
                                          TextSpan(
                                            text: 'terms',
                                            style: GoogleFonts.poppins(
                                              color: AppColors.TEXT_DARK,
                                              fontSize: 12.0,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launch(
                                                  'https://wtfup.me/terms',
                                                );
                                              },
                                          ),
                                          TextSpan(
                                            text: ', ',
                                            style: GoogleFonts.poppins(
                                              color: AppColors.TEXT_DARK,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'privacy',
                                            style: GoogleFonts.poppins(
                                              color: AppColors.TEXT_DARK,
                                              fontSize: 12.0,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launch(
                                                  'https://wtfup.me/privacy-policy',
                                                );
                                              },
                                          ),
                                          TextSpan(
                                            text: ' and ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.0,
                                              color: AppColors.TEXT_DARK,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'refund policy',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.0,
                                              color: AppColors.TEXT_DARK,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launch(
                                                  'https://wtfup.me/refund-cancellation',
                                                );
                                              },
                                          ),
                                          // TextSpan(
                                          //   text: ' ',
                                          //   style: GoogleFonts.poppins()(
                                          //     color: AppColors.TEXT_DARK,
                                          //   ),
                                          // ),
                                          TextSpan(
                                            text: '.',
                                            style: GoogleFonts.poppins(
                                                color: AppColors.TEXT_DARK),
                                            // recognizer: TapGestureRecognizer()
                                            //   ..onTap = () {
                                            //     launch(
                                            //       'https://wtfup.me/refund-cancellation',
                                            //     );
                                            // },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Text(
                              //   'Also, you will automatically opt for WTF Emails, WhatsApp, and SMS.',
                              //   style: GoogleFonts.poppins()(
                              //     fontSize: 12.0,
                              //     color: AppColors.TEXT_DARK,
                              //   ),
                              // ),
                              SizedBox(height: 20),
                              isSend
                                  ? GestureDetector(
                                      onTap: () async {
                                        Response response = await auth
                                            .sendOtp(mobileNumber.text);
                                        var res = json.decode(response.body);
                                        _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                            content: new Text(
                                              res['message'],
                                            ),
                                          ),
                                        );
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
                              SizedBox(height: 20),
                              AppOutlineButton(
                                width: MediaQuery.of(context).size.width,
                                height: 48.0,
                                fontSize: 14,
                                textColor: Colors.black,
                                label: isSend
                                    ? 'Create Account'
                                    : 'Send OTP & Continue',
                                onPressed: () async {
                                  //remove
                                  // Future.delayed(
                                  //     Duration(seconds: 1),
                                  //     () => NavigationService
                                  //         .navigateToReplacement(
                                  //             Routes.userDetail));
                                  //end
                                  final formState = formKey.currentState;
                                  if (formState.validate()) {
                                    formState.save();
                                    if (isSend) {
                                      if (auth.registerMethod != null) {
                                        context
                                            .read<GymStore>()
                                            .init(context: context);
                                        auth.socialSignup({
                                          "name": name.text,
                                          // "otp": otp.text,
                                          "mobile": mobileNumber.text,
                                          "email": emailAddress.text,
                                          "register_by": auth.registerMethod,
                                          "account_type": 'member',
                                          // "password:": password.text,
                                        }).then((value) {
                                          if (value.isSuccessed) {
                                            context
                                                .read<GymStore>()
                                                .init(context: context);
                                            auth.registerMethod = null;
                                            locator<AppPrefs>().memberAdded.setValue(false);
                                            // Future.delayed(
                                            //     Duration(seconds: 1),
                                            //     () => NavigationService
                                            //         .navigateToReplacement(
                                            //             Routes.userDetail));
                                            Future.delayed(
                                                Duration(seconds: 1),
                                                () {
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(Routes.userDetail, (Route<dynamic> route) => false);
                                                });
                                          } else {
                                            _scaffoldKey.currentState
                                                .showSnackBar(new SnackBar(
                                                    content: new Text(
                                              value.message,
                                            )));
                                          }
                                        });
                                      } else {
                                        if (password.text ==
                                            confirmPassword.text) {
                                          dynamic res =
                                              await auth.createAccount(
                                            name.text,
                                            emailAddress.text,
                                            mobileNumber.text,
                                            controller.text,
                                            password.text,
                                            referralCodeController.text,
                                          );
                                          context
                                              .read<GymStore>()
                                              .init(context: context);

                                          _scaffoldKey.currentState
                                              .showSnackBar(new SnackBar(
                                                  content: new Text(
                                                      res['message'])));

                                          if (res['status']) {
                                            Future.delayed(
                                              Duration(seconds: 1),
                                              () => Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(Routes.userDetail, (Route<dynamic> route) => false),
                                            );
                                          }
                                        } else {
                                          FlashHelper.informationBar(context,
                                              message: 'Password do not match');
                                          setState(() {
                                            isConfirmPassword = false;
                                          });
                                        }
                                      }
                                    } else {
                                      Response response = await auth.sendOtp(
                                          mobileNumber.text.toString());
                                      var res = json.decode(response.body);
                                      if (res['status'] &&
                                          res['userExist'] == false) {
                                        String _otp = res['data']['otp'];
                                        print("Otp is $_otp");
                                        setState(() {
                                          isSend = true;
                                        });
                                        // Future.delayed(Duration(seconds: 1),
                                        //     () {
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
                                        if (res['userExist']) {
                                          FlashHelper.informationBar(context,
                                              message:
                                                  'User already exist with this number');
                                        } else {
                                          _scaffoldKey.currentState
                                              .showSnackBar(
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
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Already have an account? ",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                        ),
                                        TextSpan(
                                            text: "Sign In",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                NavigationService
                                                    .navigateToReplacement(
                                                        Routes.login);
                                              })
                                      ],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppConstants.buttonRed2,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  auth.isLoading ? LoadingWithBackground() : Container()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
