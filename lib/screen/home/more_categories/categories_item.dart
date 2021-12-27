import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({
    Key key,
    this.color = AppConstants.primaryColor,
    this.itemName,
    this.img,
  }) : super(key: key);
  final color;
  final String itemName;
  final String img;

  @override
  Widget build(BuildContext context) {
    var old = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 6.0,
      ),
      child: Card(
        color: color,
        elevation: 12.0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          child: Row(
            children: [
              // Flexible(
              //   flex: 3,
              //   child: CircleAvatar(
              //     backgroundColor: Color(0xff110202),
              //     radius: 30.0,
              //   ),
              // ),
              Flexible(
                flex: 3,
                child: Image.asset(img),
              ),
              UIHelper.horizontalSpace(6.0),
              Flexible(
                flex: 4,
                child: Center(
                  child: Text(
                    itemName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            // gradient: LinearGradient(
            //   end: Alignment.bottomCenter,
            //   begin: Alignment.topRight,
            //   colors: [
            //     Colors.black.withOpacity(0.2),
            //     Colors.red,
            //   ],
            //   stops: [0.0, 1],
            // ),
          ),
        ),
      ),
    );
    var newOne = Container(
      child: Stack(
        children: [
          // Flexible(
          //   flex: 3,
          //   child: CircleAvatar(
          //     backgroundColor: Color(0xff110202),
          //     radius: 30.0,
          //   ),
          // ),
          Opacity(
            opacity: .3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                img,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          UIHelper.horizontalSpace(6.0),
          Center(
            child: Text(
              itemName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: color,
        borderRadius: BorderRadius.circular(20),
        // gradient: LinearGradient(
        //   end: Alignment.bottomCenter,
        //   begin: Alignment.topRight,
        //   colors: [
        //     Colors.black.withOpacity(0.2),
        //     Colors.red,
        //   ],
        //   stops: [0.0, 1],
        // ),
      ),
    );
    return old;
  }
}
