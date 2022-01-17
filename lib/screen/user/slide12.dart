import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';

import '../../main.dart';

class Slide12 extends StatefulWidget {
  Slide12({Key key}) : super(key: key);

  @override
  _Slide12State createState() => _Slide12State();
}

class _Slide12State extends State<Slide12> {
  bool _value = false;
  String type1 = "";
  String type2 = "";
  @override
  void initState() {
    super.initState();
    type1 = context.read<UserController>().type1;
    type2 = context.read<UserController>().type2;
  }

  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    UserController user = Provider.of<UserController>(context);
    return Container(
      child: ListView(
        children: [
          Text(
            "What is your fitness goal?",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: store.dprefType1.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    type1 = store.dprefType1.data[index].uid;
                    user.setValue(type1: type1);
                    locator<AppPrefs>().type1.setValue(type1);
                  });
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: type1 != store.dprefType1.data[index].uid
                                ? Color(0xFFCBD4DE)
                                : AppConstants.primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(2),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: type1 != store.dprefType1.data[index].uid
                              ? Colors.transparent
                              : AppConstants.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      store.dprefType1.data[index].value,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              );

              // ListTile(
              //   contentPadding:
              //       EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              //   dense: true,
              //   title: Text(
              //     store.dprefType1.data[index].value,
              //     style: TextStyle(
              //       fontSize: 12.0,
              //       color: Colors.white,
              //     ),
              //   ),
              //   leading: Radio(
              //     value: store.dprefType1.data[index].id,
              //     groupValue: dval,
              //     onChanged: (value) {
              //       setState(() {
              //         dval = value;
              //       });
              //     },
              //     activeColor: AppConstants.primaryColor,
              //   ),
              // );
            },
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "What is your diet preference?",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: store.dprefType2.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    type2 = store.dprefType2.data[index].uid;
                    user.setValue(type2: type2);
                    locator<AppPrefs>().type2.setValue(type2);
                  });
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(height: 30),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: type2 != store.dprefType2.data[index].uid
                                ? Color(0xFFCBD4DE)
                                : AppConstants.primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(2),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: type2 != store.dprefType2.data[index].uid
                              ? Colors.transparent
                              : AppConstants.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      store.dprefType2.data[index].value,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
