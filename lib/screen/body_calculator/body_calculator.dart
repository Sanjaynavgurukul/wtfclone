import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';

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
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: 160,
              width: double.infinity,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 160,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppConstants.primaryColor,
                // Colors.red.withOpacity(0.2)
              ],
            ),
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
