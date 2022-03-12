import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

class CustomActionButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  const CustomActionButton({
    Key key,
    this.label,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              AppConstants.stcoinbgColor,
              AppConstants.primaryColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
              offset: Offset(0, 2), // Shadow position
            )
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
