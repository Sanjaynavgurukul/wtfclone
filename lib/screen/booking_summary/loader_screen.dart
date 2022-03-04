import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wtf/helper/app_constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller2;
  Animation<Offset> offset;
  Animation<Offset> offset2;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(-6.0, 0.0))
        .animate(controller);

    offset2 = Tween<Offset>(begin: Offset.zero, end: Offset(6.0, 0.0))
        .animate(controller2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('Show / Hide'),
              onPressed: () {
                switch (controller.status) {
                  case AnimationStatus.completed:
                    controller.reverse();
                    controller2.forward();
                    break;
                  case AnimationStatus.dismissed:
                    controller.forward();
                    break;
                  default:
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: offset,
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}