import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:video_player/video_player.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/widget/slide_to_move_widget.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  VideoPlayerController videoPlayerController;
  AppUpdateInfo _updateInfo;

  @override
  void initState() {
    super.initState();
    print("inside init state");

    if (Platform.isAndroid) checkForUpdate();
    videoPlayerController = VideoPlayerController.asset(Videos.SPLASH_VIDEO)
      // 'https://d1e9q0asw0l2kk.cloudfront.net/global_app/splash-screen.mp4')
      ..initialize().then((_) {
        if (mounted) setState(() {});
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        videoPlayerController.setVolume(0.0);
        // videoPlayerController.value.duration
        // setState(() {});
      });
  }

  Future<void> checkForUpdate() async {
    _updateInfo = await InAppUpdate.checkForUpdate().catchError((e) {
      // showSnack(e.toString());
    });
    if (_updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.performImmediateUpdate().then((_) async {
        // await InAppUpdate.completeFlexibleUpdate().then((_) {
        //   // showSnack("Success!");
        // }).catchError((e) {
        //   showSnack(e.toString());
        // });
        FlashHelper.informationBar(context,
            message: 'App Updated Successfully');
      }).catchError((e) {
        // showSnack(e.toString());
      });
    } else {
      print('no new update available');
    }
  }

  void manageLogin() {}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              // If your background video doesn't look right, try changing the BoxFit property.
              // BoxFit.fill created the look I was going for.
              fit: BoxFit.cover,
              child: SizedBox(
                width: videoPlayerController.value.size.width,
                height: videoPlayerController.value.size.height,
                child: VideoPlayer(videoPlayerController),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.redAccent.withOpacity(0.5), Colors.black],
              ),
            ),
          ),
          SplashWidget()
        ],
      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GymStore gymstore;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi there,",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Welcome to ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                  Image.asset(Logos.WTF_LIGHT, height: 22),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Swipe to unlock your fitness",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: SlideActionWidget(
                    onSubmit: () {
                      if (locator<AppPrefs>().isLoggedIn.getValue()) {
                        NavigationService.navigateToReplacement(
                            Routes.homePage);
                      } else {
                        NavigationService.navigateToReplacement(
                            Routes.register);
                      }
                    },
                    innerColor: Colors.transparent,
                    outerColor: Colors.transparent,
                    reversed: false,
                    alignment: Alignment.centerLeft,
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    text: "WITNESS THE FITNESS",
                    sliderButtonIcon: Icon(
                      Icons.navigate_next,
                      size: 45,
                      color: Colors.white,
                    ),
                    submittedIcon: Image.asset(Logos.WTF_DARK),
                    sliderRotate: true,
                    // sliderButtonIconPadding: 0,
                    elevation: 0,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already a member ? ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigationService.navigateToReplacement(
                                  Routes.login);
                            })
                    ],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
