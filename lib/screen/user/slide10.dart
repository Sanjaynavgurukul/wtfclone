import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/screen/calculators/bmr_calculator/bmr_state.dart';

import '../../main.dart';

class Slide10 extends StatefulWidget {
  @override
  State<Slide10> createState() => _Slide10State();
}

class _Slide10State extends State<Slide10> {
  BmrState bmrState;
  UserController users;
  @override
  void initState() {
    final user = Provider.of<UserController>(context, listen: false);
    if (locator<AppPrefs>().gender.getValue() == 'male') {
      context.read<BmrState>().bmrForMen(
            height: 30.48 * user.heightFeet,
            weight: user.weight,
            age: user.age,
            context: context,
            fromAuth: true,
          );
    } else {
      context.read<BmrState>().bmrForWoMen(
            height: 30.48 * user.heightFeet,
            weight: user.weight,
            age: user.age,
            context: context,
            fromAuth: true,
          );
    }
    print(
        'update member---->>>> ${locator<AppPrefs>().updateMemberData.getValue()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    users = context.watch<UserController>();
    bmrState = context.watch<BmrState>();

    return Consumer<UserController>(
      builder: (context, store, child) => Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "To reach ${store.goalWeight.toStringAsFixed(2)} kg per week you need to ?",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Eat ',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  children: [
                    TextSpan(
                      text: bmrState.bmrResult,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' calories every day',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: 'Drink ',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  children: [
                    TextSpan(
                      text: '4000 ml',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' of water every day',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: 'Walk minimum ',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  children: [
                    TextSpan(
                      text: '8000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' steps every day',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: 'Burn ',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  children: [
                    TextSpan(
                      text: '500',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' calories every day',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              // TextField(),
            ],
          ),
        ],
      ),
    );
  }
}
