import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessImage extends StatelessWidget {
  const SuccessImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 40.0,
      ),
      child: Container(
        height: 250,
        width: double.maxFinite,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.fill,
        //     image: AssetImage('assets/lottie/congratulation.json'),
        //   ),
        // ),
        child: Stack(
          children: [
            LottieBuilder.asset(
              'assets/lottie/congratulation.json',
              animate: true,
              alignment: Alignment.center,
              width: double.infinity,
            ),
            LottieBuilder.asset(
              'assets/lottie/workout.json',
              animate: true,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
