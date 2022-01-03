import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color bgColor;
  final Color textColor;
  final bool givePadding;
  final EdgeInsets padding;
  final double height;
  final double radius;
  final double textSize;
  const CustomButton({
    Key key,
    this.onTap,
    this.text,
    this.bgColor = AppConstants.primaryColor,
    this.textColor = AppConstants.white,
    this.givePadding = true,
    this.padding,
    this.height = 50.0,
    this.radius = 8.0,
    this.textSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Padding(
        padding: padding != null
            ? padding
            : !givePadding
                ? const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 0.0,
                  )
                : const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
        child: Material(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          child: InkWell(
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.grey.withOpacity(0.08),
                    blurRadius: 5.0,
                    spreadRadius: 1.8,
                    offset: Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(2, 4),
                    spreadRadius: 2.0,
                    blurRadius: 3.0,
                  )
                ],
              ),
              child: Container(
                height: height,
                padding: padding != null ? padding : EdgeInsets.zero,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.grey.withOpacity(0.08),
                      blurRadius: 5.0,
                      spreadRadius: 1.8,
                      offset: Offset(3, 3),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(2, 4),
                      spreadRadius: 2.0,
                      blurRadius: 3.0,
                    )
                  ],
                ),
                child: Text(
                  text,
                  style: AppConstants.customStyle(
                    color: textColor,
                    size: textSize,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
