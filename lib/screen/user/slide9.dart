import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/ui_helpers.dart';

import '../../main.dart';

class Slide9 extends StatefulWidget {
  @override
  State<Slide9> createState() => _Slide9State();
}

class _Slide9State extends State<Slide9> {
  String bodyType = '';
  List<Map<String, String>> types = [
    {
      'type': 'Lean',
      'image':
          'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/lean.svg'
    },
    {
      'type': 'Skinny',
      'image':
          'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/skinny.svg'
    },
    {
      'type': 'Average',
      'image':
          'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/average.svg'
    },
    {
      'type': 'Athletic',
      'image':
          'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/muscular.svg'
    },
    {
      'type': 'Overweight',
      'image':
          'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/fat.svg'
    },
    {
      'type': 'Heavy',
      'image':
          'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/veryFat.svg'
    },
  ];

  @override
  void initState() {
    final user = Provider.of<UserController>(context, listen: false);
    if (user.bodyType != null && user.bodyType != '') {
      bodyType = user.bodyType;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, user, child) => SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTileCard(
              elevation: 0,
              baseColor: Color(0xff922224),
              expandedColor: Color(0xff922224),
              title: Text('Choose your body type',
                  style: TextStyle(color: Colors.white)),
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff292929),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 0.0,
                      spacing: 12.0,
                      children: types
                          .map((e) => newUI(
                              data: e,
                              selected: bodyType == e['type'],
                              onClick: () {
                                // print('clicked value');
                                setState(() {
                                  bodyType = e['type'];
                                  user.setValue(bodyType: e['type']);
                                });
                              }))
                          .toList()),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget newUI(
      {Function onClick, Map<String, String> data, bool selected = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onClick,
        child: Container(
          child: Text(
            data['type'] ?? 'No Type',
            style: TextStyle(color: selected ? Colors.black : Colors.white),
          ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: selected ? Colors.white : Colors.transparent,
              border: Border.all(width: 1, color: Colors.white)),
        ),
      ),
    );
  }

  Widget oldUI(UserController user) {
    return Column(
      children: [
        Text(
          "Select your body type",
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        UIHelper.verticalSpace(20.0),
        Container(
          height: Get.height * 0.6,
          width: Get.width,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: types.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => _item(
              title: types[index]['type'],
              onPress: () {
                setState(() {
                  bodyType = types[index]['type'];
                  print('Body Type: ${types[index]}');
                  user.setValue(bodyType: types[index]['type']);
                });
              },
              isSelected: bodyType == types[index]['type'],
              image: types[index]['image'],
            ),
          ),
        ),
        UIHelper.verticalSpace(8.0),
        Text(
          AppConstants.confidentialInfo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            color: AppColors.TEXT_DARK,
          ),
        ),
      ],
    );
  }

  _item({title, isSelected, onPress, String image}) {
    return InkWell(
      onTap: onPress,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100.0,
                width: 120.0,
                // alignment: Alignment.centerRight,
                child: SvgPicture.asset(image),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          if (isSelected)
            AnimatedPositioned(
              bottom: 56.0,
              right: 24.0,
              duration: Duration(
                milliseconds: 650,
              ),
              curve: Curves.easeInOutCubic,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
            )
        ],
      ),
    );
  }
}
