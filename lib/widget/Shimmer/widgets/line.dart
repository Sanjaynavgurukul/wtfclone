import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wtf/helper/app_constants.dart';

class LineShimmer extends StatelessWidget {
  ///
  /// @param width => width line
  /// @param height => height line
  /// @param radius (optional) => radius line
  ///
  LineShimmer({
    Key key,
    @required this.width,
    @required this.height,
    this.radius,
  })  : _radius = radius == null
            ? BorderRadius.circular(6.0)
            : BorderRadius.circular(radius),
        super(key: key);

  final double width;
  final double height;
  final double radius;
  final BorderRadius _radius;

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
          borderRadius: _radius,
        ),
      ),
    );
  }
}
