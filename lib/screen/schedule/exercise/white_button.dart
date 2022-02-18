import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  const WhiteButton(
      {Key key,
      @required this.title,
      @required this.hPadding,
      @required this.vPadding,@required this.textSize, this.color, this.onPress, })
      : super(key: key);
  final title, hPadding, vPadding, textSize, color, onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: textSize, fontWeight: FontWeight.w400),
      ),
      style: ElevatedButton.styleFrom(
          primary: color ?? Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: hPadding,
            vertical: vPadding,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25))),
    );
  }
}
