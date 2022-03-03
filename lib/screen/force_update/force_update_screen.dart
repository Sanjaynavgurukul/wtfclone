import 'package:flutter/material.dart';
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

    // final ForceUpdateArgument args =
    // ModalRoute.of(context).settings.arguments as ForceUpdateArgument;
    // if(args.forceUpdateModel != null)
    //   _forceUpdateModel = args.forceUpdateModel;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100,left: 16,right: 16),
        child: Column(
          children: [
            Container(
                height: 120,
                width: 120,
                child: Image.asset('assets/images/captcha.png')),
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  'Force Update Available',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  'Update WTF app for better experience',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade300),
                )),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: (){
                if(isAndroid()){

                }else{

                }
              },
              child: Container(
                padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                margin: EdgeInsets.only(left: 16,right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppConstants.white
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(getImagePath(),width: 40,),
                    SizedBox(width: 16,),
                    Text('Update Now',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  String getImagePath(){
    return isAndroid()?'assets/images/app_store.png':'assets/images/app_store.png';
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
