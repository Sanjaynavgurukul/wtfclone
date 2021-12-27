import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_controller.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';

class Slide4 extends StatefulWidget {
  @override
  State<Slide4> createState() => _Slide4State();
}

class _Slide4State extends State<Slide4> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("How tall are you ?",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  )),
              SizedBox(height: 10),
              Text(
                AppConstants.confidentialInfo,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
              // TextField(),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ],
          ),
          UIHelper.verticalSpace(50.0),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: selectedIndex,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white54,
                          labelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          indicatorColor: Colors.transparent,
                          onTap: (index) async {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          tabs: [
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0,
                                ),
                                decoration: BoxDecoration(
                                    color: selectedIndex == 0
                                        ? AppConstants.primaryColor
                                        : Colors.transparent),
                                child: Text('Feet / Inches'),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0,
                                ),
                                decoration: BoxDecoration(
                                    color: selectedIndex == 1
                                        ? AppConstants.primaryColor
                                        : Colors.transparent),
                                child: Text('Centimeters'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 240, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: HeightCm(),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Height(),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Height extends StatefulWidget {
  Height({Key key}) : super(key: key);

  @override
  _HeightState createState() => _HeightState();
}

class _HeightState extends State<Height> {
  int _currentIntValue = 160;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        NumberPicker(
          textStyle: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
          selectedTextStyle: TextStyle(
            fontSize: 45,
            color: AppConstants.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: BoxDecoration(
            color: AppConstants.primaryColor.withOpacity(0.6),
          ),
          itemHeight: 60,
          value: _currentIntValue,
          minValue: 0,
          maxValue: 200,
          step: 1,
          haptics: true,
          onChanged: (value) => setState(() => _currentIntValue = value),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class HeightCm extends StatefulWidget {
  HeightCm({Key key}) : super(key: key);

  @override
  _HeightCmState createState() => _HeightCmState();
}

class _HeightCmState extends State<HeightCm> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Consumer<UserController>(builder: (context, user, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            UIHelper.verticalSpace(30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Feet',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                UIHelper.horizontalSpace(80.0),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Inches',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            DecimalNumberPicker(
                textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.white54,
                ),
                selectedTextStyle: TextStyle(
                  fontSize: 45,
                  color: AppConstants.white,
                  fontWeight: FontWeight.bold,
                ),
                integerDecoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.6),
                ),
                decimalDecoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.6),
                ),
                itemHeight: 60,
                value: user.heightFeet,
                minValue: 1,
                maxValue: 9,
                haptics: true,
                decimalPlaces: 2,
                decimalTextMapper: (text) {
                  print('text: $text');
                  int dec = int.tryParse(text);
                  return dec < 12 ? text : '';
                },
                onChanged: (value) {
                  setState(() {
                    user.setValue(heightFeet: value);
                  });
                }

                /*onChanged: (value) => setState(() => _currentDoubleValue = value

                ),*/
                ),
          ],
        );
      }),
    );
  }
}

class DecimalNumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final double value;
  final ValueChanged<double> onChanged;
  final int itemCount;
  final double itemHeight;
  final double itemWidth;
  final Axis axis;
  final TextStyle textStyle;
  final TextStyle selectedTextStyle;
  final bool haptics;
  final TextMapper integerTextMapper;
  final TextMapper decimalTextMapper;
  final bool integerZeroPad;

  /// Decoration to apply to central box where the selected integer value is placed
  final Decoration integerDecoration;

  /// Decoration to apply to central box where the selected decimal value is placed
  final Decoration decimalDecoration;

  /// Inidcates how many decimal places to show
  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
  final int decimalPlaces;

  const DecimalNumberPicker({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.value,
    @required this.onChanged,
    this.itemCount = 3,
    this.itemHeight = 50,
    this.itemWidth = 100,
    this.axis = Axis.vertical,
    this.textStyle,
    this.selectedTextStyle,
    this.haptics = false,
    this.decimalPlaces = 1,
    this.integerTextMapper,
    this.decimalTextMapper,
    this.integerZeroPad = false,
    this.integerDecoration,
    this.decimalDecoration,
  })  : assert(minValue <= value),
        assert(value <= maxValue),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMax = value.floor() == maxValue;
    print('val: $value ------ max: ${maxValue}');
    final decimalValue = isMax
        ? 0
        : ((value - value.floorToDouble()) * math.pow(10, decimalPlaces))
                .round() ??
            0;
    final doubleMaxValue = isMax ? 0 : math.pow(10, decimalPlaces).toInt() - 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberPicker(
          minValue: minValue,
          maxValue: maxValue,
          value: value.floor(),
          onChanged: _onIntChanged,
          itemCount: itemCount,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          textStyle: textStyle,
          selectedTextStyle: selectedTextStyle,
          haptics: haptics,
          zeroPad: integerZeroPad,
          textMapper: integerTextMapper,
          decoration: integerDecoration,
        ),
        NumberPicker(
          minValue: 0,
          maxValue: 11,
          value: decimalValue,
          onChanged: _onDoubleChanged,
          // itemCount: 11,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          textStyle: textStyle,
          selectedTextStyle: selectedTextStyle,
          haptics: haptics,
          textMapper: decimalTextMapper,
          decoration: decimalDecoration,
        ),
      ],
    );
  }

  void _onIntChanged(int intValue) {
    final newValue =
        (value - value.floor() + intValue).clamp(minValue, maxValue);
    onChanged(newValue.toDouble());
  }

  void _onDoubleChanged(int doubleValue) {
    final decimalPart = double.parse(
        (doubleValue * math.pow(10, -decimalPlaces))
            .toStringAsFixed(decimalPlaces));
    onChanged(value.floor() + decimalPart);
  }
}
