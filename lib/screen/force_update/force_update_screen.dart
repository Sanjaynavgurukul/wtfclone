import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/model/force_update_model.dart';
import 'package:wtf/screen/force_update/arguments/force_update_argument.dart';


class ForceUpdateScreen extends StatefulWidget {
  static const String routeName = '/forceUpdateScreen';

  const ForceUpdateScreen({Key key}) : super(key: key);

  @override
  _ForceUpdateScreenState createState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends State<ForceUpdateScreen> {
  ForceUpdateModel _forceUpdateModel;

  @override
  Widget build(BuildContext context) {

    final ForceUpdateArgument args =
    ModalRoute.of(context).settings.arguments as ForceUpdateArgument;
    if(args.forceUpdateModel != null)
      _forceUpdateModel = args.forceUpdateModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 80,left: 16,right: 16),
          child: Column(
            children: [

              Container(
                  width: 230,
height: 230,
                  child: SvgPicture.asset(
                      'assets/svg/force_update_bg.svg',
                      semanticsLabel: 'Acme Logo'
                  )),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'New Update Available',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),
                  )),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Html(
                    shrinkWrap: true,
                    data: _forceUpdateModel.description ?? 'Update WTF app for better experience',
                  )),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: (){
                  _launchURL(_forceUpdateModel.link??getPlayUrl());
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 12,right: 12,top: 16,bottom: 16),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: AppConstants.boxBorderColor
                  ),
                  child:  Text('Update',style: TextStyle(fontWeight: FontWeight.w600,color:Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getImagePath(){
    return isAndroid()?'assets/images/google_play.png':'assets/images/app_store.png';
  }

  String getPlayUrl(){
    return isAndroid()?'https://play.google.com/store/apps/details?id=com.wtf.member':'https://play.google.com/store/apps/details?id=com.wtf.member';
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
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
}
