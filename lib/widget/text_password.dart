// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatefulWidget {
  String txt;

  // ignore: use_key_in_widget_constructors
  PrimaryButton({@required this.txt});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          
          child: Container(
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: Color(0xFFf90f01),
                borderRadius: const BorderRadius.all(
                  Radius.circular(38.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    spreadRadius: 6,
                    blurRadius: 1,
                    offset: const Offset(0, 0),
                  )
                ]),
            padding: const EdgeInsets.all(12),
            child: Center(
                child: Text(
              widget.txt,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
        ),
        Align(
          
          child: Container(
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: Color(0xFFf90f01),
                borderRadius: const BorderRadius.all(
                  Radius.circular(38.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    spreadRadius: 6,
                    blurRadius: 1,
                    offset: const Offset(0, 0),
                  )
                ]),
            padding: const EdgeInsets.all(12),
            child: Center(
                child: Text(
              widget.txt,
              style: const TextStyle(color: Colors.white, fontSize: 20 ),
            )),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class OutlineButton extends StatefulWidget {
  String txt;

  // ignore: use_key_in_widget_constructors
  OutlineButton({@required this.txt});

  @override
  _OutlineButtonState createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black45, Colors.black87],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 11,
            blurRadius: 8,
            offset: Offset(1, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
          child: Text(
        widget.txt,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      )),
    );
  }
}

class InputwithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  const InputwithIcon(this.icon, this.hint, {Key key}) : super(key: key);

  @override
  _InputwithIconState createState() => _InputwithIconState();
}

class _InputwithIconState extends State<InputwithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Color(0xFFf90f01),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: 60,
            child: Icon(
              widget.icon,
              size: 20,
              color: Color(0xFFf90f01),
            ),
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: Color(0xFFf90f01),),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(color: Color(0xFFf90f01),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInputwithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  const PasswordInputwithIcon(this.icon, this.hint, {Key key})
      : super(key: key);

  @override
  _PasswordInputwithIconState createState() => _PasswordInputwithIconState();
}

class _PasswordInputwithIconState extends State<PasswordInputwithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Color(0xFFf90f01),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: 60,
            child: Icon(
              widget.icon,
              size: 20,
              color: Color(0xFFf90f01),
            ),
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: Color(0xFFf90f01),),
              obscureText: true,
              cursorColor: Color(0xFFf90f01),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(color: Color(0xFFf90f01),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FacebookButton extends StatefulWidget {
  String txt;

  // ignore: use_key_in_widget_constructors
  FacebookButton({@required this.txt});

  @override
  _FacebookButtonState createState() => _FacebookButtonState();
}

class _FacebookButtonState extends State<FacebookButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade900,
              ],
            ),
            boxShadow: [
              BoxShadow(
                //color: Colors.grey.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
              child: Text(
            widget.txt,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
        // Image.asset(
        //   "assets/images/facebook.png",
        //   width: 52,
        //   height: 48,
        //   alignment: Alignment.center,
        // ),
      ],
    );
  }
}

// ignore: must_be_immutable
class TwitterButton extends StatefulWidget {
  String txt;

  // ignore: use_key_in_widget_constructors
  TwitterButton({@required this.txt});

  @override
  _TwitterButtonState createState() => _TwitterButtonState();
}

class _TwitterButtonState extends State<TwitterButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ],
            ),
            boxShadow: [
              BoxShadow(
                // color: Colors.grey.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
              child: Text(
            widget.txt,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
        // Image.asset(
        //   "assets/images/twitter.png",
        //   width: 53,
        //   height: 48,
        //   alignment: Alignment.center,
        // ),
      ],
    );
  }
}

// ignore: must_be_immutable
class GoogleButton extends StatefulWidget {
  String txt;

  // ignore: use_key_in_widget_constructors
  GoogleButton({@required this.txt});

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFf90f01),
                Color(0xFFf90f01),
              ],
            ),
            boxShadow: [
              BoxShadow(
                // color: Colors.grey.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
              child: Text(
            widget.txt,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
        // Image.asset(
        //   "assets/images/google.png",
        //   width: 53,
        //   height: 48,
        //   alignment: Alignment.center,
        // ),
      ],
    );
  }
}
