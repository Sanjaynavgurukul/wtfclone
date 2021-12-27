import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class DiscoverItem extends StatelessWidget {
  const DiscoverItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFImageOverlay(
        height: 80,
        width: Get.width*0.45,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 10),
        borderRadius: BorderRadius.circular(15),
        child: Text('GYM', style: TextStyle(color: Colors.white70),),
        alignment: Alignment.bottomCenter,
        boxFit: BoxFit.fill,
        image: NetworkImage('https://th.bing.com/th/id/OIP.8DmReC2_T5Af9JtWX8-zkgHaE8?w=231&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7')
    );
  }
}
