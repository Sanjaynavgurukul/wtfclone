import 'package:flutter/material.dart';

class FlexibleAppBar extends StatelessWidget {
  final String image;
  final Color color;

  final double appBarHeight = 66.0;

  const FlexibleAppBar({this.image, this.color});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(),
      ),
    );
  }
}
