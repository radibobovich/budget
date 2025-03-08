import 'dart:math';

import 'package:flutter/material.dart';

abstract class CategoryColors {
  static final List<Color> defaultColors = [
    const Color(0xFFE57373), // soft red
    const Color(0xFFFFB74D), // soft orange
    const Color(0xFFFFF176), // soft yellow
    const Color(0xFFAED581), // soft light green
    const Color(0xFF4DB6AC), // soft teal
    const Color(0xFF4DD0E1), // soft cyan
    const Color(0xFF64B5F6), // soft blue
    const Color(0xFF7986CB), // soft indigo
    const Color(0xFF9575CD), // soft purple
    const Color(0xFFBA68C8), // soft pink purple
    const Color(0xFFF06292), // soft pink
    const Color(0xFFFF8A65), // soft deep orange
    const Color(0xFF8D6E63), // soft brown
    const Color(0xFF90A4AE), // soft blue grey
    const Color(0xFF9CCC65), // soft lime
    const Color(0xFF7E57C2), // soft deep purple
    const Color(0xFF26A69A), // soft darkcyan
    const Color(0xFFFF7043), // soft coral
    const Color(0xFF66BB6A), // soft green
    const Color(0xFF5C6BC0), // soft royal blue
  ];

  static Color getDefaultColor(int index) {
    return defaultColors[index % defaultColors.length];
  }

  static Color pickRandom() {
    final index = Random(DateTime.now().millisecondsSinceEpoch)
        .nextInt(defaultColors.length);
    return defaultColors[index];
  }
}
