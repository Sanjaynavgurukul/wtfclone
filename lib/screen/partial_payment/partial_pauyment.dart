import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/screen/common_widgets/time_line.dart';

import '../../main.dart';

class PartialPayment extends StatefulWidget {
  static const String routeName = '/partialPayment';
  const PartialPayment({Key key}) : super(key: key);

  @override
  State<PartialPayment> createState() => _PartialPaymentState();
}

class _PartialPaymentState extends State<PartialPayment> {
  //Local Variables :D
  GymStore store;

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.BACK_GROUND_BG,
        title: Text('Partial Payment'),
        actions: [
          TextButton(
            onPressed:(){},
            child: Text('Pay All',style:TextStyle(color: Colors.white)),
          )
        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          print('MemberId = ${locator<AppPrefs>().memberId.getValue()}');
          print('MemberId subscription = ${store.activeSubscriptions.data.uid}');
        },
        child: Icon(Icons.add),
      ),
      body:Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            Timeline(
              padding: EdgeInsets.all(0),
              lineColor: AppConstants.boxBorderColor,
              children: <Widget>[
                ListTile(
                  leading: Image.asset(
                    'assets/images/calender.png',
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                      'First Payment',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
                  subtitle: Text('some amount'),
                  trailing: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 12,right: 12,top: 6,bottom: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border:Border.all(width:1,color:AppConstants.bgColor)
                      ),
                      child: Text("Pay Now"),
                    ),
                  ),
                ),
              ],
              indicators: <Widget>[
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  void processToPay(){

  }

}
