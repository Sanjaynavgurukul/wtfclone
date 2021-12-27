import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/screen/body_calculator/body_calculator.dart';

class MoreCategories extends StatelessWidget {
  const MoreCategories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' More Categories :',
            style: AppConstants.customStyle(
              color: Colors.white,
              size: 18.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          OpenCalButon(
            onTap: () {
              NavigationService.navigateTo(Routes.bodyCalculator);
            },
            label: 'Body Calculators',
            image: Images.bodyCal,
          ),
        ],
      ),
    );
  }
}
