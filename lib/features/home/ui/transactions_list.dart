import 'package:budget/core/domain/transaction_with_category.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/home/domain/calculator.dart';
import 'package:budget/features/home/ui/widgets/date_header.dart';
import 'package:budget/features/home/ui/widgets/transaction_tile.dart';
import 'package:budget/core/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList(
      {super.key, required this.transactions, required this.calculator});
  final List<TransactionWithCategory> transactions;
  final Calculator calculator;
  @override
  Widget build(BuildContext context) {
    return SliverGroupedListView(
      elements: transactions,
      groupBy: (item) => item.transaction.date.roundToDayStart,
      order: GroupedListOrder.DESC,
      groupHeaderBuilder: (item) {
        final cashflowForDay = calculator.cashflowForDay(item.transaction.date);
        String cashflowFormatted =
            AppFormatters.formatRublesWithSeparatorsAndDecimalPart(
                (cashflowForDay / 100).abs(),
                decimalDigits: 2);
        if (cashflowForDay < 0) cashflowFormatted = '-$cashflowFormatted';
        return DateHeader(
            date: item.transaction.date,
            cashflow: cashflowFormatted,
            isIncome: cashflowForDay >= 0);
      },
      itemBuilder: (context, item) {
        return TransactionTile(transactionWithCategory: item);
      },
      separator: SizedBox(height: 12),
    );
  }
}
