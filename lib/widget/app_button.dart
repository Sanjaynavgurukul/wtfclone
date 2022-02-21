import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wtf/helper/colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final Widget child;
  final Color color;

  AppButton(
      {this.label,
      this.onPressed,
      this.height,
      this.width,
      this.padding,
      this.fontSize,
      this.child,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        child: label == null
            ? child
            : Text(
                label,
                style: TextStyle(
                  fontSize: fontSize ?? 17,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
        color: color ?? AppColors.TEXT_DARK,
        textColor: Colors.white,
        height: height ?? 45,
        minWidth: width ?? MediaQuery.of(context).size.width,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.2),
        shape: StadiumBorder(),
        onPressed: onPressed,
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final Color color;
  final Color textColor;
  final double radius;

  AppOutlineButton(
      {@required this.label,
      @required this.onPressed,
      this.height,
      this.width,
      this.padding,
      this.fontSize,
      this.color = const Color(0xffE3E1E1),
      this.textColor,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
      color: color,
      textColor: textColor ?? Colors.white,
      height: height ?? 55,
      minWidth: width,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
          borderRadius:
              new BorderRadius.circular(radius != null ? radius : 4.0)),
      onPressed: onPressed,
    );
  }
}
