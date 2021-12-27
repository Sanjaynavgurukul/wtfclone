import 'package:flutter/material.dart';

class NotificationTopBar extends StatelessWidget {
  const NotificationTopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.black,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 28,
                ),
              )),
          SizedBox(height: 20,),
          Text(
            'Notifications',
            style: TextStyle(fontSize: 26),
          ),
        ],
      ),
    );
  }
}
