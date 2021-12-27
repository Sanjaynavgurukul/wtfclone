import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryEffect extends StatelessWidget {
  final double blurry;

  BlurryEffect({
    this.blurry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurry, sigmaY: blurry),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}
