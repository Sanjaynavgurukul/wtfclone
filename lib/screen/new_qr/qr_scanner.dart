import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/vibrator.dart';
import 'package:wtf/screen/new_qr/argument/qr_argument.dart';

class QrScanner extends StatefulWidget {
  static const String routeName = '/qrScanner';

  const QrScanner({Key key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  // Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GymStore user;
  bool loading = false;
  QrArgument argument;
  String result;
  bool scanned = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.watch<GymStore>();
  }

  // final uiController = BehaviorSubject<int>();
  //
  // Function(int) get setUiController => uiController.sink.add;
  //
  // Stream<int> get getUiController => uiController.stream;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    argument = ModalRoute.of(context).settings.arguments as QrArgument;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildQrView(context),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.BACK_GROUND_BG.withOpacity(0.5),
              height: 100,
              width: double.infinity,
              child: loading?Center(child: CupertinoActivityIndicator(),):Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: FutureBuilder(
                        future: controller?.getFlashStatus(),
                        initialData: false,
                        builder: (context, snapshot) {
                          return snapshot.data
                              ? Icon(
                                  Icons.highlight_sharp,
                                  size: 30,
                                  color: Colors.orange,
                                )
                              : Icon(
                                  Icons.highlight_sharp,
                                  size: 30,
                                );
                        },
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  FlatButton(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      child: FutureBuilder(
                        future: controller?.getCameraInfo(),
                      initialData: CameraFacing.back,
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return describeEnum(snapshot.data).toLowerCase() ==
                                    'back'
                                ? Icon(Icons.flip_camera_ios)
                                : Icon(Icons.flip_camera_ios_outlined);
                            // return Text(
                            //     'Camera facing ${describeEnum(snapshot.data)}');
                          } else {
                            return CupertinoActivityIndicator();
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: Column(
    //     children: <Widget>[
    //       Expanded(flex: 4, child: _buildQrView(context)),
    //       Expanded(
    //         flex: 1,
    //         child: FittedBox(
    //           fit: BoxFit.contain,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: <Widget>[
    //               if (result != null)
    //                 Text(
    //                     'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
    //               else
    //                 const Text('Scan a code'),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: <Widget>[
    //                   Container(
    //                     margin: const EdgeInsets.all(8),
    //                     child: ElevatedButton(
    //                         onPressed: () async {
    //                           await controller?.toggleFlash();
    //                           setState(() {});
    //                         },
    //                         child: FutureBuilder(
    //                           future: controller?.getFlashStatus(),
    //                           builder: (context, snapshot) {
    //                             return Text('Flash: ${snapshot.data}');
    //                           },
    //                         )),
    //                   ),
    //                   Container(
    //                     margin: const EdgeInsets.all(8),
    //                     child: ElevatedButton(
    //                         onPressed: () async {
    //                           await controller?.flipCamera();
    //                           setState(() {});
    //                         },
    //                         child: FutureBuilder(
    //                           future: controller?.getCameraInfo(),
    //                           builder: (context, snapshot) {
    //                             if (snapshot.data != null) {
    //                               return Text(
    //                                   'Camera facing ${describeEnum(snapshot.data)}');
    //                             } else {
    //                               return const Text('loading');
    //                             }
    //                           },
    //                         )),
    //                   )
    //                 ],
    //               ),
    //               // Row(
    //               //   mainAxisAlignment: MainAxisAlignment.center,
    //               //   crossAxisAlignment: CrossAxisAlignment.center,
    //               //   children: <Widget>[
    //               //     Container(
    //               //       margin: const EdgeInsets.all(8),
    //               //       child: ElevatedButton(
    //               //         onPressed: () async {
    //               //           await controller?.pauseCamera();
    //               //         },
    //               //         child: const Text('pause',
    //               //             style: TextStyle(fontSize: 20)),
    //               //       ),
    //               //     ),
    //               //     Container(
    //               //       margin: const EdgeInsets.all(8),
    //               //       child: ElevatedButton(
    //               //         onPressed: () async {
    //               //           await controller?.resumeCamera();
    //               //         },
    //               //         child: const Text('resume',
    //               //             style: TextStyle(fontSize: 20)),
    //               //       ),
    //               //     )
    //               //   ],
    //               // ),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 30,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) async{
    setState(() {
      this.controller = controller;
    });
    print('Qr Code Scanned ---');
    controller.scannedDataStream.listen((scanData) {
      if(!scanned){
        this.scanned = true;
        controller.pauseCamera();
        mark(scanData.code);
      }
      // setState(() {
      //   result = scanData;
      // });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void controlNavigation(QRNavigation type) {
    switch (type) {
      case QRNavigation.NAVIGATE_POP:
        Navigator.pop(
          context,
        );
        break;
      default:
        print('Navigate to schedule page');
        break;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void mark(String qrData) async {
    Vibrator.vibrateCustomTime(durationInMiliSecond: 300);
    setState(() {
      loading = true;
    });

    bool status =
        await user.qrAttendance(context: context, mode: argument.qrMode??'in', qrCode: qrData);

    if (status) {
      setState(() {
        loading = false;
      });
      controlNavigation(argument.qrNavigation);
    }else{
      setState(() {
        loading = false;
        this.scanned = false;
        controller.resumeCamera();
      });
    }
  }
}

enum QRNavigation { NAVIGATE_TO_SCHEDULE, NAVIGATE_POP }
