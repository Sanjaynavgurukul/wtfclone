import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/preamble_helper.dart';
import 'package:wtf/helper/routes.dart';

import '../../main.dart';
import 'more_categories/categories_item.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map> _itemsList = [
    {
      'name': 'Gym',
      'img': 'assets/images/fitness.png',
    },
    {
      'name': 'Daily Schedule',
      'img': 'assets/images/schedule.png',
    },
    {
      'name': 'Nutrition',
      'img': 'assets/images/nutrition_2.png',
    },
    {
      'name': 'Personal Training',
      'img': 'assets/images/personal_training.png',
    },
    {
      'name': 'Live Class',
      'img': 'assets/images/live_class.png',
    },
    {
      'name': 'Fitness Activity',
      'img': 'assets/images/fitness_activity.png',
    },
    {
      'name': 'Meditation',
      'img': 'assets/images/meditation.png',
    },
  ];

  GymStore store;

  navigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        NavigationService.navigateTo(Routes.discoverScreen);
        break;
      case 1:
        context.read<GymStore>().getActiveSubscriptions(context: context);
        // NavigationService.navigateTo(Routes.mySchedule);
        NavigationService.pushName(Routes.dateWorkoutList);
        break;
      case 2:
        print(
            'checking is available --- ${context.read<GymStore>().preambleModel.diet_category_id}');
        bool hasPreamble = locator<AppPrefs>().memberAdded.getValue();
        if (hasPreamble) {
          NavigationService.navigateTo(Routes.nutritionScreen);
        } else {
          // preambleWarningDialog();
          PreambleHelper.showPreambleWarningDialog(
              context: context);
        }
        break;
      case 3:
        context.read<GymStore>().getActiveSubscriptions(context: context);
        NavigationService.navigateTo(Routes.ptClassPage);
        break;
      case 4:
        NavigationService.navigateTo(Routes.allLiveAddons);
        break;
      case 5:
        NavigationService.navigateTo(Routes.poweredPages);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 0.0,
          spacing: 12.0,
          children: _itemsList
              .map((e) => newUI(
                      data: e,
                      onClick: () => navigation(_itemsList.indexOf(e), context))
                  // (e) => CategoriesItem(
                  //   itemName: e['name'],
                  //   img: e['img'],
                  //   onTap: () => navigation(_itemsList.indexOf(e), context),
                  // ),
                  )
              .toList(),
        ),
      ),
    );
  }

  Widget newUI({Map data, Function onClick}) {
    return Container(
      width: 76,
      margin: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 76,
            height: 76,
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                border: Border.all(width: 1, color: Colors.white)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  onTap: onClick,
                  child: Container(
                      margin: EdgeInsets.all(data['name'] == "Meditation"
                          ? 14
                          : data['name'] == 'Fitness Activity'
                              ? 12
                              : 0),
                      child: Image.asset(data['img'])),
                ),
                if (data['name'] == "Meditation")
                  Container(
                    width: 76,
                    height: 76,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: AppConstants.bgColor.withOpacity(0.5)),
                    child: Text(
                      'Coming\nSoon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
          ),
          Text(
            data['name'],
            maxLines: 5,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
