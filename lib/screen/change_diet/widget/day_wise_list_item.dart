import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/model/diet_model.dart';

class DayWiseListItem extends StatelessWidget {
  const DayWiseListItem({Key key, this.blur = false, this.data})
      : super(key: key);
  final bool blur;
  final MealSlot data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12,right: 12,bottom: 8),
      child: Blur(
        blur: blur ? 3 : 0,
        blurColor:
        blur ? Colors.grey.withOpacity(0.5) : AppConstants.appBackground,
        colorOpacity: blur ? 0.5 : 0,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          padding:EdgeInsets.only(top: 6,bottom: 6),child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
           child: CachedNetworkImage(
             imageUrl: data.co_image,
             imageBuilder: (context, imageProvider) => Container(
               width: 50.0,
               height: 50.0,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(12)),
                 image: DecorationImage(
                     image: imageProvider, fit: BoxFit.cover),
               ),
             ),
             placeholder: (context, url) => CircularProgressIndicator(),
             errorWidget: (context, url, error) => Icon(Icons.error),
           ),
          ),
          title: Text(
            '${data.name}',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '${data.description}',
            maxLines: 5,
          ),
        ),),
      ),
    );
  }


}
