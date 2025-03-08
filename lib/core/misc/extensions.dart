import 'package:budget/core/data/db/database.dart';
import 'package:budget/features/home/domain/calculator.dart';
import 'package:budget/core/theme/theme.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppColorsExtension get colors => theme.extension<AppColorsExtension>()!;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get window => mediaQuery.size;
}

extension ColorToHexExt on Color {
  String get hex {
    final color = this;
    final red = (color.r * 255).toInt().toRadixString(16).padLeft(2, '0');
    final green = (color.g * 255).toInt().toRadixString(16).padLeft(2, '0');
    final blue = (color.b * 255).toInt().toRadixString(16).padLeft(2, '0');
    final alpha = (color.a * 255).toInt().toRadixString(16).padLeft(2, '0');

    return '$alpha$red$green$blue';
  }
}

extension CategoryColorExt on Category {
  Color get flutterColor {
    final parsed = int.tryParse(color, radix: 16);
    if (parsed == null) return Color(0xFF000000);
    return Color(parsed);
  }
}

extension ShouldInvertOverlayTextColorExt on Color {
  Color maybeInvertedTextColor(Color onDark, Color onLight) {
    if (computeLuminance() > 0.5) return onLight;
    return onDark;
  }
}

extension DateComparisonsExt on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return isSameDay(now);
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime get roundToDayStart => DateTime(year, month, day);
  DateTime get roundToDayEnd => DateTime(year, month, day, 23, 59, 59);
}

extension CapitalizeFirstLetterExt on String {
  String capitalizeFirstLetter() {
    return replaceRange(0, 1, this[0].toUpperCase());
  }
}

extension IsIncomeOrExpenseExt on TransactionType {
  bool get isIncome => this == TransactionType.incomes;
  bool get isExpense => !isIncome;
}
