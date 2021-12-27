import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/app_constants.dart';

class Slide5 extends StatefulWidget {
  @override
  State<Slide5> createState() => _Slide5State();
}

class _Slide5State extends State<Slide5> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, user, snapshot) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "What is your current weight?",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                AppConstants.confidentialInfo,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
                maxLines: 5,
                softWrap: true,
              ),
            ),
            // TextField(),
            // Weight(),
            //  SizedBox(height: 70),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
                    ' ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  DefaultTabController(
                    length: 1, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Kg',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: AppConstants.primaryColor,
                          height: 1,
                          width: 100,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Center(
                            child: Weight(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class Weight extends StatefulWidget {
  Weight({Key key}) : super(key: key);

  @override
  _WeightState createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, user, snapshot) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          NumberPicker(
            textStyle: TextStyle(fontSize: 25, color: Colors.white),
            selectedTextStyle: TextStyle(
              fontSize: 45,
              color: AppConstants.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.6),
            ),
            itemHeight: 60,
            value: user.weight,
            minValue: 0,
            maxValue: 150,
            step: 1,
            haptics: true,
            onChanged: (value) {
              user.setValue(weight: value);
            },

            /* onChanged: (value) => setState(() => _currentIntValue = value),*/
          ),
          SizedBox(height: 10),
        ],
      );
    });
  }
}

class WeightLb extends StatefulWidget {
  WeightLb({Key key}) : super(key: key);

  @override
  _WeightLbState createState() => _WeightLbState();
}

class _WeightLbState extends State<WeightLb> {
  double _currentDoubleValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        DecimalNumberPicker(
          textStyle: TextStyle(fontSize: 22),
          selectedTextStyle: TextStyle(
            fontSize: 45,
            color: AppConstants.primaryColor,
          ),
          value: _currentDoubleValue,
          minValue: 0,
          maxValue: 150,
          decimalPlaces: 2,
          onChanged: (value) => setState(() => _currentDoubleValue = value),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
