import 'package:auto_size_text/auto_size_text.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/core/theme/theme.dart';
import 'package:budget/core/misc/utils.dart';
import 'package:flutter/material.dart';

class SummaryBlock extends StatelessWidget {
  const SummaryBlock(
      {super.key,
      required this.incomes,
      required this.expenses,
      required this.isLoaded});

  factory SummaryBlock.loaded(int incomes, int expenses) {
    return SummaryBlock(incomes: incomes, expenses: expenses, isLoaded: true);
  }

  factory SummaryBlock.loading() {
    return SummaryBlock(incomes: 0, expenses: 0, isLoaded: false);
  }

  final int incomes;
  final int expenses;
  final bool isLoaded;
  int get cashflowKopecks => incomes - expenses;
  String get cashflow {
    final rubles =
        AppFormatters.convertKopecsToRublesAndFormat(cashflowKopecks);
    return 'Разница: $rubles';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TotalTile(
                label: 'Доходы',
                icon: Icon(Icons.download, size: 18),
                valueKopecks: incomes,
                gradient: context.colors.incomeGradient,
                isLoaded: isLoaded,
              ),
            ),
            SizedBox(width: 9),
            Expanded(
              child: TotalTile(
                label: 'Расходы',
                icon: Icon(Icons.upload, size: 18),
                valueKopecks: expenses,
                textColor: Colors.black,
                gradient: context.colors.expenseGradient,
                isLoaded: isLoaded,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(cashflow,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.secondaryTextColor))
      ],
    );
  }
}

class TotalTile extends StatelessWidget {
  const TotalTile({
    super.key,
    required this.label,
    required this.icon,
    required this.valueKopecks,
    required this.gradient,
    required this.isLoaded,
    this.textColor,
  });
  final String label;
  final Icon icon;
  final int valueKopecks;
  final LinearGradient gradient;
  final Color? textColor;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 8),
              Text(label, style: TextStyle(color: textColor)),
            ],
          ),
          SizedBox(height: 4),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                      AppFormatters.convertKopecsToRublesAndFormat(
                          valueKopecks),
                      minFontSize: 9,
                      maxFontSize: 22,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
