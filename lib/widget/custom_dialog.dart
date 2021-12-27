import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String b1Text;
  final String b2Text;
  final Function(String) b1Tap;
  final Function(String) b2Tap;

  CustomDialog({
    this.title,
    this.message,
    this.b1Text,
    this.b2Text,
    this.b1Tap,
    this.b2Tap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.PRIMARY_COLOR,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title,
                style: AppConstants.customStyle(
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            UIHelper.verticalSpace(10.0),
            Text(
              message,
              style: AppConstants.customStyle(
                color: Colors.white,
                size: 14.0,
              ),
            ),
            UIHelper.verticalSpace(25.0),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: b1Text,
                    onTap: () => b1Tap('cancel'),
                    bgColor: Colors.white,
                    textColor: AppConstants.red,
                  ),
                ),
                UIHelper.horizontalSpace(8.0),
                Expanded(
                  child: CustomButton(
                    text: b2Text,
                    onTap: () => b2Tap('yes'),
                    textColor: Colors.white,
                    bgColor: AppConstants.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
