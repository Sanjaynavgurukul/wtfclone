import 'package:flutter/material.dart';
import 'package:wtf/screen/home/notifications/notifications.dart';

class ProfileWithNotification extends StatelessWidget {
  const ProfileWithNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => Notifications(),
        );
      },
      child: Stack(
        children: [
          ///Image
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              foregroundImage: AssetImage('assets/images/workout.png'),
              radius: 30,
            ),
          ),

          ///White background
          Positioned.fill(
            // right: 3,
            // top: 3,
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
              ),
            ),
          ),

          ///Notification icon
          Positioned.fill(
            right: -3,
            top: -3,
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.circle_notifications,
                size: 32,
                color: Colors.red,
              ),
            ),
          ),

          ///New Notification Background
          Positioned.fill(
            top: 3,
            right: 3,
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 4,
              ),
            ),
          ),

          ///New Notification Icon
          Positioned.fill(
            top: 3,
            right: 3,
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
