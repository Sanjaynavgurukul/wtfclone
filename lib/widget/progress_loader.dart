import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wtf/helper/colors.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitHourGlass(
        color: AppColors.TEXT_DARK,
        size: 80.0,
        controller: AnimationController(
            vsync: this, duration: const Duration(seconds: 1)),
      ),
    );
  }
}

class LoadingWithBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.4),
      child: Loading(),
    );
  }
}
