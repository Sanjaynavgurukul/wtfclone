import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/screen/body_calculator/bodyFat_state.dart';
import 'package:wtf/widget/slide_button.dart';

class BodyFatCalResult extends StatelessWidget {
  const BodyFatCalResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BodyState bodyState = context.watch<BodyState>();
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'Body Fat Calculator',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SlideButton(
        'Continue',
        () async {
          // await bodyState.saveProgress(context: context);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Image.asset(
            'assets/images/achieve.png',
            height: MediaQuery.of(context).size.height * .2,
          ),
          Divider(
            thickness: 2,
            color: Colors.white12,
            indent: 20,
            endIndent: 20,
            height: 20,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Your Body Fat Calculator Result',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Consumer<BodyState>(
              builder: (context, data, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Body Fat = ${data.bodyFat.toStringAsFixed(3)} %',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    UIHelper.verticalSpace(12.0),
                    Image.asset('assets/images/fat_scale.png'),
                    UIHelper.verticalSpace(20.0),
                    Text(
                      'BMI = ${bodyState.bmiResult.toStringAsFixed(3)} Kg/m²',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _text(text) => Padding(
      padding: EdgeInsets.only(left: 30, bottom: 5),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ));

  _subText(text) => Padding(
      padding: EdgeInsets.only(left: 30, bottom: 20),
      child: Text(
        text,
        style: TextStyle(color: Colors.red),
      ));
}
