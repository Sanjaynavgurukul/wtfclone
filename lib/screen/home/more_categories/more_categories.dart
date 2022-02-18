import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';

import 'categories_item.dart';

class MoreCategories extends StatelessWidget {
  MoreCategories({Key key}) : super(key: key);

  List<Map> _itemsList = [
    {
      'name': 'WTF\n Community',
      'img': 'assets/images/community.png',
    },
    {
      'name': 'WTF\n Guru\'s Pro',
      'img': 'assets/images/guru.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0),
          //   child: Text(
          //     'More Categories',
          //     style: TextStyle(fontSize: 22, color: Colors.white),
          //   ),
          // ),
          Divider(
            thickness: 1.2,
            color: Colors.white10,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: AppConstants.primaryColor,
              child: Text(
                'Coming Soon Features',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: _itemsList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // if (_itemsList[index]['name'] == "WTF\n Coins") {
                //
                // } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: EdgeInsets.zero,
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        height: 250.0,
                        child: Image.asset('assets/images/coming_soon.png'),
                      ),
                    );
                  },
                );
                // }
              },
              child: CategoriesItem(
                itemName: _itemsList[index]['name'],
                img: _itemsList[index]['img'],
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.white10,
          ),
        ],
      ),
    );
  }
}
