import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Toast.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/User.dart';
import 'package:wtf/model/member_detils.dart';
import 'package:wtf/widget/processing_dialog.dart';

class UserStore extends ChangeNotifier {
  String userImage;
  Future<void> updateProfile({
    BuildContext context,
    Map<String, String> body,
    String file,
  }) async {
    showDialog(
      context: context,
      builder: (context) => ProcessingDialog(
        message: 'Please wait...',
      ),
    );
    print('body: $body');
    Response isUpdated = await RestDatasource().updateProfile(
      context: context,
      body: body,
      file: file != null ? File(file) : null,
    );
    Navigator.pop(context);
    if (isUpdated != null && isUpdated.body.isNotEmpty) {
      getUserById(context: context);
      Toast(
          textColor: Colors.red,
          bgColor: Colors.white,
          textFontSize: 14.0,
          text: 'Profile Updated');
      NavigationService.goBack;
    }
  }

  Future<void> getUserById({BuildContext context}) async {
    User res = await RestDatasource().getUserById(
        id: locator<AppPrefs>().memberId.getValue(), context: context);
    if (res != null) {
      try {
        print('userNot Data :::: ${res.toJson()}');
        locator<AppPrefs>().userName.setValue(res.data.name);
        locator<AppPrefs>().userEmail.setValue(res.data.email);
        locator<AppPrefs>().userData.setValue(res.data);
        print('avatar: ${res.data.profile}');

        if (res.data.profile != null) {
          locator<AppPrefs>().avatar.setValue(res.data.profile);
        }
        locator<AppPrefs>().phoneNumber.setValue(res.data.mobile);
        notifyListeners();
        getMemberById(context: context);
        //NavigationService.goBack;
      } catch (e) {
        print('user data update error: $e');
      }
    }
  }

  Future<void> getMemberById({BuildContext context}) async {
    MemberDetails res = await RestDatasource().getMemberById(
        id: locator<AppPrefs>().memberId.getValue(), context: context);
    if (res != null) {
      try {
        if (res.status) {
          print('member Data :::: ${res.toJson()}');
          locator<AppPrefs>().memberData.setValue(res.data);
          notifyListeners();
        } else {
          NavigationService.navigateTo(Routes.userDetail);
          FlashHelper.informationBar(context,
              message: 'Please add your details before using WTF services');
        }
        //NavigationService.goBack;
      } catch (e) {
        print('user data update error: $e');
      }
    }
  }
}
