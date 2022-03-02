import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';

import 'more_categories/categories_item.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map> _itemsList = [
    {
      'name': 'Fitness',
      'img': 'assets/images/fitness.png',
    },
    {
      'name': 'Live Class',
      'img': 'assets/images/live_class.png',
    },
    {
      'name': 'Nutrition',
      'img': 'assets/images/nutrition_2.png',
    },
    {
      'name': 'Daily Schedule',
      'img': 'assets/images/daily_schedule.png',
    },
    {
      'name': 'Personal Training',
      'img': 'assets/images/personal_training.png',
    },
  ];

  GymStore store;

  navigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        // store.changeNavigationTab(index: 2);
        // store.changeNavigationTab(index: 3);
        // NavigationService.navigateTo(Routes.mySchedule);
        context.read<GymStore>().getDiscoverNow(
              context: context,
              type: 'gym',
            );
        NavigationService.navigateTo(Routes.discoverNow);
        break;
      case 1:
        NavigationService.navigateTo(Routes.allLiveAddons);
        break;
      // Navigator.pushNamed(context, Routes.mySubscription);
      // break;
      case 2:
        NavigationService.navigateTo(Routes.myDietSchedule);
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return Dialog(
        //       insetPadding: EdgeInsets.zero,
        //       elevation: 0.0,
        //       backgroundColor: Colors.transparent,
        //       child: Container(
        //         height: 250.0,
        //         child: Image.asset('assets/images/coming_soon.png'),
        //       ),
        //     );
        //   },
        // );
        break;
      case 3:
        context.read<GymStore>().getActiveSubscriptions(context: context);
        NavigationService.navigateTo(Routes.mySchedule);
        break;
      case 4:
        context.read<GymStore>().getActiveSubscriptions(context: context);
        NavigationService.navigateTo(Routes.ptClassPage);
        break;
      // case 5:
      //   context.read<GymStore>().getMemberSubscriptions(context: context);
      //   Navigator.pushNamed(context, Routes.mySubscription);
      //   break;
      default:
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
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 0.0,
          spacing: 12.0,
          children: _itemsList
              .map(
                (e) => CategoriesItem(
                  itemName: e['name'],
                  img: e['img'],
                  onTap: () => navigation(_itemsList.indexOf(e), context),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
