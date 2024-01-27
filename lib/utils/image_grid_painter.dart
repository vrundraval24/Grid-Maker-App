import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageGridPainter extends CustomPainter {
  final ui.Image img;
  final double width, height;
  final int numberOfRows;
  final int numberOfColumns;
  final int numberOfBoth;
  final double strokeSize;
  final Color strokeColor;

  ImageGridPainter({
    super.repaint,
    required this.width,
    required this.numberOfRows,
    required this.numberOfColumns,
    required this.height,
    required this.img,
    required this.numberOfBoth,
    required this.strokeColor,
    required this.strokeSize,
  });

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    Paint paint = Paint();


    canvas.clipRect(Offset.zero & size);

    Size imageSize = Size(img.width.toDouble(), img.height.toDouble());
    Size randSize = Size(width, height);

    Rect imageRect = Offset.zero & imageSize;
    Rect canvasRect = Offset.zero & randSize;

    // canvas.drawColor(Colors.red, BlendMode.src);
    canvas.drawImageRect(img, imageRect, canvasRect, paint);

    paint.strokeWidth = strokeSize;
    paint.color = strokeColor;

    int num = numberOfRows;
    for (int i = 1; i < num; i++) {
      canvas.drawLine(
        Offset(0, (height / num) * i),
        Offset(size.width, (height / num) * i),
        paint,
      );
    }

    int num2 = numberOfColumns + 1;
    for (int i = 1; i < num2; i++) {
      canvas.drawLine(
        Offset((width / num2) * i, 0),
        Offset((width / num2) * i, size.height),
        paint,
      );
    }

    int num3 = numberOfBoth + 1;
    for (int i = 1; i < num3; i++) {
      canvas.drawLine(
        Offset(0, (height / num3) * i),
        Offset(size.width, (height / num3) * i),
        paint,
      );
    }

    int num4 = numberOfBoth + 1;
    int x = 1;
    while (num4 > 1) {
      if (((height / num4) * x) >= width) {
        break;
      }
      canvas.drawLine(
        Offset((height / num4) * x, 0),
        Offset((height / num4) * x, size.height),
        paint,
      );
      x++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
