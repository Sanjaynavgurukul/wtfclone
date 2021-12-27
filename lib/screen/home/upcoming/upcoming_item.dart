import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class UpcomingItem extends StatelessWidget {
  const UpcomingItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFImageOverlay(
        width: Get.width*0.45,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 20),
        borderRadius: BorderRadius.circular(15),
        child: Text('Yoga', style: TextStyle(fontSize: 16, color: Colors.white70),),
        alignment: Alignment.bottomCenter,
        boxFit: BoxFit.fill,
        image: NetworkImage('https://th.bing.com/th/id/OIP.zuL22OV8xRp6o-FFsLzpZwHaE1?w=263&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7')
    );
  }
}
