import 'package:flutter/material.dart';

class MarkAsReadButton extends StatelessWidget {
  const MarkAsReadButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextButton(
          child: Text(
            'Mark all as read',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.double
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
