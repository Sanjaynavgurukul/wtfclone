import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';

class Slide12 extends StatefulWidget {
  Slide12({Key key}) : super(key: key);

  @override
  _Slide12State createState() => _Slide12State();
}

class _Slide12State extends State<Slide12> {
  bool _value = false;
  int dval = -1;
  int pval = -1;
  @override
  Widget build(BuildContext context) {
    GymStore store = Provider.of<GymStore>(context);
    return Container(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "What kind of a diet you are looking for?",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
          // Row(
          //   children: <Widget>[
          //     Container(
          //       height: 15,
          //       width: 15,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //             color: _value == true
          //                 ? Color(0xFFCBD4DE)
          //                 : AppConstants.primaryColor),
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(30),
          //         ),
          //       ),
          //       child: Container(
          //         margin: EdgeInsets.all(2),
          //         width: 5,
          //         height: 5,
          //         decoration: BoxDecoration(
          //           color: _value == true
          //               ? Colors.transparent
          //               : AppConstants.primaryColor,
          //           borderRadius: BorderRadius.all(Radius.circular(30)),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 10),
          //     Text("Bulky")
          //   ],
          // ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Radio(
          //       value: 1,
          //       groupValue: dval,
          //       onChanged: (value) {
          //         setState(() {
          //           dval = value;
          //         });
          //       },
          //       activeColor: AppConstants.primaryColor,
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Text("Bulky")
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Radio(
          //       value: 1,
          //       groupValue: dval,
          //       onChanged: (value) {
          //         setState(() {
          //           dval = value;
          //         });
          //       },
          //       activeColor: AppConstants.primaryColor,
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Text("Bulky")
          //   ],
          // ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: store.dprefType1.data.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _value == true
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
                        color: _value == true
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
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ],
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
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          //   dense: true,
          //   title: Text(
          //     "Bulky",
          //     style: TextStyle(
          //       fontSize: 12.0,
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: Radio(
          //     value: 1,
          //     groupValue: dval,
          //     onChanged: (value) {
          //       setState(() {
          //         dval = value;
          //       });
          //     },
          //     activeColor: AppConstants.primaryColor,
          //   ),
          // ),
          // ListTile(
          //   dense: true,
          //   title: Text(
          //     "Fit",
          //     style: TextStyle(
          //       fontSize: 12.0,
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: Radio(
          //     value: 2,
          //     groupValue: dval,
          //     onChanged: (value) {
          //       setState(() {
          //         dval = value;
          //       });
          //     },
          //     activeColor: AppConstants.primaryColor,
          //   ),
          // ),
          // ListTile(
          //   dense: true,
          //   title: Text(
          //     "Cut",
          //     style: TextStyle(
          //       fontSize: 12.0,
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: Radio(
          //     value: 3,
          //     groupValue: dval,
          //     onChanged: (value) {
          //       setState(() {
          //         dval = value;
          //       });
          //     },
          //     activeColor: AppConstants.primaryColor,
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          Text(
            "What is your diet preference?",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: store.dprefType2.data.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _value == true
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
                        color: _value == true
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
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
