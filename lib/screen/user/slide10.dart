import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/model/preamble_model.dart';
import 'package:wtf/screen/calculators/bmr_calculator/bmr_state.dart';

import '../../main.dart';

class Slide10 extends StatefulWidget {
  @override
  State<Slide10> createState() => _Slide10State();
}

class _Slide10State extends State<Slide10> {
  BmrState bmrState;
  GymStore users;
  @override
  void initState() {
    final user = Provider.of<GymStore>(context, listen: false);
    // if (locator<AppPrefs>().gender.getValue() == 'male') {
    if(user.preambleModel.gender.toLowerCase() == 'male'){
      context.read<BmrState>().bmrForMen(
        height: 30.48 * (user.preambleModel.heightInCm ? user.preambleModel.heightCm:user.preambleModel.heightFeet),
        weight: user.preambleModel.weightInKg?user.preambleModel.weightKg:user.preambleModel.weightInLbs,
        age: user.preambleModel.age,
        context: context,
        fromAuth: user.preambleFromLogin,
      );
    } else {
      context.read<BmrState>().bmrForWoMen(
        height: 30.48 * (user.preambleModel.heightInCm ? user.preambleModel.heightCm:user.preambleModel.heightFeet),
        weight: user.preambleModel.weightInKg?user.preambleModel.weightKg:user.preambleModel.weightInLbs,
        age: user.preambleModel.age,
        context: context,
        fromAuth: user.preambleFromLogin,
      );
    }
    // }
    // print(
    //     'update member---->>>> ${locator<AppPrefs>().updateMemberData.getValue()}');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    users = context.watch<GymStore>();
    bmrState = context.watch<BmrState>();

    return Consumer<GymStore>(
      builder: (context, store, child){
        store.preambleModel.bmr_result = bmrState.bmrResult;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 40,bottom: 20,left: 18,right: 18),
              color: Color(0xff922224),
              child: Text(
                "To reach ${store.preambleModel.goalWeight.toStringAsFixed(2)} kg per week you need to ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(left: 18,right: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: item(image: 'assets/gif/eat_outline.gif',value: ' calories every day',count: '${bmrState.bmrResult}',label: 'Eat'),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 1,
                    child: item(image: 'assets/gif/glass-water-outline.gif',value: ' of water every day',count: '4000 ml',label: 'Drink'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 18,right: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: item(image: 'assets/gif/walking-person-outline.gif',value: ' steps every day',count: '8000',label: 'Walk minimum'),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 1,
                    child: item(image: 'assets/gif/burn_outline.gif',value: ' calories every day',count: '500',label: 'Burn'),
                  ),
                ],
              ),
            )
          ],
        );
      }
    );
  }

  Widget item({String image, String label, String count,String value}){
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white

          ),
          child: Column(
            children: [
              Image.asset(image??'assets/gif/upcoming.gif',width: 70,height: 70,),SizedBox(height: 8,),Text(label??'No Label',style: TextStyle(color: Colors.black),)
            ],
          ),
        ),SizedBox(height: 12,),
        RichText(
          text: TextSpan(
            text: '',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: count??'0', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: value??' no value'),
            ],
          ),
        )
      ],
    );
  }

  // Widget oldUI(UserController store){
  //   return  Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Text(
  //         "To reach ${store.goalWeight.toStringAsFixed(2)} kg per week you need to ?",
  //         style: TextStyle(
  //           fontSize: 24.0,
  //           color: Colors.white,
  //         ),
  //       ),
  //       SizedBox(height: 20),
  //       RichText(
  //         text: TextSpan(
  //           text: 'Eat ',
  //           style: TextStyle(
  //             fontSize: 14.0,
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //           children: [
  //             TextSpan(
  //               text: bmrState.bmrResult,
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18.0,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' calories every day',
  //               style: TextStyle(
  //                 fontSize: 16.0,
  //                 color: Colors.white.withOpacity(0.8),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 15),
  //       RichText(
  //         text: TextSpan(
  //           text: 'Drink ',
  //           style: TextStyle(
  //             fontSize: 14.0,
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //           children: [
  //             TextSpan(
  //               text: '4000 ml',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18.0,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' of water every day',
  //               style: TextStyle(
  //                 fontSize: 16.0,
  //                 color: Colors.white.withOpacity(0.8),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 15),
  //       RichText(
  //         text: TextSpan(
  //           text: 'Walk minimum ',
  //           style: TextStyle(
  //             fontSize: 14.0,
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //           children: [
  //             TextSpan(
  //               text: '8000',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18.0,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' steps every day',
  //               style: TextStyle(
  //                 fontSize: 16.0,
  //                 color: Colors.white.withOpacity(0.8),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 15),
  //       RichText(
  //         text: TextSpan(
  //           text: 'Burn ',
  //           style: TextStyle(
  //             fontSize: 14.0,
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //           children: [
  //             TextSpan(
  //               text: '500',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18.0,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' calories every day',
  //               style: TextStyle(
  //                 fontSize: 16.0,
  //                 color: Colors.white.withOpacity(0.8),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       // TextField(),
  //     ],
  //   );
  // }

}