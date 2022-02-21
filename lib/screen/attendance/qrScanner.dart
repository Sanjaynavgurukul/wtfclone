import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/AppPrefs.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/widget/ImageScannerAnimation.dart';

import '../../main.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key key}) : super(key: key);

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner>
    with SingleTickerProviderStateMixin {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  AnimationController _animationController;
  bool _animationStopped = false;
  String scanText = "Scan";
  bool scanning = false;
  GymStore store;
  String mode = 'in';

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: new Duration(seconds: 1),
      vsync: this,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });
    animateScanAnimation(true);
    super.initState();
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    controller?.dispose();
    super.dispose();
  }

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
    store = context.watch<GymStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: Text(
          'Scan QR Code',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => NavigationService.goBack,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.PRIMARY_COLOR,
      // bottomNavigationBar: CustomButton(
      //   bgColor: Colors.red,
      //   textColor: Colors.white,
      //   text: "Mark Attendance",
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ChipBox(
                text: 'QR SCANNING',
                size: 30.0,
              ),
            ),
            UIHelper.verticalSpace(20.0),
            Container(
              height: 250.0,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _buildQrView(context),
                  ),
                  ImageScannerAnimation(
                    _animationStopped,
                    MediaQuery.of(context).size.width - 32.0,
                    animation: _animationController,
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(10.0),
            Text(
              'Hey ${locator<AppPrefs>().userName.getValue()}',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18.0,
              ),
            ),
            UIHelper.verticalSpace(4.0),
            Text(
              'Welcome to ${store.selectedSchedule.gymname}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            UIHelper.verticalSpace(10.0),
            if (store.attendanceDetails != null &&
                store.attendanceDetails.data != null)
              Text(
                'You have been successfully checked into your Gym',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            UIHelper.verticalSpace(10.0),
            if (store.attendanceDetails != null &&
                store.attendanceDetails.data != null)
              RichText(
                text: TextSpan(
                  text: 'Check ${store.attendanceDetails.data.mode} : ',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(
                      text:
                          ' ${store.attendanceDetails.data.time}, ${store.attendanceDetails.data.date}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            UIHelper.verticalSpace(10.0),
            Divider(
              height: 1.0,
              color: Colors.white.withOpacity(0.3),
            ),
            UIHelper.verticalSpace(20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = 150.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 35,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        print('scanner data:: ${scanData.code}');
      });
      await this.controller.pauseCamera();
      if (store.attendanceDetails != null &&
          store.attendanceDetails.data != null) {
        if (store.attendanceDetails.data.mode == 'in') {
          setState(() {
            mode = 'out';
          });
        }
      }
      bool isMarked = await store.markAttendance(
        context: context,
        mode: mode,
        qrCode: scanData.code,
      );
      if (!isMarked) {
        await this.controller.resumeCamera();
      }
    });
  }
}

class ChipBox extends StatelessWidget {
  final String text;
  final Color bgColor;
  final double size;

  ChipBox({
    this.text,
    this.bgColor = Colors.red,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: bgColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: size,
        ),
      ),
    );
  }
}
