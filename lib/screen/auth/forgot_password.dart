import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/auth_controller.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/global.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/screen/auth/reset_password.dart';
import 'package:wtf/widget/app_button.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final mobileNumber = TextEditingController();
  final email = TextEditingController();

  bool isMobileNumber = false;
  bool isEmail = false;
  int _radioValue = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Forgot Password',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Form(
        key: formKey,
        child: Consumer<AuthController>(builder: (context, auth, snapshot) {
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Select account verification type',
                                  style: TextStyle(color: AppColors.TEXT_DARK),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.white),
                                      child: Radio(
                                        value: 0,
                                        activeColor: Colors.white,
                                        groupValue: _radioValue,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioValue = val;
                                          });
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Mobile Number",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.white),
                                      child: Radio(
                                        value: 1,
                                        activeColor: Colors.white,
                                        groupValue: _radioValue,
                                        onChanged: (val) {
                                          setState(() {
                                            _radioValue = val;
                                          });
                                        },
                                      ),
                                    ),
                                    Text(
                                      "E-mail address",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                _radioValue == 0
                                    ? UnderlineTextField(
                                        // inputFormatters: [
                                        //   Global.amountValidator,
                                        //   LengthLimitingTextInputFormatter(10),
                                        // ],
                                        fontFamily: Fonts.ROBOTO,
                                        keyboardType: TextInputType.phone,
                                        hintText: 'Mobile Number',
                                        controller: mobileNumber,
                                        maxLines: 1,
                                        maxLength: 10,
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
                                          } else if (value.length < 8) {
                                            isMobileNumber = false;
                                          } else {
                                            isMobileNumber = true;
                                          }
                                          setState(() {});
                                        },
                                      )
                                    : UnderlineTextField(
                                        // inputFormatters: [],
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        hintText: 'E-mail address',
                                        controller: email,
                                        maxLines: 1,
                                        suffix: Icon(
                                          Icons.check,
                                          color: isMobileNumber
                                              ? Colors.red
                                              : Colors.transparent,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter e-mail address';
                                          } else if (!Global.validateEmail(
                                              value)) {
                                            return 'Please enter valid e-mail address';
                                          }
                                          return null;
                                        },
                                      ),

                                SizedBox(height: 20),
                                AppOutlineButton(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  fontSize: 16,
                                  textColor: Colors.red,
                                  label: 'Send OTP',
                                  color: Colors.white,
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      dynamic res = await auth.forgotPassword(
                                          _radioValue == 0
                                              ? mobileNumber.text.toString()
                                              : email.text,
                                          _radioValue == 0
                                              ? "mobile"
                                              : "email");
                                      if (res['status']) {
                                        String _otp = res['data']['otp'];
                                        String userId = res['data']['user_id'];
                                        print("Otp is $_otp");

                                        Navigator.of(context).pushReplacement(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    ResetPasswordPage(
                                                        _otp, userId)));
                                        // NavigationService.navigateToReplacement(
                                        //     Routes.resetPaswword);
                                      } else {
                                        _scaffoldKey.currentState.showSnackBar(
                                            new SnackBar(
                                                content:
                                                    new Text(res['message'])));
                                      }
                                    }
                                  },
                                ),
                                // SizedBox(height: 30),

                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.pop(context);
                                //   },
                                //   child: Padding(
                                //     padding:
                                //         const EdgeInsets.symmetric(vertical: 20),
                                //     child: Align(
                                //       alignment: Alignment.center,
                                //       child: Text(
                                //         'Back To Login?',
                                //         style: TextStyle(
                                //             fontSize: 16,
                                //             color: AppColors.TEXT_DARK),
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                auth.isLoading ? LoadingWithBackground() : Container()
              ],
            ),
          );
        }),
      ),
    );
  }
}
