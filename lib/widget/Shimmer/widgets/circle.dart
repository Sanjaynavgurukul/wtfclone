import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wtf/helper/app_constants.dart';

class CircleShimmer extends StatelessWidget {
  ///
  /// @param width => width circle
  /// @param height => height circle
  ///
  CircleShimmer({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppConstants.black.withOpacity(0.1),
      highlightColor: AppConstants.white.withOpacity(0.2),
      direction: ShimmerDirection.ltr,
      period: Duration(seconds: 1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppConstants.cardBg2,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
