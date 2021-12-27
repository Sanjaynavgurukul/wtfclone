import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/model/all_notifications.dart';
import 'package:wtf/widget/progress_loader.dart';

import 'notification_list_item.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) {
        AllNotifications notifications = store.selectedNotificationType == 'new'
            ? store.newNotifications
            : store.allNotifications;
        return notifications != null
            ? notifications.data != null && notifications.data.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notifications.data.length,
                    itemBuilder: (context, index) => NotificationListItem(
                      data: notifications.data[index],
                    ),
                  )
                : Container(
                    height: 350.0,
                    alignment: Alignment.center,
                    child: Text(
                      'No Notifications found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
            : Loading();
      },
    );
  }
}
