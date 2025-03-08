import 'package:flutter/material.dart';

abstract class AppTheme {
  static final nightTheme = ThemeData(
      brightness: Brightness.dark,
      canvasColor: Color.fromARGB(255, 31, 31, 31),
      cardColor: Color.fromARGB(255, 55, 56, 60),
      extensions: [
        AppColorsExtension(
          contrast: Colors.white,
          secondaryText: secondaryTextColor,
          border: Color.fromARGB(255, 60, 60, 60),
          cursorColor: Color.fromARGB(255, 223, 223, 223),
          categorySelectedBorder: Colors.white,
          delete: Color.fromARGB(255, 255, 66, 101),
          colorChipSplash: Colors.white,
          textColor: Colors.white70,
          save: const Color.fromARGB(255, 33, 198, 151),
          shimmerBase: const Color.fromARGB(255, 38, 38, 38),
          shimmerHighlight: const Color.fromARGB(255, 151, 151, 151),
          incomeGradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 33, 198, 151),
              const Color.fromARGB(255, 69, 238, 195)
            ],
          ),
          expenseGradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 226, 226, 226),
              const Color.fromARGB(255, 163, 163, 163)
            ],
            stops: [0.3, 0.9],
          ),
          deleteGradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 66, 101),
            Color.fromARGB(255, 252, 152, 172)
          ]),
        )
      ]);
  static final secondaryTextColor = Color.fromARGB(255, 178, 178, 178);
}

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.contrast,
    required this.secondaryText,
    required this.border,
    required this.cursorColor,
    required this.categorySelectedBorder,
    required this.delete,
    required this.colorChipSplash,
    required this.textColor,
    required this.save,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.incomeGradient,
    required this.expenseGradient,
    required this.deleteGradient,
  });
  final Color contrast;
  final Color secondaryText;
  final Color border;
  final Color cursorColor;
  final Color categorySelectedBorder;
  final Color delete;
  final Color colorChipSplash;
  final Color textColor;
  final Color save;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final LinearGradient incomeGradient;
  final LinearGradient expenseGradient;
  final LinearGradient deleteGradient;
  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? contrast,
    Color? secondaryText,
    Color? border,
    Color? cursorColor,
    Color? delete,
    Color? categorySelectedBorder,
    Color? colorChipSplash,
    Color? textColor,
    Color? save,
    Color? shimmerBase,
    Color? shimmerHighlight,
    LinearGradient? incomeGradient,
    LinearGradient? expenseGradient,
    LinearGradient? deleteGradient,
  }) {
    return AppColorsExtension(
      contrast: contrast ?? this.contrast,
      secondaryText: secondaryText ?? this.secondaryText,
      border: border ?? this.border,
      cursorColor: cursorColor ?? this.cursorColor,
      categorySelectedBorder:
          categorySelectedBorder ?? this.categorySelectedBorder,
      delete: delete ?? this.delete,
      textColor: textColor ?? this.textColor,
      save: save ?? this.save,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      colorChipSplash: colorChipSplash ?? this.colorChipSplash,
      incomeGradient: incomeGradient ?? this.incomeGradient,
      expenseGradient: expenseGradient ?? this.expenseGradient,
      deleteGradient: deleteGradient ?? this.deleteGradient,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;

    return AppColorsExtension(
      contrast: Color.lerp(contrast, other.contrast, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      border: Color.lerp(border, other.border, t)!,
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t)!,
      categorySelectedBorder:
          Color.lerp(categorySelectedBorder, other.categorySelectedBorder, t)!,
      delete: Color.lerp(delete, other.delete, t)!,
      save: Color.lerp(save, other.save, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      colorChipSplash: Color.lerp(colorChipSplash, other.colorChipSplash, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      incomeGradient: incomeGradient,
      expenseGradient: expenseGradient,
      deleteGradient: deleteGradient,
    );
  }
}
