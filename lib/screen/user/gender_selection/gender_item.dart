import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderItem extends StatelessWidget {
  const GenderItem({Key key, this.title, this.isSelected, this.onPress})
      : super(key: key);
  final title, isSelected, onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onPress(title);
          },
          child: Container(
            height: Get.height * 0.6,
            width: Get.width * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: isSelected ? Border.all(color: Colors.grey) : null,
                color: isSelected ? null : Colors.transparent,
                image: DecorationImage(
                  // fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/$title.png',
                  ),
                  // fit: BoxFit.cover,
                ),
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          // Colors.transparent,
                          Colors.red.withOpacity(0.01),
                          Colors.red.withOpacity(0.25),
                          Colors.red.withOpacity(0.5),
                          Colors.red,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        )
      ],
    );
  }
}
