import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/user_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/Toast.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/strings.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/custom_button.dart';
import 'package:wtf/widget/text_field.dart';

import '../../main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController, emailController, mobileController;

  UserStore store;

  String selectedFile;

  @override
  void initState() {
    nameController =
        TextEditingController(text: locator<AppPrefs>().userName.getValue());
    emailController =
        TextEditingController(text: locator<AppPrefs>().userEmail.getValue());
    mobileController =
        TextEditingController(text: locator<AppPrefs>().phoneNumber.getValue());
    selectedFile = locator<AppPrefs>().avatar.getValue();
    super.initState();
  }

  Future<void> openImageDocuments() async {
    String pickerType = await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 120.0,
        color: AppColors.PRIMARY_COLOR,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context, 'camera'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                width: double.infinity,
                child: Text(
                  'Camera',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpace(20.0),
            InkWell(
              onTap: () => Navigator.pop(context, 'gallery'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                width: double.infinity,
                child: Text(
                  'Gallery',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    PickedFile picker;
    if (pickerType == 'camera') {
      picker = await ImagePicker().getImage(source: ImageSource.camera);
      if (picker != null) {
        selectedFile = picker.path;
        setState(() {});
      }
    } else if (pickerType == 'gallery') {
      picker = await ImagePicker().getImage(source: ImageSource.gallery);
      if (picker != null) {
        selectedFile = picker.path;
        setState(() {});
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<UserStore>();
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        brightness: Brightness.dark,
        title: Text(
          'Profile',
          style: AppConstants.customStyle(
            color: Colors.white,
            size: 16.0,
          ),
        ),
      ),
      bottomNavigationBar: CustomButton(
        onTap: () {
          if (nameController.text.isNotEmpty &&
              emailController.text.isNotEmpty &&
              mobileController.text.isNotEmpty) {
            store.updateProfile(
              body: {
                'uid': locator<AppPrefs>().memberId.getValue(),
                'name': nameController.text,
                'email': emailController.text,
                'mobile': mobileController.text,
              },
              context: context,
              file: selectedFile != null
                  ? selectedFile.startsWith('https')
                      ? null
                      : selectedFile
                  : null,
            );
          } else {
            Toast(
              text: 'Please fill all fields',
              textFontSize: 14.0,
              bgColor: Colors.white,
              textColor: Colors.red,
            ).showDialog(context);
          }
        },
        textColor: Colors.white,
        bgColor: Colors.red,
        givePadding: true,
        text: 'Save',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: openImageDocuments,
                child: selectedFile != null
                    ? selectedFile.startsWith('https')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                selectedFile,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.file(
                                File(selectedFile),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                    : null,
              ),
              UIHelper.verticalSpace(20.0),
              OutlineTextField(
                controller: nameController,
                labelText: 'Name',
                hintText: 'Enter Name',
                keyboardType: TextInputType.name,
              ),
              UIHelper.verticalSpace(20.0),
              OutlineTextField(
                controller: emailController,
                labelText: 'Email',
                hintText: 'Enter Email',
                keyboardType: TextInputType.emailAddress,
              ),
              UIHelper.verticalSpace(20.0),
              OutlineTextField(
                controller: mobileController,
                fontFamily: Fonts.ROBOTO,
                labelText: 'Mobile Number',
                hintText: 'Enter Mobile Number',
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
