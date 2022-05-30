import 'package:flutter/material.dart';
import 'package:wtf/screen/new_qr/qr_scanner.dart';

class QrArgument{
  QRNavigation qrNavigation;
  String qrMode;
  QrArgument({@required this.qrNavigation,this.qrMode = 'in'});
}