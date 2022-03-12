import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/model/all_notifications.dart';
import 'package:wtf/screen/home/notifications/notification_list_item.dart';
import 'package:wtf/widget/progress_loader.dart';

import 'notification_list.dart';
import 'notifications_category.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}


class _NotificationsState extends State<Notifications> with TickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(length: tabList.length, vsync: this, initialIndex: 0);
  }

  List<String> tabList = ['New','All'];
  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child){
        AllNotifications notifications = store.selectedNotificationType == 'new'
            ? store.newNotifications
            : store.allNotifications;
       return Scaffold(
         backgroundColor: AppColors.BACK_GROUND_BG,
         appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
             statusBarColor: AppConstants.bgColor,
             statusBarBrightness:
             Platform.isAndroid ? Brightness.light : Brightness.dark,
           ),
           backgroundColor: AppConstants.bgColor,
           title: Text("Notification"),
           bottom:  new TabBar(
             isScrollable: true,
             unselectedLabelColor: Colors.grey,
             indicatorColor: Colors.white,
             onTap: (index){
               store.setNotificationType(
                 context,
                 tabList[index].toLowerCase(),
               );
             },
             tabs: <Tab>[
               new Tab(
                 text: "${tabList[0]}",
               ),
               new Tab(
                 text: "${tabList[1]}",
               ),
             ],
             controller: _tabController,
           ),
         ),
         body: notifications != null
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
             : Loading()
         // body: Column(
         //   mainAxisSize: MainAxisSize.min,
         //   children: [
         //     // CommonAppBar(),
         //     SizedBox(
         //       height: 20,
         //     ),
         //     NotificationsCategory(),
         //     SizedBox(
         //       height: 10,
         //     ),
         //     // ClearAllButton(),
         //     Expanded(
         //       child: NotificationList(),
         //     ),
         //     // MarkAsReadButton(),
         //   ],
         // ),
       );
      }
    );
  }
}

