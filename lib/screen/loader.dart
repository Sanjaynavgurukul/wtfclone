import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';

import '../main.dart';

class LoaderPage extends StatefulWidget {

  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  // VideoPlayerController videoPlayerController;
  AppUpdateInfo _updateInfo;

  @override
  void initState() {
    if (Platform.isAndroid) checkForUpdate();
    Future.delayed(
      Duration(seconds: 0),
      () {
        context.read<GymStore>().determinePosition();
        if (locator<AppPrefs>().isLoggedIn.getValue()) {
          context.read<GymStore>().init(context: context);
          // NavigationService.navigateToReplacement(Routes.homePage);
          NavigationService.navigateToReplacement(Routes.forceUpdateScreen);
        } else {
          NavigationService.navigateToReplacement(Routes.splash);
        }
      },
    );
    super.initState();
  }

  Future<void> checkForUpdate() async {
    _updateInfo = await InAppUpdate.checkForUpdate().catchError((e) {
      // showSnack(e.toString());
    });
    if (_updateInfo != null &&
        _updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.performImmediateUpdate().catchError((e) {
        // showSnack(e.toString());
      });
    } else {
      print('no new update available');
    }
  }


  bool checkIsForceUpdate(){
    context.read<GymStore>().getForceUpdate().then((value){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.PRIMARY_COLOR,
      body: SizedBox.expand(
        child: FittedBox(
          // If your background video doesn't look right, try changing the BoxFit property.
          // BoxFit.fill created the look I was going for.
          fit: BoxFit.cover,
          child: Image.asset(
            Gif.SPLASH_GIF,
            // 'https://d1e9q0asw0l2kk.cloudfront.net/global_app/splash.gif',
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}
