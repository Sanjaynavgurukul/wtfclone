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
      'name': 'My\n WTF',
      'img': 'assets/images/wtf.png',
      // 'img': 'assets/images/mywtf.jpeg',
    },
    {
      'name': 'My\n Schedule',
      // 'img': 'assets/images/schedule.jpeg',
      'img': 'assets/images/schedule.png',
    },
    {
      'name': 'WTF\n Nutrition',
      // 'img': 'assets/images/nutrition.jpeg',
      'img': 'assets/images/nutrition.png',
    },
    {
      'name': 'Active\n Subscription',
      'img': 'assets/images/active_subscription.png',
      // 'img': 'assets/images/wtf.png',
    },
  ];

  GymStore store;

  navigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        store.changeNavigationTab(index: 2);

        break;
      case 1:
        NavigationService.navigateTo(Routes.mySchedule);
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
        NavigationService.navigateTo(Routes.activeSubscriptionScreen);
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: 4,
          //   primary: false,
          //   itemBuilder: (context, index) => Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 12.0),
          //     child: InkWell(
          //       onTap: () {
          //         navigation(index, context);
          //       },
          //       child: Container(
          //         width: double.infinity,
          //         height: 150.0,
          //         child: Stack(
          //           children: [
          //             GradientImageWidget(
          //               // network: Images.mySchedule,
          //               assets: _itemsList[index]['img'],
          //               boxFit: BoxFit.fill,
          //             ),
          //             Positioned(
          //               bottom: 12.0,
          //               left: 0.0,
          //               right: 0.0,
          //               child: Text(
          //                 _itemsList[index]['name'],
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 26.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: _itemsList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                navigation(index, context);
              },
              child: CategoriesItem(
                itemName: _itemsList[index]['name'],
                img: _itemsList[index]['img'],
                // color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
