import 'dart:math';

import 'package:flutter/material.dart';

class HexagonShapeImageView extends StatelessWidget {
  final Widget child;
  final int sides;
  final double rotate;
  final double borderRadius;
  final List<PolygonBoxShadow> boxShadows;
  final Color bgColor;

  HexagonShapeImageView({
    @required this.child,
    this.sides = 6,
    this.rotate: 0.0,
    this.borderRadius: 0.0,
    this.boxShadows: const [],
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    PolygonPathSpecs specs = PolygonPathSpecs(
      sides: sides < 3 ? 3 : sides,
      rotate: rotate,
      borderRadiusAngle: borderRadius,
    );

    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: BoxShadowPainter(specs, boxShadows),
        child: ClipPath(
          clipper: Polygon(specs),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bgColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class Polygon extends CustomClipper<Path> {
  final PolygonPathSpecs specs;

  Polygon(this.specs);

  @override
  Path getClip(Size size) {
    return PolygonPathDrawer(size: size, specs: specs).draw();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BoxShadowPainter extends CustomPainter {
  final PolygonPathSpecs specs;
  final List<PolygonBoxShadow> boxShadows;

  BoxShadowPainter(this.specs, this.boxShadows);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = PolygonPathDrawer(size: size, specs: specs).draw();

    boxShadows.forEach((PolygonBoxShadow shadow) {
      canvas.drawShadow(path, shadow.color, shadow.elevation, false);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PolygonBoxShadow {
  final Color color;
  final double elevation;

  PolygonBoxShadow({
    @required this.color,
    @required this.elevation,
  });
}

class PolygonPathDrawer {
  final Path path;
  final Size size;
  final PolygonPathSpecs specs;

  PolygonPathDrawer({
    @required this.size,
    @required this.specs,
  }) : path = Path();

  Path draw() {
    final anglePerSide = 360 / specs.sides;

    final radius = (size.width - specs.borderRadiusAngle) / 2;
    final arcLength =
        (radius * _angleToRadian(specs.borderRadiusAngle)) + (specs.sides * 2);

    Path path = Path();

    for (var i = 0; i <= specs.sides; i++) {
      double currentAngle = anglePerSide * i;
      bool isFirst = i == 0;

      if (specs.borderRadiusAngle > 0) {
        _drawLineAndArc(path, currentAngle, radius, arcLength, isFirst);
      } else {
        _drawLine(path, currentAngle, radius, isFirst);
      }
    }

    return path;
  }

  _drawLine(Path path, double currentAngle, double radius, bool move) {
    Offset current = _getOffset(currentAngle, radius);

    if (move)
      path.moveTo(current.dx, current.dy);
    else
      path.lineTo(current.dx, current.dy);
  }

  _drawLineAndArc(Path path, double currentAngle, double radius,
      double arcLength, bool isFirst) {
    double prevAngle = currentAngle - specs.halfBorderRadiusAngle;
    double nextAngle = currentAngle + specs.halfBorderRadiusAngle;

    Offset previous = _getOffset(prevAngle, radius);
    Offset next = _getOffset(nextAngle, radius);

    if (isFirst) {
      path.moveTo(next.dx, next.dy);
    } else {
      path.lineTo(previous.dx, previous.dy);
      path.arcToPoint(next, radius: Radius.circular(arcLength));
    }
  }

  double _angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  Offset _getOffset(double angle, double radius) {
    final rotationAwareAngle = angle - 90 + specs.rotate;

    final radian = _angleToRadian(rotationAwareAngle);
    final x = cos(radian) * radius + radius + specs.halfBorderRadiusAngle;
    final y = sin(radian) * radius + radius + specs.halfBorderRadiusAngle;

    return Offset(x, y);
  }
}

class PolygonPathSpecs {
  final int sides;
  final double rotate;
  final double borderRadiusAngle;
  final double halfBorderRadiusAngle;
  final Border border;

  PolygonPathSpecs({
    @required this.sides,
    @required this.rotate,
    @required this.borderRadiusAngle,
    this.border,
  }) : halfBorderRadiusAngle = borderRadiusAngle / 2;
}
