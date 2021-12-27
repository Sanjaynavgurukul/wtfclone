import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/screen/attendance/qrScanner.dart';

class Attendance extends StatelessWidget {
  const Attendance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<GymStore>().determinePosition();
    return QRScanner();
  }
}
