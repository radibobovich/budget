import 'dart:async';

import 'package:budget/core/misc/utils.dart';
import 'package:rxdart/rxdart.dart';

class ValueController {
  final Stream<int> valueKopecks;
  final Stream<String> valueRaw;
  final Stream<String> valueFormatted;
  final Sink<KeyEvent> addEvent;
  final StreamSubscription<void> _eventSub;
  final StreamSubscription<void> _valueSub;
  final StreamSubscription<void> _formatSub;
  ValueController._({
    required this.valueKopecks,
    required this.valueRaw,
    required this.valueFormatted,
    required this.addEvent,
    required StreamSubscription<void> eventSub,
    required StreamSubscription<void> valueSub,
    required StreamSubscription<void> formatSub,
  })  : _eventSub = eventSub,
        _formatSub = formatSub,
        _valueSub = valueSub;

  factory ValueController(int? initialValueKopecks) {
    final initialRublesString = _getInitialValueRubles(initialValueKopecks);
    final addEventSubject = BehaviorSubject<KeyEvent>();
    final rawSubject = BehaviorSubject<String>()..add(initialRublesString);
    final formattedSubject = BehaviorSubject<String>();
    final eventSub = addEventSubject.listen((event) {
      _handleNumericEvent(event, rawSubject);
    });

    final parsedKopecks = rawSubject.map((string) {
      if (string.endsWith('.')) {
        string = string.substring(0, string.length - 1);
      }
      final value = double.tryParse(string);
      return value != null ? (value * 100).round() : null;
    }).whereNotNull();

    final formatSub = rawSubject.listen((String rubles) {
      final endsWithDecimal = rubles.endsWith('.');
      if (endsWithDecimal) {
        rubles = rubles.substring(0, rubles.length - 1);
      }
      double rublesParsed = double.tryParse(rubles) ?? 0;
      final decimalDigits = AppFormatters.getDecimalPreservationAmount(rubles);
      final formatted = AppFormatters.formatRublesWithSeparatorsAndDecimalPart(
        rublesParsed,
        trailingComma: endsWithDecimal,
        decimalDigits: decimalDigits,
      );
      formattedSubject.add(formatted);
    });

    return ValueController._(
      valueKopecks: parsedKopecks,
      valueRaw: rawSubject,
      valueFormatted: formattedSubject,
      addEvent: addEventSubject.sink,
      eventSub: eventSub,
      valueSub: parsedKopecks.listen((_) {}),
      formatSub: formatSub,
    );
  }

  static void _handleNumericEvent(
      KeyEvent event, BehaviorSubject<String> rawSubject) {
    final currentValue = rawSubject.value;
    if (event is NumericKeyEvent) {
      if (_isDigitsLimitExceeded(currentValue, 11)) return;

      if (currentValue == '0') {
        rawSubject.add(event.number.toString());
      } else {
        final parts = currentValue.split('.');

        if (parts.length > 1) {
          // has decimal part
          final decimalPart = parts[1];
          if (decimalPart.length == 2) return;

          rawSubject.add('$currentValue${event.number}');
        } else if (currentValue.endsWith('.')) {
          // just the decimal point
          rawSubject.add('$currentValue${event.number}');
        } else {
          // no decimal part
          rawSubject.add('$currentValue${event.number}');
        }
      }
    } else if (event is DecimalKeyEvent) {
      if (!currentValue.contains('.')) {
        rawSubject.add('$currentValue.');
      }
    } else if (event is BackspaceKeyEvent) {
      if (currentValue.length > 1) {
        rawSubject.add(currentValue.substring(0, currentValue.length - 1));
      } else {
        rawSubject.add('0');
      }
    }
  }

  static bool _isDigitsLimitExceeded(String value, int maxDigits) {
    if (value.contains('.')) {
      value = value.split('.').first;
    }
    if (value.length > maxDigits) return true;
    return false;
  }

  static String _getInitialValueRubles(int? initialKopecks) {
    if (initialKopecks == null) return '0';
    final rublesPart = initialKopecks ~/ 100;
    final kopecksPart = initialKopecks % 100;
    if (kopecksPart != 0) {
      String kopecksPartStr = kopecksPart.toString();
      // remove second zero
      // if (kopecksPart % 10 == 0) kopecksPartStr = kopecksPartStr[0];
      return '$rublesPart.$kopecksPartStr';
    }
    return '$rublesPart';
  }

  void dispose() {
    _valueSub.cancel();
    _eventSub.cancel();
    _formatSub.cancel();
    addEvent.close();
  }
}

abstract class KeyEvent {}

class NumericKeyEvent implements KeyEvent {
  final int number;
  NumericKeyEvent(this.number);
}

class DecimalKeyEvent implements KeyEvent {}

class BackspaceKeyEvent implements KeyEvent {}
