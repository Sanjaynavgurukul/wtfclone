import 'package:flutter/material.dart';
import 'package:wtf/widget/Shimmer/values/avatar_position.dart';
import 'package:wtf/widget/Shimmer/values/type.dart';
import 'package:wtf/widget/Shimmer/values/type_list.dart';
import 'package:wtf/widget/Shimmer/widgets/circle.dart';
import 'package:wtf/widget/Shimmer/widgets/item-avatar.dart';
import 'package:wtf/widget/Shimmer/widgets/item-circle-avatar.dart';
import 'package:wtf/widget/Shimmer/widgets/item.dart';
import 'package:wtf/widget/Shimmer/widgets/line.dart';
import 'package:wtf/widget/Shimmer/widgets/rectangle.dart';

import 'helpers/helpers.dart';

///
/// FluttonShimmering
/// is a widget to show a placeholder to the user before he got
/// the real data. This widget has many types, there are :
///
/// 1. Rectangle
/// 2. Circle
/// 3. Line
/// 4. List
///    1. List Line
///    2. List Item Avatar
///    3. List Item Circle Avatar
///
/// you just using what you want it, and throw it into your
/// screen. If you want to know more, please checkout the
/// examples folder.
///

class ShimmerWidget extends StatelessWidget with FluttonShimmeringHelpers {
  ///
  /// @param width => width rectangle
  /// @param height => height rectangle
  /// @param radius (optional) => radius for rectangle
  ///

  ShimmerWidget.rectangle({
    Key key,
    @required this.width,
    @required this.height,
    this.radius,
  })  : type = FluttonShimmeringType.RECTANGLE,
        super(key: key);

  ///
  /// @param width => width circle
  /// @param height => height circle
  ///

  ShimmerWidget.circle({
    Key key,
    @required this.width,
    @required this.height,
  })  : type = FluttonShimmeringType.CIRCLE,
        super(key: key);

  ///
  /// @param width => width line
  /// @param height => height line
  /// @param radius (optional) => radius for line
  ///

  ShimmerWidget.line({
    Key key,
    @required this.width,
    @required this.height,
    this.radius,
  })  : type = FluttonShimmeringType.LINE,
        super(key: key);

  ///
  /// @param count => count of list items
  /// @param countLine => each item, how many line you need
  /// @param widthAvatar => width avatar
  /// @param heightAvatar => height avatar
  /// @param widthLine => width rectangle
  /// @param heightLine => height rectangle
  /// @param radiusAvatar (optional) => radius for avatar
  /// @param radiusLine (optional) => radius for line
  /// @param lastWidthLine (optional) => width end line for each item
  /// @param avatarPosition (optional, by default on top) => position avatar each item
  /// @param typeList (optional) => what style you want to show for item inside list.
  /// Mix between line and avatar, or line and circle avatar or just line
  ///

  ShimmerWidget.list({
    Key key,
    @required this.count,
    @required this.countLine,
    @required this.widthLine,
    @required this.heightLine,
    @required this.widthAvatar,
    @required this.heightAvatar,
    @required this.isImageAvatarVisible,
    this.radiusLine,
    this.radiusAvatar,
    this.lastWidthLine,
    this.avatarPosition = FluttonShimmeringAvatarPosition.TOP,
    this.typeList = FluttonShimmeringTypeList.ITEM,
  })  : type = FluttonShimmeringType.LIST,
        super(key: key);

  int count;
  int countLine;
  double width;
  double height;
  double radius;
  double lastWidthLine;
  double radiusLine;
  double widthLine;
  double heightLine;
  double radiusAvatar;
  double widthAvatar;
  double heightAvatar;
  bool isImageAvatarVisible = true;
  FluttonShimmeringType type;
  FluttonShimmeringTypeList typeList;
  FluttonShimmeringAvatarPosition avatarPosition;

  List<Widget> _buildItemFluttonShimmering() {
    return List.generate(
      count,
      (int index) {
        if (typeList == FluttonShimmeringTypeList.ITEM) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ItemShimmering(
              countLine: countLine,
              widthLine: widthLine,
              heightLine: heightLine,
              lastWidthLine: determineValueByComparasion(index, count - 1)(
                  lastWidthLine, widthLine),
            ),
          );
        } else if (typeList == FluttonShimmeringTypeList.ITEM_AVATAR) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: FluttonItemAvatarShimmering(
              heightAvatar: heightAvatar,
              widthAvatar: widthAvatar,
              countLine: countLine,
              radiusAvatar: radius,
              radiusLine: radiusLine,
              widthLine: widthLine,
              heightLine: heightLine,
              avatarPosition: avatarPosition,
              lastWidthLine: determineValueByComparasion(index, count - 1)(
                  lastWidthLine, widthLine),
            ),
          );
        }
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
          child: FluttonItemCircleAvatarShimmering(
            heightAvatar: heightAvatar,
            widthAvatar: widthAvatar,
            countLine: countLine,
            radiusLine: radiusLine,
            widthLine: widthLine,
            heightLine: heightLine,
            avatarPosition: avatarPosition,
            isImageAvatarVisible: isImageAvatarVisible,
            lastWidthLine: determineValueByComparasion(index, count - 1)(
                lastWidthLine, widthLine),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (type == FluttonShimmeringType.RECTANGLE) {
      return RectangleShimmering(
        width: width,
        radius: radius,
        height: height,
      );
    } else if (type == FluttonShimmeringType.CIRCLE) {
      return CircleShimmer(
        width: width,
        height: height,
      );
    } else if (type == FluttonShimmeringType.LINE) {
      return LineShimmer(
        width: width,
        height: height,
        radius: radius,
      );
    }
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: _buildItemFluttonShimmering(),
    );
  }
}
