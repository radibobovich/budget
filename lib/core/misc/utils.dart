import 'package:intl/intl.dart';

abstract class AppFormatters {
  /// Short format. Adds "k" if the value is more than
  /// 100 000 rubles.
  ///
  /// Example: 12800000 kopecks (128000 rub) => 128,00k ₽
  /// 5608040 kopecks => 56080,40 ₽
  static String convertKopecsToRublesAndFormat(int valueKopecks,
      {bool omitCurrency = false, String currency = '₽'}) {
    final formatter = NumberFormat('##0.00', 'ru_RU');
    if (omitCurrency) currency = '';
    double value = valueKopecks / 100;
    if (value.abs() >= 100000) {
      value /= 1000;
      return '${formatter.format(value)}k $currency';
    }
    return '${formatter.format(value)} $currency';
  }

  /// Coverts rubles to a string separated with spaces and decimal separator.
  /// Example: 56080,4 => 56 080,40 ₽ ([decimalDigits] = 2)
  /// 39245022,7 => 39 245 022,7 ([decimalDigits = 1])
  /// 1230 => 1 230,00 ([decimalDigits = 2])
  /// Use [decimalDigits] to control how much trailing zeros to leave.
  /// 128000
  static String formatRublesWithSeparatorsAndDecimalPart(
    double valueRubles, {
    bool omitCurrency = false,
    String currency = '₽',
    bool trailingComma = false,
    int? decimalDigits,
  }) {
    final formatter = NumberFormat.decimalPatternDigits(
        locale: 'ru_RU', decimalDigits: decimalDigits);
    String formatted = formatter.format(valueRubles);
    if (trailingComma) formatted = '$formatted,';
    if (!omitCurrency) formatted = '$formatted $currency';
    return formatted;
  }

  static bool endsWithOneDecimal(String value) {
    return RegExp(r'\.\d{1}$').hasMatch(value);
  }

  static bool endsWithTwoDecimals(String value) {
    return RegExp(r'\.\d{2}$').hasMatch(value);
  }

  static int? getDecimalPreservationAmount(String value) {
    if (endsWithOneDecimal(value)) return 1;
    if (endsWithTwoDecimals(value)) return 2;
    return null;
  }

  static const monthsDeclensedRu = [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июня',
    'Июля',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря',
  ];
}
