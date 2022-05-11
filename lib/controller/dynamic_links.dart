import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

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
      print('params: ${data.link.queryParameters}');
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

  void handleRoute({@required String routeName,@required Map<String,dynamic> param})async{
    print('Check Dynamic Link Param : ${param.toString()}');
    switch(routeName){
      default:
        
    }
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
