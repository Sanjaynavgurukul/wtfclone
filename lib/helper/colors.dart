import 'package:flutter/material.dart';

class AppColors {
  static const Color PRIMARY_COLOR = Color(0xff1A1A1A);
  static const Color BACK_GROUND_BG = Color(0xff1A1A1A);

  static const Color TEXT_DARK = Color(0xffb3b3b3);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: color,
      100: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color,
    });
  }
}
