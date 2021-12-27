import 'dart:async';

import 'package:flutter/material.dart';

class Toast {
  OverlayState overlayState;
  OverlayEntry overlayEntry;

  Color bgColor;
  Color textColor;
  double textFontSize;
  String text;

  Toast({this.bgColor, this.textColor, this.textFontSize, this.text});

  showDialog(BuildContext context) async {
    overlayState = Overlay.of(
      context,
//      rootOverlay: true,
    );
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 120.0,
        width: MediaQuery.of(context).size.width / 2,
        left: (MediaQuery.of(context).size.width / 2) - 90,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Material(
              type: MaterialType.card,
              elevation: 8.0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(40.0),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: textFontSize ?? 16.0,
                            color: textColor ?? Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'BarlowSemiCondensed-Medium',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    Timer(
      Duration(
        seconds: 5,
      ),
      () => removeDialog(),
    );
  }

  removeDialog() {
    overlayEntry?.remove();
  }
}
