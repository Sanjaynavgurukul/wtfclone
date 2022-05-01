//Dart imports
import 'dart:async';
import 'dart:io';

//Package imports
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wtf/100ms/preview/preview_store.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';
import 'package:package_info_plus/package_info_plus.dart';

//Project imports
import 'package:wtf/100ms/common/constant.dart';
import 'package:wtf/100ms/common/ui/organisms/user_name_dialog_organism.dart';
import 'package:wtf/100ms/enum/meeting_flow.dart';
import 'package:wtf/100ms/preview/preview_page.dart';
import 'package:wtf/100ms/service/deeplink_service.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/model/100ms_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController roomIdController =
      TextEditingController(text: Constant.defaultRoomID);

  Future<bool> getPermissions() async {
    if (Platform.isIOS) return true;
    await Permission.camera.request();
    await Permission.microphone.request();

    while ((await Permission.camera.isDenied)) {
      await Permission.camera.request();
    }
    while ((await Permission.microphone.isDenied)) {
      await Permission.microphone.request();
    }
    return true;
  }

  Future<bool> _closeApp() {
    return Future.value(true);
  }

  void setRTMPUrl(String roomUrl) {
    List<String> urlSplit = roomUrl.split('/');
    int index = urlSplit.lastIndexOf("meeting");
    if (index != -1) {
      urlSplit[index] = "preview";
    }
    Constant.rtmpUrl = urlSplit.join('/') + "?token=beam_recording";

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _closeApp,
      child: Scaffold(
          appBar: AppBar(
            title: Text('100ms'),
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Join a Meeting',
                        style: TextStyle(
                            height: 1,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: roomIdController,
                      autofocus: true,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                          hintText: 'Enter Room URL',
                          suffixIcon: IconButton(
                            onPressed: roomIdController.clear,
                            icon: Icon(Icons.clear),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(16)))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ))),
                        onPressed: () async {
                          MsModel model = await context.read<GymStore>().get100Ms(context:context);
                          if(model != null){
                            bool res = await getPermissions();
                            if(res){

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ListenableProvider.value(
                                    value: new PreviewStore(),
                                    child: PreviewPage(
                                        model:model
                                    ),
                                  )));
                            }else{

                            }
                          }

                          // print('text here ${roomIdController.text}');
                          // setRTMPUrl(roomIdController.text);
                          // String user = await showDialog(
                          //     context: context,
                          //     builder: (_) => UserNameDialogOrganism());
                          // if (user.isNotEmpty) {
                          //   bool res = await getPermissions();
                          //   if (res) {
                          //     FocusManager.instance.primaryFocus?.unfocus();
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (_) => ListenableProvider.value(
                          //           value: PreviewStore(),
                          //           child: PreviewPage(
                          //             roomId: roomIdController.text,
                          //             user: 'Sanjay',
                          //             flow: MeetingFlow.join,
                          //           ),
                          //         )));
                          //   }
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(16))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.video_call_outlined, size: 48),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Join Meeting',
                                  style: TextStyle(height: 1, fontSize: 24))
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
