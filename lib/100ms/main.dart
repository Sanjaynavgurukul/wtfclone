// //Dart imports
// import 'dart:async';
// import 'dart:io';
//
// //Package imports
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wtf_trainer/100ms/common/util/utility_components.dart';
// import 'package:wtf_trainer/100ms/preview/preview_store.dart';
// import 'package:provider/provider.dart';
// import 'package:wtf_trainer/100ms/preview/preview_page.dart';
// import 'package:wtf_trainer/model/100ms_model.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
//
// }
//
// class _HomePageState extends State<HomePage> {
//
//   Future<bool> getPermissions() async {
//     if (Platform.isIOS) return true;
//     await Permission.camera.request();
//     await Permission.microphone.request();
//
//     while ((await Permission.camera.isDenied)) {
//       await Permission.camera.request();
//     }
//     while ((await Permission.microphone.isDenied)) {
//       await Permission.microphone.request();
//     }
//     return true;
//   }
//
//   Future<bool> _closeApp() {
//     return Future.value(true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _closeApp,
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text('100ms'),
//           ),
//           body: Center(
//             child: Container(
//               padding: EdgeInsets.all(8),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text('Join a Meeting',
//                         style: TextStyle(
//                             height: 1,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     ElevatedButton(
//                         style: ButtonStyle(
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16.0),
//                                 ))),
//                         onPressed: () async {
//                           bool res = await getPermissions();
//                           if(res){
//                             MsModel model = await context.read<GymStore>().get100Ms(context:context);
//                             if(model != null){
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (_) => ListenableProvider.value(
//                                     value: new PreviewStore(),
//                                     child: PreviewPage(
//                                         model:model
//                                     ),
//                                   )));
//                             }else{
//                               UtilityComponents.showSnackBarWithString("Something went wrong while creating room!", context);
//                             }
//                           }else{
//                             UtilityComponents.showSnackBarWithString("Please Provide all permission ", context);
//                           }
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(4.0),
//                           decoration: BoxDecoration(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(16))),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.video_call_outlined, size: 48),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                               Text('Join Meeting',
//                                   style: TextStyle(height: 1, fontSize: 24))
//                             ],
//                           ),
//                         )),
//                     SizedBox(
//                       height: 50.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
