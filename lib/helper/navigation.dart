import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) =>
      navigatorKey.currentState.pushNamed(routeName);

  static Future<dynamic> navigateToReplacement(String routeName) =>
      navigatorKey.currentState.pushReplacementNamed(routeName);

  static Future<dynamic> popAndReplace(String routeName) async {
    return await navigatorKey.currentState.popAndPushNamed(routeName);
  }

  static Future<dynamic> navigateToWithArgs(String routeName, Map args) =>
      navigatorKey.currentState.pushNamed(routeName, arguments: args);

  static Future<dynamic> pushName(String routeName, {dynamic argument}) =>
      navigatorKey.currentState.pushNamed(routeName, arguments: argument);

  static get goBack => navigatorKey.currentState.pop();

  static get context => navigatorKey.currentContext;
}
