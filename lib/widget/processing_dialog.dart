import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/entry_field.dart';

class ProcessingDialog extends StatefulWidget {
  final String message;
  ProcessingDialog({this.message});

  @override
  _ProcessingDialogState createState() => _ProcessingDialogState();
}

class _ProcessingDialogState extends State<ProcessingDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      elevation: 5.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                AppConstants.red,
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Text(
              widget.message,
              style: AppConstants.customStyleSpacing(
                size: 14.0,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextDialog extends StatefulWidget {
  CustomTextDialog({Key key});

  @override
  _CustomTextDialogState createState() => _CustomTextDialogState();
}

class _CustomTextDialogState extends State<CustomTextDialog> {
  TextEditingController textEditingController = TextEditingController();
  String value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Text(
              'Please Enter Other reason',
              style: AppConstants.customStyle(
                color: Colors.white,
                size: 18.0,
              ),
            ),
            UIHelper.verticalSpace(10.0),
            EntryField(
              controller: textEditingController,
              keyboardType: TextInputType.text,
              barColor: Colors.white,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
              textColor: Colors.white,
              label: 'Other',
              hint: 'Specify your reason here',
            ),
            UIHelper.verticalSpace(25.0),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                    bgColor: Colors.white,
                    textColor: AppConstants.red,
                  ),
                ),
                UIHelper.horizontalSpace(8.0),
                Expanded(
                  child: CustomButton(
                    text: 'Next',
                    onTap: () {
                      Navigator.pop(context, value);
                    },
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

class SubscriptionAlreadyPresent extends StatefulWidget {
  final String title;
  final String message;
  final String gymName;
  final GestureTapCallback cancelTapped;
  final GestureTapCallback nextTapped;

  SubscriptionAlreadyPresent({
    this.title,
    this.message,
    this.cancelTapped,
    this.nextTapped,
    this.gymName,
  });

  @override
  _SubscriptionAlreadyPresentState createState() =>
      _SubscriptionAlreadyPresentState();
}

class _SubscriptionAlreadyPresentState
    extends State<SubscriptionAlreadyPresent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      elevation: 5.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Attention!!',
            style: AppConstants.customStyleSpacing(
              size: 14.0,
              weight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          RichText(
            text: TextSpan(
              text: 'You have an Regular subscription of ',
              style: AppConstants.customStyleSpacing(
                size: 14.0,
                weight: FontWeight.normal,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: widget.gymName,
                  style: AppConstants.customStyleSpacing(
                    size: 15.0,
                    weight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text:
                      ', and this is a different gym. Are you sure you want to proceed ?',
                  style: AppConstants.customStyleSpacing(
                    size: 14.0,
                    weight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(16.0),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  onTap: widget.cancelTapped,
                  bgColor: Colors.white,
                  textColor: AppConstants.red,
                ),
              ),
              UIHelper.horizontalSpace(8.0),
              Expanded(
                child: CustomButton(
                  text: 'Proceed',
                  onTap: widget.nextTapped,
                  textColor: Colors.white,
                  bgColor: AppConstants.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
