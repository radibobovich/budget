import 'package:budget/core/domain/transaction_with_category.dart';
import 'package:budget/core/misc/extensions.dart';

enum TransactionType { incomes, expenses }

class Calculator {
  final List<TransactionWithCategory> transactions;
  const Calculator({required this.transactions});

  List<TransactionWithCategory> get incomes =>
      transactions.where((t) => t.transaction.isIncome).toList();
  List<TransactionWithCategory> get expenses =>
      transactions.where((t) => !t.transaction.isIncome).toList();

  int sum(TransactionType mode) {
    if (mode == TransactionType.incomes) {
      return incomes.fold(0, (total, t) => total + t.transaction.value);
    }
    return expenses.fold(0, (total, t) => total + t.transaction.value);
  }

  int cashflowForDay(DateTime date) {
    final transactionsForDay =
        transactions.where((t) => t.transaction.date.isSameDay(date));

    return transactionsForDay.fold(0, (total, t) {
      final value = t.transaction.value;
      if (t.transaction.isIncome) return total + value;
      return total - value;
    });
  }
}
