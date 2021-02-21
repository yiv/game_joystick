import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JoystickOutline extends StatelessWidget {
  final double lineWidth;
  final Color lineColor;

  JoystickOutline({this.lineColor, this.lineWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, ),
        child: CustomPaint(
          size: Size.infinite,
          painter: CirclePainter(lineColor: lineColor, lineWidth: lineWidth),
          child: null,
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  Color lineColor;
  double lineWidth;

  CirclePainter({this.lineColor, this.lineWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2 - lineWidth, size.height / 2 - lineWidth);
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
