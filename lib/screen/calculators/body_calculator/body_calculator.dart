import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';

class BodyCalculator extends StatelessWidget {
  const BodyCalculator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          'WTF Calculators',
          style: AppConstants.customStyle(
            color: Colors.white,
            size: 16.0,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OpenCalButon(
            onTap: () {
              NavigationService.navigateTo(Routes.calorieCounter);
            },
            label: 'How much should I eat?',
            image: Images.calorieCal,
          ),
          SizedBox(
            height: 40,
          ),
          OpenCalButon(
            onTap: () {
              NavigationService.navigateTo(Routes.bodyFatCal);
            },
            label: 'How fat am I?',
            image: Images.bodyFatCal,
          ),
          SizedBox(
            height: 40,
          ),
          OpenCalButon(
            onTap: () {
              NavigationService.navigateTo(Routes.bmrCalculator);
            },
            label: 'How many calories am I burning?r',
            image: Images.bodyCal,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class OpenCalButon extends StatelessWidget {
  final GestureTapCallback onTap;
  final String label;
  final String image;
  const OpenCalButon({
    Key key,
    this.label,
    this.onTap,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.0,
        width: 110.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: AppConstants.bgColor),
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/$image.svg'),
            UIHelper.verticalSpace(10.0),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
