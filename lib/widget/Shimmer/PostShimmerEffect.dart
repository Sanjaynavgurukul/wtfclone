import 'package:flutter/material.dart';
import 'package:wtf/widget/Shimmer/shimmering.dart';
import 'package:wtf/widget/Shimmer/values/avatar_position.dart';
import 'package:wtf/widget/Shimmer/values/type_list.dart';

import 'helpers/helpers.dart';

///
/// Simple Using FluttonShimerringListLine
///

class PostShimmerEffect extends StatefulWidget with FluttonShimmeringHelpers {
  final bool isImageAvatarVisible;
  final int listCount;

  PostShimmerEffect({this.isImageAvatarVisible, this.listCount});

  @override
  _PostShimmerEffectState createState() => _PostShimmerEffectState(
      isImageAvatarVisible: isImageAvatarVisible, listCount: listCount);
}

class _PostShimmerEffectState extends State<PostShimmerEffect> {
  bool isImageAvatarVisible;
  final int listCount;

  _PostShimmerEffectState({this.isImageAvatarVisible, this.listCount});

  @override
  void initState() {
//    _stopLoadingAfterThreeSecond();
    super.initState();
  }

//  void _stopLoadingAfterThreeSecond() {
//    Future.delayed(Duration(seconds: 50), () {
////      setState(() {
////        _loading = false;
////      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    print('listCount: $listCount');
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width - 24.0,
      child:
//    widget.determineValueByComparasion<bool, bool>(_loading, true)(
          ShimmerWidget.list(
        count: listCount ?? 1,
        countLine: 2,
        heightAvatar: 48,
        widthAvatar: 48,
        heightLine: 12,
        widthLine: 220,
        avatarPosition: FluttonShimmeringAvatarPosition.MIDDLE,
        radiusAvatar: 7,
        isImageAvatarVisible: isImageAvatarVisible,
        typeList: FluttonShimmeringTypeList.ITEM_CIRCLE_AVATAR,
      ),
//        Center(
//          child: IconButton(
//              icon: Icon(
//                Icons.refresh,
//                color: black,
//              ),
//              onPressed: () => discussionsBloc.getAllDiscussions()),
//        ),
//        Container(
//          width: 48,
//          height: 48,
//          decoration: BoxDecoration(
//            color: Colors.red,
//            shape: BoxShape.circle,
//          ),
//        ),
//      ),
    );
  }
}
