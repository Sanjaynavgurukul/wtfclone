import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'AppPrefs.dart';

abstract class FirebaseCloudMessagagingAbs {
  init();
  FirebaseCloudMessagingDelegate delegate;
}

abstract class FirebaseCloudMessagingDelegate {
  onMessage(Map<String, dynamic> message, RemoteNotification notification);
}

class FirebaseCloudMessagagingWapper extends FirebaseCloudMessagagingAbs {
  FirebaseMessaging _firebaseMessaging;

  @override
  init() {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) async {
      print('[FCM]--> token: [ $token ]');
      locator<AppPrefs>().fcmToken.setValue(token);
    });
    _firebaseMessaging.onTokenRefresh.listen((token) {
      print('[FCM]--> token: [ $token ]');
      locator<AppPrefs>().fcmToken.setValue(token);
    });
    firebaseCloudMessagingListeners();
  }

  Future<String> getToken({BuildContext context}) async {
    return await _firebaseMessaging.getToken();
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) {
      iOSPermission();
    }

    FirebaseMessaging.onMessage.listen((event) {
      print('on message event:: ${event.data}');
      print('on message event2:: ${event.notification?.body}');
      return delegate?.onMessage(event.data, event.notification);
    });
    // _firebaseMessaging!.configure(
    //   onMessage: (Map<String, dynamic> message) => delegate?.onMessage(message),
    //   onResume: (Map<String, dynamic> message) => delegate?.onResume(message),
    //   onLaunch: (Map<String, dynamic> message) => delegate?.onLaunch(message),
    // );
  }

  void iOSPermission() {
    _firebaseMessaging.requestPermission();
    // _firebaseMessaging!.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getNotificationSettings();
  }
}
