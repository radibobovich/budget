import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/domain/transaction_with_category.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/home/domain/calculator.dart';
import 'package:budget/features/stats/domain/chart_segment.dart';

abstract class StatsState {}

class StatsLoading implements StatsState {}

class StatsError implements StatsState {
  final Object e;
  final String reason;
  final String reasonUI;
  StatsError(this.e, this.reason, this.reasonUI);
}

class StatsLoaded implements StatsState {
  final List<TransactionWithCategory> transactions;
  final List<Category> categories;
  StatsLoaded({required this.transactions, required this.categories});
  late final calc = Calculator(transactions: transactions);
  late final sumForIncomes = calc.sum(TransactionType.incomes);
  late final sumForExpenses = calc.sum(TransactionType.expenses);

  int sumForTransactionType(TransactionType type) =>
      type.isIncome ? sumForIncomes : sumForExpenses;

  List<ChartSegment> getChartSegments(TransactionType type) {
    final typedTransactions = type.isIncome ? calc.incomes : calc.expenses;

    final List<ChartSegment> segments = [];
    for (final category in categories) {
      final transactions =
          typedTransactions.where((t) => t.category?.id == category.id);
      final sum =
          transactions.fold(0, (total, t) => total + t.transaction.value);
      segments.add(ChartSegment(
          categoryId: category.id,
          label: category.name,
          color: category.flutterColor,
          valueKopecks: sum));
    }

    final transactionsWithoutCategory =
        typedTransactions.where((t) => t.category == null).toList();
    final noCategorySum = transactionsWithoutCategory.fold(
        0, (total, t) => total + t.transaction.value);
    final noCategorySegment = ChartSegment(
        categoryId: null,
        label: 'Без категории',
        color: null,
        valueKopecks: noCategorySum);
    segments.add(noCategorySegment);

    return segments..sort((a, b) => b.valueKopecks.compareTo(a.valueKopecks));
  }
}
