// ignore_for_file: prefer__ructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/ui_helpers.dart';

import '../../main.dart';

class Slide0 extends StatefulWidget {
  final String title;
  final String subTitle;
  @override
  State<Slide0> createState() => _Slide0State();

  Slide0({this.title, this.subTitle});
}

class _Slide0State extends State<Slide0> {
  final _user = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserController>(context, listen: false);
    if (user.name != null) {
      _user.text = user.name;
    }
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() async {
    // DateTime now = DateTime.now();
    // if (currentBackPressTime == null ||
    //     now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   CommonFunction.showToast("Press again to exit");
    //   // Fluttertoast.showToast(msg: exit_warning);
    //   return Future.value(false);
    // }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, user, snapshot) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hey ${locator<AppPrefs>().userName.getValue()}!',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                UIHelper.verticalSpace(10.0),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
                UIHelper.verticalSpace(30.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    widget.subTitle,
                    // "We are happy you have taken the  first step towards healthier you. We need a few details to kickstart your journey.",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    softWrap: true,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(2.0),
                //   child: AnimatedContainer(
                //     curve: Curves.easeIn,
                //     duration: Duration(
                //       milliseconds: 1000,
                //     ),
                //     transform: Matrix4.translationValues(0, 0, 1),
                //     width: MediaQuery.of(context).size.width * 0.85,
                //     child: TextField(
                //       onChanged: (val) {
                //         user.setValue(name: val);
                //       },
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //       controller: _user,
                //       cursorColor: AppColors.TEXT_DARK,
                //       decoration: InputDecoration(
                //         helperText: "Enter Name",
                //         helperStyle: TextStyle(
                //           color: Colors.white,
                //         ),
                //         enabledBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                //         ),
                //         focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xffffffff)),
                //         ),
                //         border: UnderlineInputBorder(
                //           borderSide: BorderSide(color: Color(0xffffffff)),
                //         ),
                //         suffixIcon: IconButton(
                //           onPressed: () => _user.clear(),
                //           icon: Icon(
                //             Icons.clear,
                //             color: Color(0xffffffff),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
