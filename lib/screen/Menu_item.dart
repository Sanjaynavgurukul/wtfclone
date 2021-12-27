import 'package:flutter/material.dart';
import 'package:wtf/helper/app_constants.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 16.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Icon(
            //   icon,
            //   color: Colors.green,
            //   size: 24,
            // ),
//            SizedBox(
//              width: 20,
//            ),
            Text(
              title,
              style: AppConstants.customStyle(
                size: 16.0,
                color: AppConstants.white,
              ),
            ),
            Spacer(),
            // Icon(
            //   Icons.arrow_forward_ios_rounded,
            //   color: AppConstants.drawerTextColor,
            //   size: 24,
            // ),
          ],
        ),
      ),
    );
  }
}
