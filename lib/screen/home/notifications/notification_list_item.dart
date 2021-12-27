import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wtf/helper/Helper.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/model/all_notifications.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationData data;
  const NotificationListItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          context: context,
          enableDrag: true,
          isDismissible: true,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          builder: (context) => NotificationDescriptionSheet(
            data: data,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppConstants.primaryColor,
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationDescriptionSheet extends StatefulWidget {
  final NotificationData data;

  NotificationDescriptionSheet({this.data});

  @override
  _NotificationDescriptionSheetState createState() =>
      _NotificationDescriptionSheetState();
}

class _NotificationDescriptionSheetState
    extends State<NotificationDescriptionSheet> {
  NotificationData get data => widget.data;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   data.description,
              //   style: TextStyle(
              //     fontSize: 12.0,
              //     color: Colors.white,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              Html(
                data: data.description ?? '',
              ),
              UIHelper.verticalSpace(6.0),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  // Jiffy(data.date).startOf(Units.DAY).fromNow(),
                  Helper.stringForDatetime(data.date),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
