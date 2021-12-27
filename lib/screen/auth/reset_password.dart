import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/auth_controller.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/widget/app_button.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  final String otp;
  final String userId;

  const ResetPasswordPage(this.otp, this.userId);
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final otp = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool isMobileNumber = false;
  bool isEmail = false;
  int _radioValue = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isSend = false;

  @override
  void initState() {
    // setState(() {
    //   otp.text = widget.otp;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Consumer<AuthController>(builder: (context, auth, snapshot) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Reset your password',
                                  style: TextStyle(color: AppColors.TEXT_DARK),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                UnderlineTextField(
                                  // inputFormatters: [Global.amountValidator],
                                  // keyboardType:
                                  //     TextInputType.numberWithOptions(
                                  //   decimal: true,
                                  //   signed: false,
                                  // ),
                                  enable: true,
                                  hintText: 'OTP',
                                  controller: otp,
                                  maxLines: 1,
                                  suffix: Icon(
                                    Icons.check,
                                    color: isMobileNumber
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
                                      isMobileNumber = false;
                                    } else if (value.length < 8) {
                                      isMobileNumber = false;
                                    } else {
                                      isMobileNumber = true;
                                    }
                                    setState(() {});
                                  },
                                ),
                                SizedBox(height: 20),
                                UnderlineTextField(
                                  // inputFormatters: [Global.amountValidator],
                                  // keyboardType:
                                  //     TextInputType.numberWithOptions(
                                  //   decimal: true,
                                  //   signed: false,
                                  // ),
                                  hintText: 'Password',
                                  controller: password,
                                  observe: true,
                                  maxLines: 1,
                                  suffix: Icon(
                                    Icons.check,
                                    color: isMobileNumber
                                        ? Colors.red
                                        : Colors.transparent,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    } else if (value.length < 6) {
                                      return 'Please enter valid password';
                                    }
                                    return null;
                                  },
                                  // onChanged: (value) {
                                  //   if (value.isEmpty || value == null) {
                                  //     isMobileNumber = false;
                                  //   } else if (value.length < 8) {
                                  //     isMobileNumber = false;
                                  //   } else {
                                  //     isMobileNumber = true;
                                  //   }
                                  //   setState(() {});
                                  // },
                                ),
                                SizedBox(height: 20),
                                UnderlineTextField(
                                  // inputFormatters: [Global.amountValidator],
                                  // keyboardType:
                                  //     TextInputType.numberWithOptions(
                                  //   decimal: true,
                                  //   signed: false,
                                  // ),
                                  hintText: 'Confirm Password',
                                  controller: confirmPassword,
                                  observe: true,
                                  maxLines: 1,
                                  suffix: Icon(
                                    Icons.check,
                                    color: isMobileNumber
                                        ? Colors.red
                                        : Colors.transparent,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter confirm password';
                                    } else if (value.length < 6) {
                                      return 'Please enter valid confirm password';
                                    } else if (value != password.text) {
                                      return 'Password not match with Confirm password';
                                    }
                                    return null;
                                  },
                                  // onChanged: (value) {
                                  //   if (value.isEmpty || value == null) {
                                  //     isMobileNumber = false;
                                  //   } else if (value.length < 8) {
                                  //     isMobileNumber = false;
                                  //   } else {
                                  //     isMobileNumber = true;
                                  //   }
                                  //   setState(() {});
                                  // },
                                ),
                                SizedBox(height: 20),
                                AppOutlineButton(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    fontSize: 16,
                                    textColor: Colors.red,
                                    label: 'Reset Password',
                                    color: AppColors.TEXT_DARK,
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        dynamic res = await auth.resetPassword(
                                            otp.text,
                                            confirmPassword.text,
                                            widget.userId);
                                        if (res['status']) {
                                          NavigationService
                                              .navigateToReplacement(
                                                  Routes.login);
                                        } else {
                                          _scaffoldKey.currentState
                                              .showSnackBar(new SnackBar(
                                                  content: new Text(
                                                      res['message'])));
                                        }
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     NavigationService.navigateTo(Routes.register);
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 20),
                      //     child: Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child: Text(
                      //         'Create Account?',
                      //         style:
                      //             TextStyle(fontSize: 16, color: AppColors.TEXT_DARK),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
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
