import 'package:flutter/material.dart' show Color;

class ChartSegment {
  final int? categoryId;
  final String label;
  final Color? color;
  final int valueKopecks;

  ChartSegment(
      {required this.categoryId,
      required this.label,
      required this.color,
      required this.valueKopecks});
}
