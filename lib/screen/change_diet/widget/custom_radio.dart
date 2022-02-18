import 'package:flutter/material.dart';
import 'package:wtf/screen/change_diet/change_diet.dart';

class CustomRadio extends StatelessWidget {
  final Cat data;
  final Function onClick;

  CustomRadio({@required this.data, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 4, right: 4),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if(data.selected) Positioned.fill(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: data.color,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(data.label,
                  style: TextStyle(
                      color: data.selected ? Colors.transparent : Colors.black38)),
            ),
          ],
        ),
      ),
    );
  }
}
