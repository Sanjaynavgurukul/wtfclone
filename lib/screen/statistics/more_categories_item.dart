import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

class MoreCategoriesItem extends StatelessWidget {
  MoreCategoriesItem({
    Key key,
    this.showGradient,
    this.text,
    this.subText,
    this.onPress,
    // this.width,
    // this.height,
  }) : super(key: key);
  final showGradient, text, subText, onPress;
  // final double width, height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        height: 140.0,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: showGradient ? null : Colors.black,
          borderRadius: BorderRadius.circular(16.0),
          gradient: showGradient
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff131313),
                    Color(0xff131313),
                    AppConstants.primaryColor,
                    // Colors.red.withOpacity(0.2)
                  ],
                )
              : null,
        ),
        alignment: Alignment.bottomCenter,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
// Text(
//   subText,
//   style: TextStyle(
//     fontWeight: FontWeight.w500,
//     fontSize: 14.0,
//     color: Colors.white,
//   ),
// ),
