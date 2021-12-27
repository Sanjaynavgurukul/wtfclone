import 'package:flutter/material.dart';
import 'package:wtf/helper/colors.dart';

import 'notification_list.dart';
import 'notifications_category.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BG,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CommonAppBar(),
          SizedBox(
            height: 20,
          ),
          NotificationsCategory(),
          SizedBox(
            height: 10,
          ),
          // ClearAllButton(),
          Expanded(
            child: NotificationList(),
          ),
          // MarkAsReadButton(),
        ],
      ),
    );
  }
}
