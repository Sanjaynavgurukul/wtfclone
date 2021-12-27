import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';

class NotificationsCategory extends StatelessWidget {
  const NotificationsCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(
            'New',
          ),
          _item(
            'All',
          ),
        ],
      ),
    );
  }

  _item(String text) => Consumer<GymStore>(
        builder: (context, store, child) => InkWell(
          onTap: () => store.setNotificationType(
            context,
            text.toLowerCase(),
          ),
          child: Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            height: 40,
            alignment: Alignment.center,
            width: Get.width * 0.28,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: store.selectedNotificationType == text.toLowerCase()
                  ? AppConstants.primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
}
