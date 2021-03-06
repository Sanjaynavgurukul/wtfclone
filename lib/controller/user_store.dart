import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wtf/controller/webservice.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Toast.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/User.dart';
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
        locator<AppPrefs>().memberAdded.setValue(res.data.is_member != 0);
        print('avatar: ${res.data.profile}');
        print('check user data ---  ${res.data.is_member}');
        if (res.data.profile != null) {
          locator<AppPrefs>().avatar.setValue(res.data.profile);
        }
        locator<AppPrefs>().phoneNumber.setValue(res.data.mobile);
        notifyListeners();
        //TODO check get member by id
        //getMemberById(context: context);
        //NavigationService.goBack;
      } catch (e) {
        print('user data update error: $e');
      }
    }
  }

  //TODO Check get member by id
  // Future<void> getMemberById({BuildContext context}) async {
  //   MemberDetails res = await RestDatasource().getMemberById(
  //       id: locator<AppPrefs>().memberId.getValue(), context: context);
  //   if (res != null) {
  //     try {
  //       if (res.status) {
  //         print('member Data :::: ${res.toJson()}');
  //         locator<AppPrefs>().memberData.setValue(res.data);
  //         notifyListeners();
  //       } else {
  //         NavigationService.navigateTo(Routes.userDetail);
  //         FlashHelper.informationBar(context,
  //             message: 'Please add your details before using WTF services');
  //       }
  //       //NavigationService.goBack;
  //     } catch (e) {
  //       print('user data update error: $e');
  //     }
  //   }
  // }
}
