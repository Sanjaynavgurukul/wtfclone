import 'package:flutter/material.dart';

class ClearAllButton extends StatelessWidget {
  const ClearAllButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          'Clear All',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.red,
              decoration: TextDecoration.underline),
        ),
        onPressed: () {},
      ),
    );
  }
}
