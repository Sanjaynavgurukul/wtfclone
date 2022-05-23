import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/api_constants.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/model/force_update_model.dart';
import 'package:wtf/screen/force_update/arguments/force_update_argument.dart';

import '../main.dart';
import 'dart:io' show Platform;

class LoaderPage extends StatefulWidget {

  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  // VideoPlayerController videoPlayerController;
  AppUpdateInfo _updateInfo;

  @override
  void initState() {
    print('init method called');
    // if (Platform.isAndroid) checkForUpdate();
    final user = Provider.of<GymStore>(context, listen: false);
    Future.delayed(
      Duration(seconds: 5),
      () {
        // context.read<GymStore>().determinePosition();
        if (locator<AppPrefs>().isLoggedIn.getValue()) {
          context.read<GymStore>().init(context: context);
          print('preamble check login init checked');
          // context.read<GymStore>().getForceUpdate().then((value){
          //   print('checking from loader --- ${value.wtf_version}');
          //   if(isAndroid()){
          //     if(!value.wtf_version.contains(Api.currentVersion)) {
          //       navToForceUpdate(value);
          //     } else{
          //       navToHome();
          //     }
          //   }else{
          //     if(!value.apple_version.contains(Api.currentVersion)){
          //       navToForceUpdate(value);
          //     }
          //     else {
          //       navToHome();
          //     }
          //   }
          // });

          //TODO Preamble Changed :D
          //bool memberAdded = locator<AppPrefs>().memberAdded.getValue();
          // print('memberAddedember added -- $memberAdded');
          // if(memberAdded){
            context.read<GymStore>().getForceUpdate().then((value){
              print('checking from loader --- ${value.wtf_version}');
              if(isAndroid()){
                if(!value.wtf_version.contains(Api.currentVersion) && value.force_update == 1) {
                  navToForceUpdate(value);
                } else{
                  navToHome();
                }
              }else{
                if(!value.apple_version.contains(Api.currentVersion) && value.force_update == 1){
                  navToForceUpdate(value);
                }
                else {
                  navToHome();
                }
              }
            });
          //TODO Preamble Changed :D
          // }else{
          //   NavigationService
          //       .navigateToReplacement(
          //       Routes.userDetail);
          // }
        } else {
          NavigationService.navigateToReplacement(Routes.splash);
        }
      },
    );
    super.initState();
  }

  void navToForceUpdate(ForceUpdateModel data){
    NavigationService.navigateToReplacement(Routes.forceUpdateScreen,argument: ForceUpdateArgument(forceUpdateModel: data));
  }
  void navToHome(){
    NavigationService.navigateToReplacement(Routes.homePage);
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


  bool isAndroid(){
    if (Platform.isAndroid) {
      // Android-specific code
      return true;
    } else {
      // iOS-specific code
      return false;
    }
  }
  
  // bool checkIsForceUpdate(){
  //   bool check = false;
  //   context.read<GymStore>().getForceUpdate().then((value){
  //     if(isAndroid()){
  //       if(value.wtf_version.contains(Api.currentVersion)) check = true;
  //       else check = false;
  //     }else{
  //       if(value.apple_version.contains(Api.currentVersion)) check= true;
  //       else check= false;
  //     }
  //   });
  //   return check;
  // }

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
