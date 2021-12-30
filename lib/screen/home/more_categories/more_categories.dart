import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';

import 'categories_item.dart';

class MoreCategories extends StatelessWidget {
  MoreCategories({Key key}) : super(key: key);

  List<Map> _itemsList = [
    {
      'name': 'WTF\n Coins',
      'img': 'assets/images/coins.png',
    },
    {
      'name': 'WTF\n Community',
      'img': 'assets/images/community.png',
    },
    {
      'name': 'WTF\n Gurus',
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
          GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: _itemsList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (_itemsList[index]['name'] == "WTF\n Coins") {
                  store.changeNavigationTab(index: 3);
                } else {
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
                }
              },
              child: CategoriesItem(
                itemName: _itemsList[index]['name'],
                img: _itemsList[index]['img'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
