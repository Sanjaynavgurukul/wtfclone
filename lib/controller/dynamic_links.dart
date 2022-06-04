import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wtf/100ms/argument/hms_dynamic_argument.dart';
import 'package:wtf/100ms/dynamic_link_screen/hms_dynamic_link_screen.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/screen/DiscoverScreen.dart';
import 'package:wtf/screen/gym/arguments/gym_plan_argument.dart';
import 'package:wtf/screen/gym/gym_membership_plan_page.dart';
import 'package:wtf/screen/nutrition/nutrition_screen.dart';
import 'package:wtf/screen/schedule/new/date_workout_list.dart';

import '../main.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    // handle link that has been retrieved
    _handleDeepLink(data);

    // Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    Uri deepLink;
    if (data != null) deepLink = data.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      print('params checking --- : ${data.link.queryParameters}');
      String value = data.link.queryParameters['json'];
      Map<String, dynamic> v = json.decode(value);

      print('params checking --- : ${v}');
      handleRoute(param: v);
      print('params checking --- : ${data.link.queryParameters}');
      // params: {referredBy: 5fd6a6dc3437070009aa9eb9, referralCode: ABVOVXFPMGIQ}
      // params: {postId: 60360627f8431700086bee5b, screen: view-post}
      // if (deepLink.queryParameters.containsKey('postId')) {
      //   locator<AppPrefs>()
      //       .dynamicLinkPostId
      //       .setValue(deepLink.queryParameters['postId']!);
      //   // locator<NavigationService>().navigateTo(RouteList.singlePost);
      // }
      //
      // if (deepLink.queryParameters.containsKey('referredBy')) {
      //   locator<AppPrefs>()
      //       .dynamicLinkReferredBy
      //       .setValue(deepLink.queryParameters['referredBy']!);
      //   locator<AppPrefs>()
      //       .dynamicLinkReferredByCode
      //       .setValue(deepLink.queryParameters['referralCode']!);
      // }
    }
  }

  void handleRoute({@required Map<String, dynamic> param}) async {
    if (!validateValidLink(userId: param["userId"])) {
      showToast(message: "Invalid Link Please try again later!");
    } else {
      print('Check Dynamic Link Param : ${param.toString()}');
      switch (param["routeName"]) {
        case GymMembershipPlanPage.routeName:
          NavigationService.pushName(Routes.gymMembershipPlanPage,
              argument: GymPlanArgument(isDynamicLink: true, data: param));
          break;
        case DiscoverScreen.routeName:
          NavigationService.pushName(Routes.discoverScreen);
          break;
        case NutritionScreen.routeName:
          NavigationService.pushName(Routes.nutritionScreen);
          break;
      //TODO check new schedule Here
        // case DateWorkoutList.routeName:
        //   NavigationService.pushName(Routes.dateWorkoutList);
        //   break;
        case HmsDynamicLinkScreen.routeName:
          NavigationService.pushName(Routes.hmsDynamicLinkScreen,argument: HmsDynamicArgument(data: param));
          break;
        default:
          showToast(message: "Invalid Link Please try again later!");
          break;
      }
    }
  }

  bool validateValidLink({@required String userId}){
    String memberId = locator<AppPrefs>().memberId.getValue();
    if(userId == null || userId.isEmpty){
      showToast(message: "Invalid Link Please try again later!");
      return false;
    }else{
      if(userId == memberId){
        return true;
      }else{
        showToast(message: "Invalid Link Please try again later!");
        return false;
      }
    }
  }


  void showToast({@required String message}){
    Fluttertoast.showToast(
        msg: message??"Something went wrong please try again later!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Future<String> createFirstPostLink(String title) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://filledstacks.page.link',
      link: Uri.parse('https://www.compound.com/post?title=$title'),
      androidParameters: AndroidParameters(
        packageName: 'com.filledstacks.compound',
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();

    return dynamicUrl.toString();
  }
}
