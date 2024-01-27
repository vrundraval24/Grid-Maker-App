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
    Size canvasSize = Size(width, height);

    Rect imageRect = Offset.zero & imageSize;
    Rect canvasRect = Offset.zero & canvasSize;

    canvas.drawImageRect(img, imageRect, canvasRect, paint);

    paint.strokeWidth = strokeSize;
    paint.color = strokeColor;

    double gridWidth;
    double gridHeight;

    gridHeight = height / numberOfRows;
    for (int i = 1; i < numberOfRows; i++) {
      canvas.drawLine(
        Offset(0, gridHeight * i),
        Offset(size.width, gridHeight * i),
        paint,
      );
    }

    gridWidth = width / numberOfColumns;
    for (int i = 1; i < numberOfColumns; i++) {
      canvas.drawLine(
        Offset(gridWidth * i, 0),
        Offset(gridWidth * i, size.height),
        paint,
      );
    }

    gridHeight = height / numberOfBoth;

    for (int i = 1; i < numberOfBoth; i++) {
      canvas.drawLine(
        Offset(0, gridHeight * i),
        Offset(size.width, gridHeight * i),
        paint,
      );
    }

    int x = 1;
    while (numberOfBoth > 1) {
      if ((gridHeight * x) >= width) {
        break;
      }
      canvas.drawLine(
        Offset(gridHeight * x, 0),
        Offset(gridHeight * x, size.height),
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
