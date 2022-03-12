import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
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
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/app_button.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/text_field.dart';

import '../../main.dart';

class LoginEmail extends StatefulWidget {
  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmail = false;
  bool isPassword = false;
  bool obscureText = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SafeArea(
        child: Consumer<AuthController>(builder: (context, auth, snapshot) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login with us',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login and get early access of our best products. inspiration and many more',
                        style: TextStyle(color: AppColors.TEXT_DARK),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      UnderlineTextField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Please enter your Email',
                        controller: emailController,
                        maxLines: 1,
                        suffix: Icon(
                          Icons.check,
                          color: isEmail ? Colors.red : Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email number';
                          } else if (!Global.validateEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isEmpty || value == null) {
                            isEmail = false;
                          } else if (value.length < 8) {
                            isEmail = false;
                          } else {
                            isEmail = true;
                          }
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20),
                      UnderlineTextField(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter password',
                        controller: passwordController,
                        maxLines: 1,
                        observe: obscureText,
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
                                padding: const EdgeInsets.all(8.0),
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
                              color:
                                  isPassword ? Colors.red : Colors.transparent,
                            ),
                          ],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 6) {
                            return 'Please should be of minimum 6 letters';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isEmpty || value == null) {
                            isPassword = false;
                          } else if (value.length != 7) {
                            isPassword = false;
                          } else {
                            isPassword = true;
                          }
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            NavigationService.navigateTo(Routes.forgotPaswword);
                          },
                          child: Text(
                            "forgot password ?",
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      AppOutlineButton(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        fontSize: 16,
                        textColor: Colors.red,
                        label: 'Login',
                        color: Colors.white,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            Response res = await auth.userLoginEmail(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                            var jsonResp;
                            if (res != null) {
                              jsonResp = json.decode(res.body);
                              if (jsonResp['status']) {
                                final res = jsonResp['data'];
                                print('RESP DATA:: $res');
                                locator<AppPrefs>()
                                    .memberId
                                    .setValue(res['uid']);
                                locator<AppPrefs>()
                                    .userName
                                    .setValue(res['name']);
                                locator<AppPrefs>()
                                    .phoneNumber
                                    .setValue(res['mobile']);
                                locator<AppPrefs>()
                                    .dateAdded
                                    .setValue(res['date_added']);
                                locator<AppPrefs>()
                                    .userEmail
                                    .setValue(res['email']);
                                locator<AppPrefs>()
                                    .token
                                    .setValue(res['token']);
                                locator<AppPrefs>().isLoggedIn.setValue(true);
                                if (res.containsKey('profile')) {
                                  locator<AppPrefs>()
                                      .avatar
                                      .setValue(res['profile']);
                                }
                                context.read<GymStore>().init(context: context);

                                if (res['memDetail']) {
                                  locator<AppPrefs>().memberAdded.setValue(true);
                                  NavigationService.navigateToReplacement(
                                      Routes.homePage);
                                } else {
                                  locator<AppPrefs>().memberAdded.setValue(false);
                                  NavigationService.navigateToReplacement(
                                      Routes.userDetail);
                                }
                              } else {
                                FlashHelper.errorBar(context,
                                    message: jsonResp['message']);
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      AppOutlineButton(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        fontSize: 16,
                        textColor: Colors.white,
                        label: 'Login with Number',
                        color: AppConstants.primaryColor,
                        onPressed: () async {
                          NavigationService.navigateToReplacement(Routes.login);
                        },
                      ),
                      SizedBox(height: 30),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Login with : ',
                      //       style: TextStyle(
                      //           fontSize: 16, color: AppColors.TEXT_DARK),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         auth.socialLogin().then(
                      //           (value) {
                      //             if (value != null) {
                      //               if (value.isSuccessed) {
                      //                 final res = value.data;
                      //                 print('RESP DATA:: ${value.data}');
                      //                 locator<AppPrefs>()
                      //                     .memberId
                      //                     .setValue(res['uid']);
                      //                 locator<AppPrefs>()
                      //                     .userName
                      //                     .setValue(res['name']);
                      //                 locator<AppPrefs>()
                      //                     .phoneNumber
                      //                     .setValue(res['mobile']);
                      //                 locator<AppPrefs>()
                      //                     .dateAdded
                      //                     .setValue(res['date_added']);
                      //                 locator<AppPrefs>()
                      //                     .userEmail
                      //                     .setValue(res['email']);
                      //                 locator<AppPrefs>()
                      //                     .token
                      //                     .setValue(res['token']);
                      //                 locator<AppPrefs>()
                      //                     .isLoggedIn
                      //                     .setValue(true);
                      //                 if (res.containsKey('profile')) {
                      //                   locator<AppPrefs>()
                      //                       .avatar
                      //                       .setValue(res['profile']);
                      //                 }
                      //                 context
                      //                     .read<GymStore>()
                      //                     .init(context: context);
                      //
                      //                 if (res['memDetail']) {
                      //                   NavigationService.navigateToReplacement(
                      //                       Routes.homePage);
                      //                 } else {
                      //                   NavigationService.navigateToReplacement(
                      //                       Routes.userDetail);
                      //                 }
                      //               } else {
                      //                 NavigationService.navigateToReplacement(
                      //                   Routes.register,
                      //                 );
                      //                 // ScaffoldMessenger.of(context)
                      //                 //     .showSnackBar(
                      //                 //   SnackBar(
                      //                 //     content: Text(value.message),
                      //                 //   ),
                      //                 // );
                      //               }
                      //             }
                      //           },
                      //         );
                      //       },
                      //       child: Image.asset(
                      //         Images.GOOGLE,
                      //         width: 40,
                      //         height: 40,
                      //       ),
                      //     ),
                      //     // SizedBox(
                      //     //   width: 10,
                      //     // ),
                      //     // GestureDetector(
                      //     //   onTap: () {
                      //     //     auth
                      //     //         .socialLogin(provider: 'facebook')
                      //     //         .then((value) {
                      //     //       if (value != null) {
                      //     //         if (value.isSuccessed) {
                      //     //           final res = value.data;
                      //     //           print('RESP DATA:: ${value.data}');
                      //     //           locator<AppPrefs>()
                      //     //               .memberId
                      //     //               .setValue(res['uid']);
                      //     //           locator<AppPrefs>()
                      //     //               .userName
                      //     //               .setValue(res['name']);
                      //     //           // locator<AppPrefs>().phoneNumber.setValue(mobile);
                      //     //           locator<AppPrefs>()
                      //     //               .userEmail
                      //     //               .setValue(res['email']);
                      //     //           locator<AppPrefs>().token.setValue(
                      //     //                 res['token'],
                      //     //               );
                      //     //           locator<AppPrefs>()
                      //     //               .isLoggedIn
                      //     //               .setValue(true);
                      //     //           context
                      //     //               .read<GymStore>()
                      //     //               .getAllGyms(context: context);
                      //     //           context
                      //     //               .read<GymStore>()
                      //     //               .getActiveSubscriptions(
                      //     //                   context: context);
                      //     //           context
                      //     //               .read<GymStore>()
                      //     //               .getMemberSubscriptions(
                      //     //                   context: context);
                      //     //           context
                      //     //               .read<GymStore>()
                      //     //               .getBanner(context: context);
                      //     //           context
                      //     //               .read<UserStore>()
                      //     //               .getUserById(context: context);
                      //     //           context.read<GymStore>().getTerms();
                      //     //
                      //     //           NavigationService.navigateToReplacement(
                      //     //               Routes.homePage);
                      //     //         } else {
                      //     //           NavigationService.navigateToReplacement(
                      //     //               Routes.register);
                      //     //           ScaffoldMessenger.of(context).showSnackBar(
                      //     //               SnackBar(content: Text(value.message)));
                      //     //         }
                      //     //       }
                      //     //     });
                      //     //   },
                      //     //   child: Image.asset(
                      //     //     Images.FACEBOOK,
                      //     //     width: 35,
                      //     //     height: 35,
                      //     //   ),
                      //     // ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  NavigationService.navigateToReplacement(Routes.register);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Create Account?',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.TEXT_DARK),
                    ),
                  ),
                ),
              ),
              auth.isLoading ? LoadingWithBackground() : Container()
            ],
          );
        }),
      ),
    );
  }
}
