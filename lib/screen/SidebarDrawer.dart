import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/firebase_cloud_messaging_wapper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/custom_dialog.dart';

import '../main.dart';
import 'Menu_item.dart';
import 'home/notifications/notifications.dart';

class SidebarDrawer extends StatefulWidget {
  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  GymStore store;

  Future<void> openImageDocuments() async {
    FilePickerResult picker = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.image,
//      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (picker != null) {
      setState(() {});
      // store
      //     .uploadDocument(
      //       context: context,
      //       image: File(picker.paths[0]),
      //       type: 'profilePicture',
      //     )
      //     .then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    // final UserData userData;
    // = UserClass.fromStoredJson(
    //         json.decode(locator<AppPrefs>().userString.getValue()))
    //     .data;
    // store = Provider.of<AppStore>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            height: MediaQuery.of(context).size.height,
            color: AppColors.PRIMARY_COLOR,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/svg/close.svg',
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                InkWell(
                  onTap: openImageDocuments,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: PreferenceBuilder<String>(
                      preference: locator<AppPrefs>().avatar,
                      builder: (context, snapshot) {
                        return Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              snapshot,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    bottom: 2.0,
                  ),
                  child: Text(
                    'Hi,',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppConstants.customStyle(
                      color: AppConstants.white,
                      size: 16.0,
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        locator<AppPrefs>().userName.getValue() ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppConstants.customStyle(
                          color: AppConstants.white,
                          size: 36.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(12.0),
                Divider(
                  color: Colors.white,
                ),
                MenuItem(
                  icon: Icons.card_giftcard,
                  title: 'My WTF',
                  onTap: () {
                    NavigationService.goBack;
                    NavigationService.navigateTo(Routes.myWtf);
                  },
                ),
                MenuItem(
                  icon: Icons.card_giftcard,
                  title: 'My Profile',
                  onTap: () {
                    NavigationService.goBack;
                    NavigationService.navigateTo(Routes.profile);
                  },
                ),
                // MenuItem(
                //   icon: Icons.card_giftcard,
                //   title: 'Attendance',
                //   onTap: () {
                //     context
                //         .read<GymStore>()
                //         .getCurrentAttendance(context: context);
                //     NavigationService.navigateTo(Routes.mainAttendance);
                //   },
                // ),
                if (store.activeSubscriptions != null)
                  MenuItem(
                    icon: Icons.card_giftcard,
                    title: 'Shift Trainer',
                    onTap: () {
                      context.read<GymStore>().getNewTrainers();
                      NavigationService.navigateTo(Routes.shiftTrainer);
                    },
                  ),
                MenuItem(
                  icon: Icons.card_giftcard,
                  title: 'My Notification',
                  onTap: () {
                    NavigationService.goBack;
                    showDialog(
                      context: context,
                      builder: (context) => Notifications(),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.card_giftcard,
                  title: 'My Subscription',
                  onTap: () {
                    context
                        .read<GymStore>()
                        .getMemberSubscriptions(context: context);
                    NavigationService.goBack;
                    NavigationService.navigateTo(Routes.mySubscription);
                  },
                ),
                MenuItem(
                  icon: Icons.card_giftcard,
                  title: 'My Transactions',
                  onTap: () {
                    context
                        .read<GymStore>()
                        .getMemberSubscriptions(context: context);
                    NavigationService.goBack;
                    NavigationService.navigateTo(Routes.myTransaction);
                  },
                ),
                MenuItem(
                  icon: Icons.card_giftcard,
                  title: 'Log out',
                  onTap: () async {
                    String selection = await showDialog<String>(
                      context: context,
                      builder: (context) => CustomDialog(
                        message:
                            'Are you sure you want to Logout of this account ?',
                        b1Tap: (selection) {
                          Navigator.pop(context);
                        },
                        b1Text: 'Cancel',
                        b2Tap: (selection) {
                          Navigator.pop(context, selection);
                        },
                        b2Text: 'Yes',
                      ),
                    );
                    if (selection == 'yes') {
                      NavigationService.goBack;
                      await locator<AppPrefs>().clear();
                      if (Platform.isAndroid) {
                        Restart.restartApp();
                      } else {
                        FirebaseCloudMessagagingWapper().init();
                        Navigator.of(NavigationService.context)
                            .pushNamedAndRemoveUntil(
                          Routes.loader,
                          (route) => route.isFirst,
                        );
                      }
                    }
                  },
                ),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                      future:
                          getVersionNumber(), // The async function we wrote earlier that will be providing the data i.e vers. no
                      builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) =>
                          Text(
                            snapshot.hasData
                                ? 'Version: ${snapshot.data}'
                                : "Loading ...",
                            textAlign: TextAlign.center,
                            style: AppConstants.customStyle(
                              size: 16.0,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ) // The widget using the data
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;

    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    //	String buildNumber = packageInfo.buildNumber;
  }
}
