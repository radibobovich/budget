import 'package:budget/core/misc/extensions.dart';
import 'package:budget/core/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHeader extends StatelessWidget {
  const DateHeader(
      {super.key,
      required this.date,
      required this.cashflow,
      required this.isIncome});
  final DateTime date;
  final String cashflow;
  final bool isIncome;
  String get dateFormatted {
    final month = AppFormatters.monthsDeclensedRu[date.month - 1].toLowerCase();
    final day = date.day;
    final maybeYear =
        date.year == DateTime.now().year ? '' : date.year.toString();
    return '$day $month $maybeYear';
  }

  String get subtitle {
    if (date.isToday) return 'Сегодня';
    String dayOfTheWeek = DateFormat.EEEE('ru_RU').format(date);
    dayOfTheWeek = dayOfTheWeek.capitalizeFirstLetter();
    return dayOfTheWeek;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dateFormatted,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              Text(subtitle,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
            ],
          ),
          Spacer(),
          Text(cashflow,
              style: TextStyle(
                  fontSize: 16,
                  color: isIncome
                      ? context.colors.incomeGradient.colors.first
                      : context.colors.textColor,
                  fontWeight: FontWeight.w800))
        ],
      ),
    );
  }
}
