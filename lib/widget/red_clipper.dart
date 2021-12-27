import 'package:flutter/material.dart';

class RedClippper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    var firstControlPoint = new Offset(size.width / 5, size.height / 2);
    var firstEndPoint = new Offset(size.width / 3, size.height);
    // var secondControlPoint =
    //     new Offset(size.width - (size.width / 4), size.height / 4 - 65);
    // var secondEndPoint = new Offset(size.width, size.height / 4 - 10);

    path.quadraticBezierTo(firstEndPoint.dx, firstEndPoint.dy,
        firstControlPoint.dx, firstControlPoint.dy);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);
    //
    // path.lineTo(size.width, size.height / 3);
    // path.lineTo(size.width / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
