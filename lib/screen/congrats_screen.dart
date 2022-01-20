import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/strings.dart';

class CongtarsScreen extends StatelessWidget {
  final String coin;
  const CongtarsScreen({Key key, this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .85,
                  width: double.infinity,
                  child: Image.asset('assets/images/congtsbg.png'),
                ),
              ),
              Positioned(
                bottom: 200,
                left: 110,
                child: Image.asset('assets/images/congtas_coin.png'),
              ),
              Positioned(
                bottom: 205,
                left: 170,
                child: RichText(
                    text: TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: " " + args['coin'] + " Coins" + "\n",
                    style: TextStyle(
                      fontFamily: Fonts.ROBOTO,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: " Collected",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ])),
              )
            ],
          ),
          Container(
            child: TextButton(
              onPressed: () {
                NavigationService.goBack;
              },
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                  color: AppConstants.bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: Text(
                    "Back To Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
