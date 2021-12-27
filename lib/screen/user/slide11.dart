import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';

class Slide11 extends StatefulWidget {
  @override
  State<Slide11> createState() => _Slide11State();
}

class _Slide11State extends State<Slide11> {
  String activeType = '';

  List<Map<String, String>> types = [
    {'text': 'Almost never', 'value': 'New to Fitness'},
    {'text': 'Sometimes', 'value': 'Worked out before'},
    {'text': 'Actively', 'value': 'Experienced'},
    // {
    //   'title': 'Little or No Activity',
    //   'description':
    //       'Mostly sitting through the day (eg. Desk Job, Bank Teller)',
    //   'image':
    //       'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/lean.svg'
    // },
    // {
    //   'title': 'Lightly Active',
    //   'description':
    //       'Mostly standing through the day (eg. Sales Associate, Teacher)',
    //   'image':
    //       'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/skinny.svg'
    // },
    // {
    //   'title': 'Moderately Active',
    //   'description':
    //       'Mostly walking or doing physical activities through the day (eg. Tour Guide, Waiter)',
    //   'image':
    //       'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/average.svg'
    // },
    // {
    //   'title': 'Very Active',
    //   'description':
    //       'Mostly doing heavy activities through the day (eg. Gym Instructor, Construction Worker)',
    //   'image':
    //       'assets/svg/${locator<AppPrefs>().gender.getValue().toLowerCase()}/muscular.svg'
    // },
  ];

  @override
  void initState() {
    final user = Provider.of<UserController>(context, listen: false);
    if (user.activeType != null && user.activeType != '') {
      activeType = user.activeType;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, user, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Text(
                  "I workout...",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpace(40.0),
            Container(
              height: Get.height * 0.7,
              width: Get.width,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: types.length,
                itemBuilder: (context, index) => _item(
                  title: types[index]['value'],
                  subtitle: types[index]['text'],
                  onPress: () {
                    setState(() {
                      activeType = types[index]['value'];
                      print('Body Type: ${types[index]}');
                      user.setValue(
                        activeType: types[index]['value'],
                      );
                    });
                  },
                  isSelected: activeType == types[index]['value'],
                  image: types[index]['image'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _item({title, subtitle, isSelected, onPress, String image}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 10.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppConstants.white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppConstants.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(4.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppConstants.primaryColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppConstants.primaryColor
                      : AppConstants.white,
                  width: 1.0,
                ),
              ),
              child: Icon(
                Icons.check,
                color: isSelected ? AppConstants.white : Colors.transparent,
                size: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
