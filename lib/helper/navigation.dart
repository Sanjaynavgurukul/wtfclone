import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName) =>
      navigatorKey.currentState.pushNamed(routeName);

  static Future<dynamic> navigateToReplacement(String routeName) =>
      navigatorKey.currentState.pushReplacementNamed(routeName);

  static Future<dynamic> popAndReplace(String routeName) async {
    return await navigatorKey.currentState.popAndPushNamed(routeName);
  }

  static Future<dynamic> navigateToWithArgs(String routeName, Map args) =>
      navigatorKey.currentState.pushNamed(routeName, arguments: args);

  static get goBack => navigatorKey.currentState.pop();

  static get context => navigatorKey.currentContext;
}
