import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/entry_field.dart';
import 'package:wtf/widget/progress_loader.dart';
import 'package:wtf/widget/slide_button.dart';

class OtpVerifySheet extends StatefulWidget {
  final Function(bool) onVerified;
  final String uid;

  OtpVerifySheet({
    this.onVerified,
    this.uid,
  });

  @override
  _OtpVerifySheetState createState() => _OtpVerifySheetState();
}

class _OtpVerifySheetState extends State<OtpVerifySheet> {
  TextEditingController otpController = TextEditingController();
  GymStore store;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Container(
      height: 380.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: isLoading
          ? Center(
              child: Loading(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bravo!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  UIHelper.verticalSpace(4.0),
                  Text(
                    'You have taken one more step towards a fitter you with WTF!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  UIHelper.verticalSpace(24.0),
                  Text(
                    'We have sent an OTP to your Trainer for authenticating this workout.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                    ),
                  ),
                  UIHelper.verticalSpace(13.0),
                  EntryField(
                    // label: 'One Time Password',
                    hint: 'Enter OTP',

                    controller: otpController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    textColor: Colors.white,
                    barColor: Colors.white,
                  ),
                  UIHelper.verticalSpace(14.0),
                  SlideButton(
                    'Verify OTP',
                    () async {
                      if (otpController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        Map<String, dynamic> body = {
                          'otp': otpController.text,
                          'uid': widget.uid,
                        };
                        bool isVerified = await store.workoutOtpVerification(
                          context: context,
                          body: body,
                        );
                        if (isVerified) {
                          Navigator.pop(context, isVerified);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          FlashHelper.errorBar(
                            context,
                            message:
                                'OTP Verification Failed, Please try again',
                          );
                        }
                      } else {
                        FlashHelper.informationBar(
                          context,
                          message: 'Please enter otp first',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
