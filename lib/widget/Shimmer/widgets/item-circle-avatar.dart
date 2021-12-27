import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wtf/widget/Shimmer/helpers/helpers.dart';
import 'package:wtf/widget/Shimmer/values/avatar_position.dart';
import 'package:wtf/widget/Shimmer/values/value.dart';

import 'circle.dart';
import 'line.dart';

class FluttonItemCircleAvatarShimmering extends StatelessWidget
    with FluttonShimmeringHelpers {
  ///
  /// @param countLine => each item, how many line you need
  /// @param widthAvatar => width avatar
  /// @param heightAvatar => height avatar
  /// @param widthLine => width rectangle
  /// @param heightLine => height rectangle
  /// @param radiusLine (optional) => radius for line
  /// @param lastWidthLine (optional) => width end line for each item
  /// @param avatarPosition (optional, by default on top) => position avatar each item
  ///
  FluttonItemCircleAvatarShimmering({
    Key key,
    @required this.widthAvatar,
    @required this.heightAvatar,
    @required this.widthLine,
    @required this.heightLine,
    @required this.isImageAvatarVisible,
    this.countLine = defaultCountLine,
    this.lastWidthLine,
    this.avatarPosition = FluttonShimmeringAvatarPosition.TOP,
    this.radiusLine = defaultRadius,
  })  : _avatarPosition = avatarPosition == FluttonShimmeringAvatarPosition.TOP
            ? CrossAxisAlignment.start
            : avatarPosition == FluttonShimmeringAvatarPosition.MIDDLE
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.end,
        _lastWidthLine = lastWidthLine == null ? widthLine : lastWidthLine,
        super(key: key);

  final double widthLine;
  final double heightLine;
  final int countLine;
  final double lastWidthLine;
  double _lastWidthLine;
  final double widthAvatar;
  final double heightAvatar;
  final double radiusLine;
  bool isImageAvatarVisible;
  final FluttonShimmeringAvatarPosition avatarPosition;

  CrossAxisAlignment _avatarPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: _avatarPosition,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8),
                child: CircleShimmer(
                  width: widthAvatar,
                  height: heightAvatar,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  countLine,
                  (int index) => Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: LineShimmer(
                      width: determineValueByComparasion<int, int>(
                              index, countLine - 1)<double, double>(
                          widthLine, _lastWidthLine),
                      height: heightLine,
                      radius: radiusLine,
                    ),
                  ),
                ),
              ),
            ],
          ),
          isImageAvatarVisible
              ? SizedBox(
                  height: 10.0,
                )
              : Container(),
          isImageAvatarVisible
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[200],
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 1),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 24.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
